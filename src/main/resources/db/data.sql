-- ================================================
-- Sample Data for Shop Mẹ và Bé 🍼👶
-- ================================================
-- Dữ liệu mẫu cho hệ thống Cửa hàng Mẹ và Bé
-- ================================================

-- Clear existing data (optional, use with caution)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE order_details;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE categories;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- ================================================
-- Insert Users (Admin và Khách hàng mẫu)
-- Password: admin123 (đã mã hóa bằng BCrypt)
-- ================================================
INSERT INTO users (id, full_name, email, password, phone, address, role, enabled, created_at, updated_at) VALUES
(1, 'Admin Shop Mẹ và Bé', 'admin@shopmevabe.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '0909123456', 'Hồ Chí Minh', 'ADMIN', TRUE, NOW(), NOW()),
(2, 'Nguyễn Thị Mai', 'mai.nguyen@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '0901234567', 'Quận 1, TP.HCM', 'CUSTOMER', TRUE, NOW(), NOW()),
(3, 'Trần Văn Hùng', 'hung.tran@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '0912345678', 'Quận 3, TP.HCM', 'CUSTOMER', TRUE, NOW(), NOW()),
(4, 'Lê Thị Lan', 'lan.le@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '0923456789', 'Quận Bình Thạnh, TP.HCM', 'CUSTOMER', TRUE, NOW(), NOW()),
(5, 'Phạm Minh Tuấn', 'tuan.pham@gmail.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '0934567890', 'Quận 7, TP.HCM', 'CUSTOMER', TRUE, NOW(), NOW());

-- ================================================
-- Insert Categories (Danh mục sản phẩm)
-- ================================================
INSERT INTO categories (id, name, description, active, created_at, updated_at) VALUES
(1, 'Sữa bột cho bé', 'Sữa bột dinh dưỡng cho trẻ từ 0-6 tuổi các thương hiệu uy tín', TRUE, NOW(), NOW()),
(2, 'Tã bỉm', 'Tã bỉm cao cấp cho bé từ sơ sinh đến 3 tuổi', TRUE, NOW(), NOW()),
(3, 'Đồ chơi trẻ em', 'Đồ chơi an toàn, phát triển trí tuệ cho bé', TRUE, NOW(), NOW()),
(4, 'Quần áo trẻ em', 'Quần áo cotton mềm mại cho bé yêu', TRUE, NOW(), NOW()),
(5, 'Xe đẩy - Nôi - Ghế ngồi', 'Xe đẩy, nôi, ghế ngồi an toàn cho bé', TRUE, NOW(), NOW()),
(6, 'Đồ dùng cho mẹ', 'Sản phẩm hỗ trợ mẹ bầu và sau sinh', TRUE, NOW(), NOW()),
(7, 'Thực phẩm dinh dưỡng', 'Bột ăn dặm, cháo dinh dưỡng cho bé', TRUE, NOW(), NOW()),
(8, 'Đồ dùng tắm gội', 'Sản phẩm tắm gội an toàn cho làn da nhạy cảm', TRUE, NOW(), NOW());

-- ================================================
-- Insert Products (Sản phẩm cho Mẹ và Bé)
-- ================================================

-- Sữa bột cho bé (Category 1)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(1, 'Sữa Enfamil A+ 1 - 900g', 'Sữa bột Enfamil A+ công thức Neuro Pro giúp phát triển trí não và tăng cường miễn dịch cho bé 0-6 tháng', 520000, 100, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762785654/products/products/98ca7377-919a-4759-b5c2-24d99cf16768.webp', TRUE, 1, NOW(), NOW()),
(2, 'Sữa Aptamil Úc số 1 - 900g', 'Sữa Aptamil Úc công thức ProNutra giúp hệ tiêu hóa khỏe mạnh cho bé 0-6 tháng', 680000, 80, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762785677/products/products/5b8de48c-6f43-452c-9a95-78303acd258e.jpg', TRUE, 1, NOW(), NOW()),
(3, 'Sữa Similac IQ 2 - 900g', 'Sữa Similac IQ Plus HMO giúp phát triển não bộ và tăng cường miễn dịch cho bé 6-12 tháng', 490000, 120, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786431/products/products/e414f176-7689-47d6-aca8-e61873176869.webp', TRUE, 1, NOW(), NOW()),
(4, 'Sữa Vinamilk Optimum Gold 3 - 850g', 'Sữa Vinamilk Optimum Gold với HMO+ giúp bé 1-2 tuổi phát triển toàn diện', 425000, 150, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786517/products/products/93993eac-b3aa-45de-b023-79782fffb118.webp', TRUE, 1, NOW(), NOW()),
(5, 'Sữa NAN Optipro 4 - 900g', 'Sữa NAN Optipro 4 công thức BL Probiotics cho bé trên 2 tuổi', 455000, 90, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786564/products/products/684e1fb3-a422-45ef-8930-c92dbd16c5ee.webp', TRUE, 1, NOW(), NOW());

-- Tã bỉm (Category 2)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(6, 'Tã Bobby Extra Soft Dry NB - 84 miếng', 'Tã Bobby Extra Soft Dry siêu thấm hút cho bé sơ sinh dưới 5kg', 189000, 200, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786599/products/products/4bb77b13-5419-435f-8458-501d1810a24f.jpg', TRUE, 2, NOW(), NOW()),
(7, 'Tã Pampers Premium S - 84 miếng', 'Tã Pampers Premium Care siêu mềm mại cho bé 3-8kg', 265000, 180, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786676/products/products/76e9fb00-2c9e-4697-9f42-7cf17199f37a.webp', TRUE, 2, NOW(), NOW()),
(8, 'Tã Merries M - 64 miếng', 'Tã dán Merries cao cấp Nhật Bản cho bé 6-11kg', 315000, 150, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786703/products/products/91136c4b-2cb2-4738-93d1-15709cbff789.jpg', TRUE, 2, NOW(), NOW()),
(9, 'Tã quần Moony L - 44 miếng', 'Tã quần Moony siêu thoáng khí cho bé 9-14kg', 289000, 120, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786793/products/products/e738cbba-b566-4f2a-b20b-513eb448ab33.png', TRUE, 2, NOW(), NOW()),
(10, 'Tã Huggies Dry Pants XL - 54 miếng', 'Tã quần Huggies khô thoáng cho bé 12-17kg', 245000, 160, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786823/products/products/a4b06da9-cd4a-4ac4-aac0-e3e0ad7ef870.jpg', TRUE, 2, NOW(), NOW());

-- Đồ chơi trẻ em (Category 3)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(11, 'Xúc xắc cho bé Winfun', 'Bộ 5 xúc xắc nhiều màu sắc giúp phát triển giác quan cho bé từ 3 tháng', 125000, 80, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786856/products/products/1000ebb7-207b-4bea-ad53-cf08449f7a22.webp', TRUE, 3, NOW(), NOW()),
(12, 'Bộ đồ chơi âm nhạc 5 món', 'Bộ đồ chơi nhạc cụ phát triển tính sáng tạo cho bé từ 6 tháng', 235000, 60, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786888/products/products/ee2ee625-0baf-49f0-af43-5f09d01678d4.jpg', TRUE, 3, NOW(), NOW()),
(13, 'Bộ xếp hình gỗ Montessori', 'Bộ xếp hình gỗ cao cấp phát triển tư duy logic cho bé 1-3 tuổi', 350000, 45, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786924/products/products/25582456-1112-43ed-accf-f1d5fe15bef7.webp', TRUE, 3, NOW(), NOW()),
(14, 'Xe máy điện trẻ em 3 bánh', 'Xe máy điện an toàn có nhạc và đèn cho bé từ 1-4 tuổi', 1250000, 25, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786953/products/products/b70b1ede-39f7-429e-8590-5622d2c2a14b.webp', TRUE, 3, NOW(), NOW()),
(15, 'Bộ lego duplo 100 chi tiết', 'Bộ lego duplo lớn an toàn cho bé từ 18 tháng', 580000, 50, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762786981/products/products/0c4bace6-86c8-473e-9f4c-a4a276f506ba.webp', TRUE, 3, NOW(), NOW());

-- Quần áo trẻ em (Category 4)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(16, 'Bộ body suit cotton cho bé 0-6 tháng', 'Set 5 bộ body suit 100% cotton mềm mại cho bé sơ sinh', 285000, 100, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787018/products/products/18fe77c0-1291-4a16-a9c6-030ef7eb46c8.webp', TRUE, 4, NOW(), NOW()),
(17, 'Áo liền quần họa tiết dễ thương', 'Áo liền quần cotton cao cấp nhiều màu sắc cho bé 3-12 tháng', 165000, 120, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787071/products/products/45fcc738-42c2-4106-8a08-02febd5e0739.webp', TRUE, 4, NOW(), NOW()),
(18, 'Bộ quần áo thu đông cho bé', 'Bộ quần áo cotton lót nỉ ấm áp cho bé 1-3 tuổi', 215000, 90, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787117/products/products/eae0208b-1d97-4b3f-ac6c-0edfac07cd6c.jpg', TRUE, 4, NOW(), NOW()),
(19, 'Váy công chúa cho bé gái', 'Váy xinh xắn phối ren cho bé gái 1-5 tuổi', 195000, 70, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787185/products/products/5a00998f-c8fd-4569-9069-3369a304d5f7.webp', TRUE, 4, NOW(), NOW()),
(20, 'Bộ đồ thể thao cho bé trai', 'Bộ đồ thể thao năng động cho bé trai 2-6 tuổi', 185000, 85, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787221/products/products/8e98e9f4-e336-4e79-bf36-260e5c1ad10b.webp', TRUE, 4, NOW(), NOW());

-- Xe đẩy - Nôi - Ghế ngồi (Category 5)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(21, 'Xe đẩy 2 chiều Seebaby Q5', 'Xe đẩy 2 chiều cao cấp có mái che UV cho bé 0-3 tuổi', 2450000, 30, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787255/products/products/5651b020-9f30-4235-8566-24e688032eb0.webp', TRUE, 5, NOW(), NOW()),
(22, 'Nôi điện tự động Mamakids', 'Nôi điện đa năng có nhạc ru và điều khiển từ xa', 3250000, 20, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787289/products/products/68d5af91-b0e9-4b60-b30b-0c2a2673df8f.jpg', TRUE, 5, NOW(), NOW()),
(23, 'Ghế ăn dặm Mastela 3 in 1', 'Ghế ăn dặm điều chỉnh độ cao, gấp gọn tiện lợi', 1850000, 40, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787333/products/products/6a52447e-ae03-4fd8-8574-950de0390d72.jpg', TRUE, 5, NOW(), NOW()),
(24, 'Ghế ngồi ô tô Aprica 360 độ', 'Ghế ngồi ô tô xoay 360 độ cho bé 0-7 tuổi', 4850000, 15, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787393/products/products/96567122-4d28-4774-a0a5-5d80064f10c8.jpg', TRUE, 5, NOW(), NOW()),
(25, 'Nôi xách tay Graco', 'Nôi xách tay nhẹ gọn, tiện lợi cho bé sơ sinh', 1250000, 35, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787432/products/products/02d25a31-b86e-4978-91fb-c9b36f93e2b4.webp', TRUE, 5, NOW(), NOW());

-- Đồ dùng cho mẹ (Category 6)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(26, 'Máy hút sữa điện đôi Real Bubble', 'Máy hút sữa điện đôi massage mô phỏng bú của bé', 1680000, 50, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787461/products/products/b6f6a29c-1088-4a06-9216-f2452e0a5b16.jpg', TRUE, 6, NOW(), NOW()),
(27, 'Túi trữ sữa Unimom 210ml', 'Hộp 50 túi trữ sữa an toàn không BPA', 145000, 100, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787504/products/products/ff23c401-eb55-4aec-9f53-56205fa88597.webp', TRUE, 6, NOW(), NOW()),
(28, 'Áo lót cho mẹ bầu và sau sinh', 'Bộ 3 áo lót cotton thoáng mát cho mẹ', 285000, 80, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787552/products/products/886c1044-9cd0-403e-925d-df41b93fe8c5.webp', TRUE, 6, NOW(), NOW()),
(29, 'Gối bầu đa năng Mamaway', 'Gối bầu đa năng giúp mẹ ngủ ngon và cho con bú', 685000, 45, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787600/products/products/01a060a4-7284-45e8-afca-3c5737133924.jpg', TRUE, 6, NOW(), NOW()),
(30, 'Vitamin tổng hợp cho mẹ bầu Elevit', 'Vitamin và khoáng chất thiết yếu cho mẹ và bé', 520000, 60, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787663/products/products/fa4491ef-d48d-4d7a-a3b4-ff69425269a4.webp', TRUE, 6, NOW(), NOW());

-- Thực phẩm dinh dưỡng (Category 7)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(31, 'Bột ăn dặm Ridielac Alpha Gold - 200g', 'Bột ăn dặm dinh dưỡng cho bé từ 6 tháng', 98000, 150, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787686/products/products/4c711f5d-7c46-4d7d-87ae-ffaba50b9ad7.jpg', TRUE, 7, NOW(), NOW()),
(32, 'Cháo ăn liền Wakodo vị cá hồi - 80g', 'Cháo ăn liền Nhật Bản cho bé từ 7 tháng', 45000, 200, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787721/products/products/f07aead6-e9f1-4a5f-bd8e-a713b53cb635.png', TRUE, 7, NOW(), NOW()),
(33, 'Bánh ăn dặm Pigeon gạo lứt - 50g', 'Bánh ăn dặm tan trong miệng cho bé từ 6 tháng', 55000, 180, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787774/products/products/7ed1946b-249c-44bd-93ba-5f348aa0b498.jpg', TRUE, 7, NOW(), NOW()),
(34, 'Sữa chua cho bé Dutch Lady - 100g x 4', 'Sữa chua dinh dưỡng cho bé từ 1 tuổi', 36000, 220, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787813/products/products/d204b522-8d19-4585-80d3-f5016fcd3c66.webp', TRUE, 7, NOW(), NOW()),
(35, 'Váng sữa Bledina vị cam - 100g x 4', 'Váng sữa Pháp bổ sung canxi cho bé', 125000, 130, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787838/products/products/6220c2bd-36ab-4c2e-9aa1-d0fa7f0b6660.webp', TRUE, 7, NOW(), NOW());

-- Đồ dùng tắm gội (Category 8)
INSERT INTO products (id, name, description, price, stock_quantity, image_url, active, category_id, created_at, updated_at) VALUES
(36, 'Tắm gội Kodomo 200ml', 'Sữa tắm gội 2 trong 1 cho bé từ 0 tháng', 89000, 120, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787866/products/products/b40c1cfd-94db-440c-a473-e34a20864bad.webp', TRUE, 8, NOW(), NOW()),
(37, 'Dầu gội Johnson Baby 500ml', 'Dầu gội không cay mắt cho bé', 125000, 150, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787893/products/products/77d2e803-206b-4071-8e8c-2b808a1dee7a.jpg', TRUE, 8, NOW(), NOW()),
(38, 'Sữa tắm Lactacyd Baby 250ml', 'Sữa tắm pH cân bằng cho da nhạy cảm', 105000, 100, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787919/products/products/87e4d9e8-003c-4809-ab7d-d37752fada1d.webp', TRUE, 8, NOW(), NOW()),
(39, 'Khăn tắm xô cao cấp 6 lớp', 'Khăn tắm 100% cotton mềm mịn cho bé', 135000, 90, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787948/products/products/cc02c24f-a477-45b9-b348-3382e253191a.jpg', TRUE, 8, NOW(), NOW()),
(40, 'Chậu tắm kèm giá đỡ Babycute', 'Chậu tắm có giá đỡ an toàn cho bé sơ sinh', 385000, 60, 'https://res.cloudinary.com/dubthm5m6/image/upload/v1762787991/products/products/fa0c1925-904e-4e0d-a3e0-587dab3d5ee8.webp', TRUE, 8, NOW(), NOW());

-- ================================================
-- Insert Sample Orders
-- ================================================

-- Order 1: Nguyễn Thị Mai
INSERT INTO orders (id, user_id, order_date, total_amount, status, shipping_address, phone, notes, payment_method, payment_status, transaction_id, created_at, updated_at) VALUES
(1, 2, '2025-10-15 10:30:00', 1455000, 'DELIVERED', 'Quận 1, TP.HCM', '0901234567', 'Giao giờ hành chính', 'MOMO', 'PAID', 'MOMO202510151030', '2025-10-15 10:30:00', '2025-10-20 14:30:00');

INSERT INTO order_details (order_id, product_id, quantity, unit_price, subtotal) VALUES
(1, 1, 2, 520000, 1040000),  -- Sữa Enfamil A+ 1 x 2
(1, 7, 1, 265000, 265000),   -- Tã Pampers Premium S x 1
(1, 36, 1, 89000, 89000),    -- Tắm gội Kodomo x 1
(1, 31, 1, 98000, 98000);    -- Bột ăn dặm x 1

-- Order 2: Trần Văn Hùng
INSERT INTO orders (id, user_id, order_date, total_amount, status, shipping_address, phone, notes, payment_method, payment_status, transaction_id, created_at, updated_at) VALUES
(2, 3, '2025-10-20 14:20:00', 5100000, 'SHIPPED', 'Quận 3, TP.HCM', '0912345678', 'Gọi trước khi giao', 'COD', 'UNPAID', NULL, '2025-10-20 14:20:00', '2025-10-22 09:00:00');

INSERT INTO order_details (order_id, product_id, quantity, unit_price, subtotal) VALUES
(2, 21, 1, 2450000, 2450000),  -- Xe đẩy Seebaby Q5 x 1
(2, 23, 1, 1850000, 1850000),  -- Ghế ăn dặm Mastela x 1
(2, 8, 2, 315000, 630000),     -- Tã Merries M x 2
(2, 11, 1, 125000, 125000);    -- Xúc xắc Winfun x 1

-- Order 3: Lê Thị Lan
INSERT INTO orders (id, user_id, order_date, total_amount, status, shipping_address, phone, notes, payment_method, payment_status, transaction_id, created_at, updated_at) VALUES
(3, 4, '2025-10-25 09:15:00', 2565000, 'PROCESSING', 'Quận Bình Thạnh, TP.HCM', '0923456789', 'Giao buổi chiều', 'MOMO', 'PAID', 'MOMO202510250915', '2025-10-25 09:15:00', '2025-10-25 09:15:00');

INSERT INTO order_details (order_id, product_id, quantity, unit_price, subtotal) VALUES
(3, 26, 1, 1680000, 1680000),  -- Máy hút sữa điện đôi x 1
(3, 29, 1, 685000, 685000),    -- Gối bầu đa năng x 1
(3, 27, 1, 145000, 145000);    -- Túi trữ sữa x 1

-- Order 4: Phạm Minh Tuấn
INSERT INTO orders (id, user_id, order_date, total_amount, status, shipping_address, phone, notes, payment_method, payment_status, created_at, updated_at) VALUES
(4, 5, '2025-10-28 16:45:00', 890000, 'PENDING', 'Quận 7, TP.HCM', '0934567890', '', 'COD', 'UNPAID', '2025-10-28 16:45:00', '2025-10-28 16:45:00');

INSERT INTO order_details (order_id, product_id, quantity, unit_price, subtotal) VALUES
(4, 3, 1, 490000, 490000),    -- Sữa Similac IQ 2 x 1
(4, 10, 1, 245000, 245000),   -- Tã Huggies XL x 1
(4, 37, 1, 125000, 125000);   -- Dầu gội Johnson x 1

-- ================================================
-- Reset Auto Increment (Optional)
-- ================================================
ALTER TABLE users AUTO_INCREMENT = 6;
ALTER TABLE categories AUTO_INCREMENT = 9;
ALTER TABLE products AUTO_INCREMENT = 41;
ALTER TABLE orders AUTO_INCREMENT = 5;
ALTER TABLE order_details AUTO_INCREMENT = 100;

-- ================================================
-- End of Sample Data
-- ================================================
-- 🎉 Dữ liệu mẫu đã được import thành công!
-- Tài khoản admin: admin@shopmevabe.com / admin123
-- Tài khoản khách hàng: mai.nguyen@gmail.com / admin123
-- ================================================
