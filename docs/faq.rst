Вопросы и ответы
================

.. _faq_create_typicon:

Как создать новый Устав?
------------------------

1. Зарегистрируйтесь в системе.
2. Подайте заявку на создание Устава и дождитесь ее одобрение Адиминистратором системы.
3. Внесите необходимые изменения для корректного отображения Вашей версии Устава.
4. Опубликуйте версию Устава. 


.. _faq_public_site:

Как разместить расписание Устава на html-странице?
---------------------------------------------------

1. :ref:`Создайте новый Устав <faq_create_typicon>`.
2. В нужном месте html-страницы достаточно вставить одну строчку кода:

::

	<script src="https://www.typicon.online/week.js?id=berluki&count=2&redcolor=#ff0000"></script>

где:

* **id** - системное имя Устава, 
	обязательно для указания.
* **count** - количество отображаемых седмиц (от 1 до 5),
	НЕ обязательно для указания, по умолчанию - 2
* **redcolor** - определение красного цвета в расписании (от 1 до 5),
	не обязательно для заполнения.
	
	Значение: цвет в модели цвета RGB.
	Например, #ff0000
	
	По умолчанию всем элементам, отмеченным для отображения в красном цвете, задается css класс **red**.

Как внести изменение в расписание?
----------------------------------


