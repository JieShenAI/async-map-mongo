amap_insert \
--db_name map \
--collection_name amap \
--limiter_ratio 50 \
--address_min_length 5 \
--filename not_in_mongo.csv \
--address_col_name 注册地址 \
--max_addresses_num 10000
