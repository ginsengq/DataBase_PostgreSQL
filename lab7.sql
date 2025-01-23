CREATE INDEX idx_product_name ON products (product_name);

CREATE INDEX idx_customer_names ON customers (first_name, last_name);

CREATE UNIQUE INDEX idx_unique_order_total ON orders (order_total);

CREATE INDEX idx_lower_email ON customers (LOWER(email));

CREATE INDEX idx_order_total_quantity ON orders (order_total);
CREATE INDEX idx_order_items_quantity ON order_items (quantity);
