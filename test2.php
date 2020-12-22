<?php
$params = array_filter(
  Yii::$app->request->get(), 
  function ($param) {
    if ($param != '3') {
        return $param;
    }
  }
);

$params['url'] = Yii::$app->request->getScriptUrl();
asort($params);

echo 'https://www.somehost.com/?'.http_build_query($params);
