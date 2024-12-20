ALTER TABLE users SET REFERENTIAL_INTEGRITY FALSE;
ALTER TABLE roles SET REFERENTIAL_INTEGRITY FALSE;
ALTER TABLE transactions SET REFERENTIAL_INTEGRITY FALSE;
ALTER TABLE category SET REFERENTIAL_INTEGRITY FALSE;
ALTER TABLE account SET REFERENTIAL_INTEGRITY FALSE;

TRUNCATE TABLE users;
TRUNCATE TABLE roles;
TRUNCATE TABLE transactions;
TRUNCATE TABLE category;
TRUNCATE TABLE account;

ALTER TABLE users SET REFERENTIAL_INTEGRITY TRUE;
ALTER TABLE roles SET REFERENTIAL_INTEGRITY TRUE;
ALTER TABLE transactions SET REFERENTIAL_INTEGRITY TRUE;
ALTER TABLE category SET REFERENTIAL_INTEGRITY TRUE;
ALTER TABLE account SET REFERENTIAL_INTEGRITY TRUE;

-- Users
INSERT INTO users (NAME, EMAIL, PASSWORD, CELLPHONE, PICTURE)
VALUES
('Admin', 'admin@admin.com', '$2a$12$E.GBokDDH4SeVF22dacPpOnzll0ZnbQEexdf3sTcogvw1EJYzH.EK', '999999998', 'admin_pic'),
('Test', 'a@a', '$2a$12$hECHkvkdwCElCi0DUOZz4Ofgpke2E6ssE8o3YlWYug5vBmuksfxvW', '999999994', 'admin_pic'),
('Alice', 'alice@test.com', '$2b$12$ieYk9tpZA45fd/tnosOeZ.t3zkVkNrXwm2ehNyr6QU0Afck73J9Sy', '999999995', 'alice_pic'),
('Bob', 'bob@test.com', '$2b$12$rkB7qfO63uWwJ9KDccT/puXNtQtrT62sXirzJNNkTi1TruRr0NaPW', '999999997', 'bob_pic'),
('Charlie', 'charlie@test.com', '$2b$12$WQozj3UXgRfkxX2yup2pBO4Qgl2Dx.IUm852r11H/JxmZuw9a64da', '999999996', 'charlie_pic'),
('John Doe', 'john@doe.com', '$2b$12$WQozj3UXgRfkxX2yup2pBO4Qgl2Dx.IUm852r11H/JxmZuw9a64da', '11997789485','john_pic');
-- admin_password, 1, alice_password, bob_password, charlie_password

-- Roles
INSERT INTO roles (NAME) VALUES ('ROLE_USER');
INSERT INTO roles (NAME) VALUES ('ROLE_ADMIN');

INSERT INTO user_roles (USER_ID, ROLE_ID)
    VALUES (
        (SELECT id FROM users WHERE email = 'admin@admin.com'),
        (SELECT id FROM roles WHERE name = 'ROLE_ADMIN')
    ),
    (
        (SELECT id FROM users WHERE email = 'a@a'),
        (SELECT id FROM roles WHERE name = 'ROLE_ADMIN')
    );

INSERT INTO user_roles (USER_ID, ROLE_ID)
    VALUES (
        (SELECT id FROM users WHERE email = 'admin@admin.com'),
        (SELECT id FROM roles WHERE name = 'ROLE_USER')
    ),
    (
        (SELECT id FROM users WHERE email = 'a@a'),
        (SELECT id FROM roles WHERE name = 'ROLE_USER')
    );

-- Categories
INSERT INTO category (NAME, USER_FOREING_KEY)
VALUES
('Groceries', (SELECT id FROM users WHERE email = 'admin@admin.com')),
('Entertainment', (SELECT id FROM users WHERE email = 'admin@admin.com')),
('Utilities', (SELECT id FROM users WHERE email = 'admin@admin.com')),
('Groceries', (SELECT id FROM users WHERE email = 'a@a')),
('Entertainment', (SELECT id FROM users WHERE email = 'a@a')),
('Utilities', (SELECT id FROM users WHERE email = 'a@a')),
('Groceries', (SELECT id FROM users WHERE email = 'alice@test.com')),
('Entertainment', (SELECT id FROM users WHERE email = 'alice@test.com')),
('Utilities', (SELECT id FROM users WHERE email = 'alice@test.com')),
('Groceries', (SELECT id FROM users WHERE email = 'bob@test.com')),
('Entertainment', (SELECT id FROM users WHERE email = 'bob@test.com')),
('Utilities', (SELECT id FROM users WHERE email = 'bob@test.com')),
('Groceries', (SELECT id FROM users WHERE email = 'charlie@test.com')),
('Entertainment', (SELECT id FROM users WHERE email = 'charlie@test.com')),
('Utilities', (SELECT id FROM users WHERE email = 'charlie@test.com')),
('Tecnologia', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Educação', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Finanças', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Saúde', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Entretenimento', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Esportes', (SELECT id FROM users WHERE email = 'john@doe.com'));

-- Accounts
INSERT INTO account (NAME, USER_FOREING_KEY)
VALUES
('Admin Checking', (SELECT id FROM users WHERE email = 'admin@admin.com')),
('Test Checking', (SELECT id FROM users WHERE email = 'a@a')),
('Alice Checking', (SELECT id FROM users WHERE email = 'alice@test.com')),
('Bob Checking', (SELECT id FROM users WHERE email = 'bob@test.com')),
('Charlie Checking', (SELECT id FROM users WHERE email = 'charlie@test.com')),
('Conta Banco', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Carteira', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Poupança', (SELECT id FROM users WHERE email = 'john@doe.com')),
('Cartão de Crédito', (SELECT id FROM users WHERE email = 'john@doe.com'));

-- Transactions for admin@admin.com
INSERT INTO transactions (AMOUNT, HAPPENED_ON, CREATED_ON, USER_ID, CATEGORY_ID, ACCOUNT_ID)
VALUES
(10.00, '2024-11-25T08:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'admin@admin.com'),
 (SELECT id FROM category WHERE NAME = 'Groceries' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'admin@admin.com')),
 (SELECT id FROM account WHERE NAME = 'Admin Checking')),
(15.00, '2024-11-24T14:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'admin@admin.com'),
 (SELECT id FROM category WHERE NAME = 'Entertainment' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'admin@admin.com')),
 (SELECT id FROM account WHERE NAME = 'Admin Checking')),
(20.00, '2024-11-23T12:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'admin@admin.com'),
 (SELECT id FROM category WHERE NAME = 'Utilities' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'admin@admin.com')),
 (SELECT id FROM account WHERE NAME = 'Admin Checking')),
(25.00, '2024-11-22T10:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'admin@admin.com'),
 (SELECT id FROM category WHERE NAME = 'Groceries' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'admin@admin.com')),
 (SELECT id FROM account WHERE NAME = 'Admin Checking'));

-- Transactions for a@a
INSERT INTO transactions (AMOUNT, HAPPENED_ON, CREATED_ON, USER_ID, CATEGORY_ID, ACCOUNT_ID)
VALUES
(5.00, '2024-11-25T08:30', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'a@a'),
 (SELECT id FROM category WHERE NAME = 'Groceries' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'a@a')),
 (SELECT id FROM account WHERE NAME = 'Test Checking')),
(7.50, '2024-11-24T15:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'a@a'),
 (SELECT id FROM category WHERE NAME = 'Entertainment' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'a@a')),
 (SELECT id FROM account WHERE NAME = 'Test Checking')),
(12.00, '2024-11-23T10:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'a@a'),
 (SELECT id FROM category WHERE NAME = 'Utilities' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'a@a')),
 (SELECT id FROM account WHERE NAME = 'Test Checking')),
(9.00, '2024-11-22T11:00', CURRENT_TIMESTAMP,
 (SELECT id FROM users WHERE email = 'a@a'),
 (SELECT id FROM category WHERE NAME = 'Groceries' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'a@a')),
 (SELECT id FROM account WHERE NAME = 'Test Checking'));

-- Transactions for john doe
-- Transactions for john doe
INSERT INTO transactions (AMOUNT, HAPPENED_ON, CREATED_ON, USER_ID, CATEGORY_ID, ACCOUNT_ID, DESCRIPTION)
VALUES
(392.69, '2024-11-18T01:25', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Finanças' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Conta Banco'), 'Pagamento de transporte'),
(-831.73, '2024-11-16T14:10', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Educação' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Consulta odontológica'),
(-442.00, '2024-11-27T14:11', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Finanças' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Investimento em ações'),
(-887.80, '2024-11-12T13:16', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Esportes' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Consulta médica'),
(668.33, '2024-11-25T12:37', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Cartão de Crédito'), 'Pagamento de mensalidade'),
(146.22, '2024-11-07T11:35', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Saúde' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Compra de eletrônicos'),
(188.46, '2024-11-02T11:44', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Compra de eletrônicos'),
(-753.84, '2024-11-14T19:24', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Cartão de Crédito'), 'Investimento em ações'),
(-264.41, '2024-11-05T04:17', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Gastos com academia'),
(-380.51, '2024-11-03T01:04', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Educação' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Curso online'),
(-459.78, '2024-11-06T20:52', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Finanças' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Compra de medicamentos'),
(-733.91, '2024-11-20T21:55', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Compra de presentes'),
(-730.36, '2024-11-13T16:51', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Educação' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Cartão de Crédito'), 'Viagem de fim de semana'),
(-678.29, '2024-11-09T09:36', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Finanças' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Cartão de Crédito'), 'Compra de roupas'),
(-273.12, '2024-11-15T16:03', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Compra de materiais esportivos'),
(907.27, '2024-11-29T12:00', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Finanças' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Cartão de Crédito'), 'Compra de presentes'),
(-592.74, '2024-11-11T06:13', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Esportes' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Conta Banco'), 'Investimento em ações'),
(944.21, '2024-11-21T16:42', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Esportes' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Pagamento de mensalidade'),
(491.02, '2024-11-13T00:05', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Café com amigos'),
(-326.55, '2024-11-21T04:04', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Pagamento de transporte'),
(-523.36, '2024-11-05T07:11', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Compra de materiais esportivos'),
(607.03, '2024-11-03T19:33', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Cartão de Crédito'), 'Transferência bancária'),
(671.40, '2024-11-10T21:55', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Esportes' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Conta Banco'), 'Pagamento de mensalidade'),
(134.03, '2024-11-26T10:28', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Reserva de hotel'),
(-400.85, '2024-11-16T21:07', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Doação para instituição'),
(21.96, '2024-11-17T17:55', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Manutenção do carro'),
(-281.24, '2024-11-23T03:38', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Compra de aplicativos'),
(-92.40, '2024-11-28T08:31', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Tecnologia' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Carteira'), 'Pagamento de transporte'),
(389.36, '2024-11-25T16:31', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Entretenimento' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Conta Banco'), 'Pagamento de mensalidade'),
(-592.35, '2024-11-28T11:46', CURRENT_TIMESTAMP, (SELECT id FROM users WHERE email = 'john@doe.com'), (SELECT id FROM category WHERE NAME = 'Saúde' AND USER_FOREING_KEY = (SELECT id FROM users WHERE email = 'john@doe.com')), (SELECT id FROM account WHERE NAME = 'Poupança'), 'Compra de medicamentos'); 