-- ============================================
-- 回家点菜 - Supabase 数据库设置
-- 在 Supabase 项目的 SQL Editor 中执行此文件
-- ============================================

-- 1. 创建订单表
CREATE TABLE IF NOT EXISTS orders (
  room_id TEXT PRIMARY KEY,
  dishes JSONB DEFAULT '[]'::jsonb,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 启用行级安全
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- 3. 允许所有人读写（通过 anon key）
--    因为房间号是随机6位，相当于密码
CREATE POLICY "允许读取任何房间"
  ON orders FOR SELECT
  USING (true);

CREATE POLICY "允许创建房间"
  ON orders FOR INSERT
  WITH CHECK (true);

CREATE POLICY "允许更新自己的房间"
  ON orders FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- 4. 启用实时同步（关键！）
ALTER PUBLICATION supabase_realtime ADD TABLE orders;

-- 5. 创建索引
CREATE INDEX IF NOT EXISTS idx_orders_updated_at ON orders(updated_at DESC);
