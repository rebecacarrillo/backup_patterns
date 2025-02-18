// Show tables
.tables

// Get users with their associated group names:
SELECT users.id, users.name, users.email, users.phone, groups.name as group_name 
FROM users 
JOIN groups ON users.group_id = groups.id;

// Count users in each group:
SELECT groups.name, COUNT(users.id) as user_count 
FROM groups 
LEFT JOIN users ON groups.id = users.group_id 
GROUP BY groups.name;
