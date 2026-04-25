-- ============================================
-- 回家点菜 - Supabase 数据库设置
-- 在 Supabase 项目 SQL Editor 中执行
-- ============================================

-- 1. 创建/更新订单表
CREATE TABLE IF NOT EXISTS orders (
  room_id TEXT PRIMARY KEY,
  dishes JSONB DEFAULT '{}'::jsonb,
  custom_menu JSONB DEFAULT '[]'::jsonb,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 如果表已存在但没有这些列，手动执行下面几行：
-- ALTER TABLE orders ADD COLUMN IF NOT EXISTS custom_menu JSONB DEFAULT '[]'::jsonb;
-- ALTER TABLE orders ADD COLUMN IF NOT EXISTS chat_messages JSONB DEFAULT '[]'::jsonb;

-- 3. 启用行级安全
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- 4. 允许所有人读写
CREATE POLICY IF NOT EXISTS "allow_all" ON orders FOR SELECT USING (true);
CREATE POLICY IF NOT EXISTS "allow_insert" ON orders FOR INSERT WITH CHECK (true);
CREATE POLICY IF NOT EXISTS "allow_update" ON orders FOR UPDATE USING (true) WITH CHECK (true);

-- 5. 启用实时同步
ALTER PUBLICATION supabase_realtime ADD TABLE orders;
