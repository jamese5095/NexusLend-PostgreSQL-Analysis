-- 【清理环节】如果以前建错或者建乱了，先全部删掉重来（CASCADE 会自动处理外键关联）
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS assets CASCADE;

-- 【Day 1 任务】创建资产表
CREATE TABLE assets (
    asset_id SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    asset_name VARCHAR(50),
    decimals INT DEFAULT 18
);

-- 【Day 2 任务 A】创建用户表
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    wallet_address VARCHAR(42) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 【Day 2 任务 B】创建交易表（通过 REFERENCES 连接另外两张表）
CREATE TABLE transactions (
    tx_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),       -- 连接到用户
    asset_id INT REFERENCES assets(asset_id),    -- 连接到资产
    tx_type VARCHAR(20) CHECK (tx_type IN ('DEPOSIT', 'WITHDRAW', 'BORROW', 'REPAY')),
    amount NUMERIC(78, 0) NOT NULL,
    tx_hash VARCHAR(66) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP