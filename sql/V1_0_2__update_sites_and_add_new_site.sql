INSERT INTO public.site ("name", status_time, status, url)
    VALUES ('Сендел', now(), 'INDEXING', 'https://sendel.ru/');

update site
set url = 'https://lenta.ru/'
where site.name = 'Лента.ру';

update site
set url = 'https://skillbox.ru/'
where site.name = 'Skillbox';
