#!/usr/bin/env bash

player_status=$(playerctl status 2> /dev/null)

if [[ $player_status == "" ]]; then
    echo "" # Если плеер закрыт, ничего не выводим
else
    # Получаем метаданные: Артист - Название
    metadata=$(playerctl metadata --format "{{ artist }} - {{ title }}")
    
    # Обрезаем слишком длинные названия (например, до 30 символов)
    if [ ${#metadata} -gt 35 ]; then
        display_text="${metadata:0:32}..."
    else
        display_text=$metadata
    fi

    # Кнопка "Назад"
    prev="%{A1:playerctl previous:}󰒮%{A}"
    
    # Кнопка "Вперед"
    next="%{A1:playerctl next:}󰒭%{A}"

    # Кнопка "Плей/Пауза"
    if [[ $player_status == "Playing" ]]; then
        play_pause="%{A1:playerctl pause:}󰏤%{A}"
    else
        play_pause="%{A1:playerctl play:}󰐊%{A}"
    fi

    # Итоговый вывод: [Назад] [Плей/Пауза] [Вперед]  Артист - Песня
    echo "$prev  $play_pause  $next   $display_text"
fi