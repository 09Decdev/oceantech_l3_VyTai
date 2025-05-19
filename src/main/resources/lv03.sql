USE lv3_test;

CREATE TABLE tbl_role
(
    id         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code       VARCHAR(225),
    name       VARCHAR(225),
    status     INT      default 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    created_by VARCHAR(225),
    updated_by VARCHAR(225),
    deleted    BIT      default 0
);

CREATE TABLE tbl_user
(
    id         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code       VARCHAR(225),
    name       VARCHAR(225),
    password   VARCHAR(225),
    username   VARCHAR(225),
    status     INT      default 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    created_by VARCHAR(225),
    updated_by VARCHAR(225),
    deleted    BIT      default 0
);

CREATE TABLE tbl_user_roles
(
    user_id BIGINT UNSIGNED,
    role_id BIGINT UNSIGNED,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES tbl_user (id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES tbl_role (id) ON DELETE CASCADE
);

CREATE TABLE tbl_team
(
    id         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code       VARCHAR(225),
    name       VARCHAR(225),
    status     INT      default 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    created_by VARCHAR(225),
    updated_by VARCHAR(225),
    deleted    BIT      default 0
);

CREATE TABLE tbl_employee_profile
(
    id         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    team_id    BIGINT UNSIGNED,
    code       VARCHAR(225),
    name VARCHAR(225),
    gender     INT,
    dob       DATE,
    address    VARCHAR(550),
    avatar     VARCHAR(550),
    identity   VARCHAR(50),
    phone      VARCHAR(50),
    email      VARCHAR(225),
    status     INT      default 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    created_by VARCHAR(225),
    updated_by VARCHAR(225),
    deleted    BIT      default 0
);

CREATE TABLE tbl_certificate
(
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id BIGINT UNSIGNED,
    code        VARCHAR(225),
    name        VARCHAR(550),
    issue_date  DATE,
    content     VARCHAR(550),
    field       VARCHAR(225),
    status      INT      default 0,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME,
    created_by  VARCHAR(225),
    updated_by  VARCHAR(225),
    deleted     BIT      default 0
);

CREATE TABLE tbl_family_relationship
(
    id           BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id  BIGINT UNSIGNED,
    code         VARCHAR(225),
    first_name   VARCHAR(225),
    last_name    VARCHAR(225),
    gender       INT,
    date         DATE,
    address      VARCHAR(550),
    identity     VARCHAR(50),
    relationship VARCHAR(225),
    status       INT      default 0,
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME,
    created_by   VARCHAR(225),
    updated_by   VARCHAR(225),
    deleted      BIT      default 0
);

CREATE TABLE tbl_type_form
(
    id         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code       VARCHAR(225),
    name       VARCHAR(225),
    status     INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    created_by VARCHAR(225),
    updated_by VARCHAR(225),
    deleted    BIT      DEFAULT 0
);

CREATE TABLE tbl_register_form
(
    id               BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    manager_id       BIGINT UNSIGNED,
    leader_id        BIGINT UNSIGNED,
    employee_id      BIGINT UNSIGNED,
    type_id          BIGINT UNSIGNED,
    code             VARCHAR(225),
    propose_date     DATE,
    content          TEXT,
    approval_date    DATE,
    appointment_date DATETIME,
    description      VARCHAR(500),
    status           INT,
    reason_reject    TEXT,
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at       DATETIME,
    created_by       VARCHAR(225),
    updated_by       VARCHAR(225),
    deleted          BIT      DEFAULT 0
);

CREATE TABLE tbl_invalidated_token
(
    id          VARCHAR(225) PRIMARY KEY,
    expiry_time DATETIME
);



ALTER TABLE tbl_family_relationship
    ADD CONSTRAINT fk_tbl_employee_profile_relation FOREIGN KEY (employee_id) REFERENCES tbl_employee_profile (id) ON DELETE CASCADE;

ALTER TABLE tbl_certificate
    ADD CONSTRAINT fk_tbl_employee_profile_certificate FOREIGN KEY (employee_id) REFERENCES tbl_employee_profile (id) ON DELETE CASCADE;

ALTER TABLE tbl_employee_profile
    ADD CONSTRAINT fk_tbl_team FOREIGN KEY (team_id) REFERENCES tbl_team (id) ON DELETE CASCADE;

ALTER TABLE tbl_register_form
    ADD CONSTRAINT fk_tbl_register_form_manager FOREIGN KEY (manager_id) REFERENCES tbl_user (id) ON DELETE CASCADE;

ALTER TABLE tbl_register_form
    ADD CONSTRAINT fk_tbl_register_form_leader FOREIGN KEY (leader_id) REFERENCES tbl_user (id) ON DELETE CASCADE;

ALTER TABLE tbl_register_form
    ADD CONSTRAINT fk_tbl_register_form_employee FOREIGN KEY (employee_id) REFERENCES tbl_employee_profile (id) ON DELETE CASCADE;

ALTER TABLE tbl_register_form
    ADD CONSTRAINT fk_tbl_register_form_type FOREIGN KEY (type_id) REFERENCES tbl_type_form (id) ON DELETE CASCADE;

INSERT INTO tbl_role (code, name, status, deleted)
VALUES ('ROLE1', 'MANAGER', 0, 0),
       ('ROLE2', 'LEADER', 0, 0),
       ('ROLE3','EMPLOYEE',0,0);

INSERT INTO tbl_team(code, name)
VALUES ('TEAM1', 'IT'),
       ('TEAM2', 'SALE');

INSERT INTO tbl_employee_profile(team_id, code,name, gender, dob, address, avatar, identity, phone,
                                 email)
VALUES (1, 'EPL1', 'Nguyễn Tuấn Tài', 0, '2003-12-21', 'Hà Nội', 'default', '0123456789', '0325761818',
        'tuantain@gmail.com'),
       (2, 'EPL2', 'Nguyễn Tuấn Tú', 0, '1999-04-05', 'Hà Nội', 'default', '0123456789', '0369849958',
        'tuantun1999@gmail.com');

USE lv3;
INSERT INTO tbl_user (code, name, password, username, status, created_by, deleted)
VALUES
    ('U001', 'Nguyễn Văn A', '******', 'manager01', 1, 'system', 0),
    ('U002', 'Trần Thị B', '******', 'leader01', 1, 'system', 0),
    ('U003', 'Lê Văn C', '******', 'employee01', 1, 'system', 0);


-- U001 là MANAGER
INSERT INTO tbl_user_roles (user_id, role_id) VALUES (1, 1);
-- U002 là LEADER
INSERT INTO tbl_user_roles (user_id, role_id) VALUES (2, 2);
-- U003 là EMPLOYEE
INSERT INTO tbl_user_roles (user_id, role_id) VALUES (3, 3);


INSERT INTO tbl_certificate (employee_id, code, name, issue_date, content, field, deleted)
VALUES
    (1, 'CERT001', 'Chứng chỉ Java', '2022-05-01', 'Chứng chỉ Java cơ bản', 'Lập trình', 0),
    (2, 'CERT002', 'Chứng chỉ Bán hàng', '2021-08-15', 'Đào tạo kỹ năng bán hàng', 'Sales', 0);

INSERT INTO tbl_family_relationship (employee_id, code, first_name, last_name, gender, date, address, identity, relationship, created_by, deleted)
VALUES
    (1, 'FAM001', 'Nguyễn', 'Văn Bố', 0, '1970-01-01', 'Hà Nội', '123456789', 'Cha', 'system', 0),
    (1, 'FAM002', 'Nguyễn', 'Thị Mẹ', 1, '1972-02-02', 'Hà Nội', '987654321', 'Mẹ', 'system', 0),
    (2, 'FAM003', 'Trần', 'Thị Em', 1, '2000-06-15', 'Hà Nội', '111222333', 'Em gái', 'system', 0);


INSERT INTO tbl_type_form (code, name, status, created_by, deleted)
VALUES
    ('FORM01', 'Đăng ký thăng chức', 1, 'system', 0),
    ('FORM02', 'Tăng lương', 1, 'system', 0),
    ('FORM03', 'Nghỉ phép', 1, 'system', 0);


INSERT INTO tbl_register_form (manager_id, leader_id, employee_id, type_id, code, propose_date, content, approval_date, appointment_date, description, status, created_by, deleted)
VALUES
    (1, 2, 1, 1, 'REG001', '2025-05-01', 'Đề xuất thăng chức cho nhân viên A', '2025-05-05', '2025-06-01 09:00:00', 'Thăng chức lên Leader', 1, 'system', 0),
    (1, 2, 2, 2, 'REG002', '2025-05-02', 'Đề xuất tăng lương cho nhân viên B', NULL, NULL, 'Tăng lương cơ bản 10%', 0, 'system', 0);

INSERT INTO tbl_invalidated_token (id, expiry_time)
VALUES
    ('token-abc-123', '2025-06-01 12:00:00'),
    ('token-def-456', '2025-06-05 18:00:00');











