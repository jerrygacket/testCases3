<?php
/**
 * Функция получает список id пользователей и возвращает данные пользователей в массиве
 * Предыдущий вариант имел небезопасные sql-запросы, в которых можно сделать так называемую sql-инъекцию
 * 
 * @param $user_ids string строка с номерами пользователей через запятую, например: 1,2,17,48
 * @return array массив с данными пользователей
 */
function load_users_data(string $user_ids): array
{
    $result = [];

    $db = mysqli_connect('localhost', 'root', '123123', 'database');
    $sql = "SELECT * FROM users WHERE id IN (?)";
    $stmt = mysqli_prepare($db, $sql);
    mysqli_stmt_bind_param($stmt, 's', $user_ids);
    $res = mysqli_stmt_get_result($stmt);

    while ($row = mysqli_fetch_assoc($res)) {
        $result[$row['id']] = $row['name'];
    }

    mysqli_stmt_close($stmt);

    mysqli_close($db);

    return $result;
}

// Как правило, в $_GET['user_ids'] должна приходить строка с номерами пользователей через запятую, например: 1,2,17,48
$data = load_users_data($_GET['user_ids']);
foreach ($data as $user_id => $name) {
    echo '<a href=\'/show_user.php?id=$user_id\'>$name</a>';
}
