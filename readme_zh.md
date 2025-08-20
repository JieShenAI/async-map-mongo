[English](./README.md)

## 简介

async 异步调用高德地图的API获取对应的经纬度地址，API调用的结果保存在 Mongo 数据库。
提供excel从Mongo数据库中查询出经纬度并导出excel。

高德地图调用接口：
https://restapi.amap.com/v3/geocode/geo?address=北京市朝阳区阜通东大街6号&output=XML&key=<用户的key>

## 用法

高德地图的key可保存在.env文件中：

```
api_key=高德地图API密钥
```

调用高德地图API，保存经纬度信息到Mongo数据库：
```shell
amap_insert \
--db_name map \
--collection_name amap \
--limiter_ratio 2.8 \
--address_min_length 5 \
--filename data/excel_name.xlsx \
--address_col_name address \
--address_clean true \
--max_addresses_num 1000 \
```

收集 address 这个属性列所有的地址，然后筛选出在数据库中不存在的地址，再针对剩下的地址调用高德地图获取经纬度
- filename: excel或者csv文件;
- address_col_name: 地址对应的属性名；
- limiter_ratio: 每秒的API调用速度限制；
- max_addresses_num: 最高调用1000次高德地图API；
- address_min_length：有效地址的最小长度，字符串长度小于address_min_length的地址不会调用API；

数据库储存的数据格式：
![](https://gitee.com/jieshenai/imags/raw/master/Typora/20250820144056211.png)

根据提供的表格，从Mongo数据库中查询出经纬度并导出为excel：
```shell
amap_export \
--db_name map \
--collection_name amap \
--address_min_length 5 \
--filename data/excel_name.xlsx \
--address_col_name address \
--address_clean true \
--output_type csv \
--output_dir output
```

- address_clean：是否删除地址中文括号包裹的文本，true表示删除，false表示不删除;
- output_type: 导出的格式默认为csv;

## API调用扩展性
虽然默认支持的是高德地图API经纬度调用，百度地图可考虑通过更换base_url参数实现调用。
其他API接口的调用与相应的处理，请修改 AsyncMapCall.__call_api 的代码。
