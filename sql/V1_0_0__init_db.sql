CREATE SEQUENCE public.site_id_seq;
CREATE SEQUENCE public.page_id_seq;
CREATE SEQUENCE public.lemma_id_seq;
CREATE SEQUENCE public.index_id_seq;

CREATE TABLE public.site
(
    id          int8 default nextval('public.site_id_seq'::regclass) NOT NULL,
    "name"      varchar(255)                                         NOT NULL,
    status_time timestamp(6)                                         NOT NULL,
    last_error  varchar NULL,
    status      varchar                                              NOT NULL,
    url         varchar(255)                                         NOT NULL,
    CONSTRAINT site_pk PRIMARY KEY (id)
);
COMMENT ON TABLE public.site IS 'Информация о сайтах и статусах их индексации';
COMMENT ON COLUMN public.site.id IS 'ID сайта';
COMMENT ON COLUMN public.site.name IS 'Название (имя) сайта';
COMMENT ON COLUMN public.site.url IS 'Адрес главной страницы сайта';
COMMENT ON COLUMN public.site.status IS 'Текущий статус полной индексации сайта, отражающий готовность поискового движка осуществлять поиск по сайту';
COMMENT ON COLUMN public.site.last_error IS 'Текст ошибки индексации';
COMMENT ON COLUMN public.site.status_time IS 'Дата и время статуса';

CREATE TABLE public.page
(
    id        int8 default nextval('public.page_id_seq'::regclass) NOT NULL,
    code      int4                                                 NOT NULL,
    site_id   int8                                                 NOT NULL,
    "path"    text                                                 NOT NULL,
    "content" text                                                 NOT NULL,
    CONSTRAINT page_pk PRIMARY KEY (id),
    CONSTRAINT page_site_fk FOREIGN KEY (site_id) REFERENCES public.site (id)
);
COMMENT ON TABLE public.page IS 'Проиндексированные страницы сайта';
COMMENT ON COLUMN public.page.id IS 'ID страницы';
COMMENT ON COLUMN public.page.code IS 'Код HTTP-ответа, полученный при запросе';
COMMENT ON COLUMN public.page.site_id IS 'ID веб-сайта из таблицы site';
COMMENT ON COLUMN public.page."path" IS 'Адрес страницы от корня сайта';
COMMENT ON COLUMN public.page."content" IS 'Контент страницы (HTML-код)';

CREATE TABLE public.lemma
(
    id        int8 default nextval('public.lemma_id_seq'::regclass) NOT NULL,
    frequency int4                                                  NOT NULL,
    site_id   int8                                                  NOT NULL,
    lemma     varchar(255)                                          NOT NULL,
    CONSTRAINT lemma_pk PRIMARY KEY (id),
    CONSTRAINT lemma_site_fk FOREIGN KEY (site_id) REFERENCES public.site (id)
);
COMMENT ON TABLE public.lemma IS 'Леммы, встречающиеся в текстах';
COMMENT ON COLUMN public.lemma.id IS 'ID леммы';
COMMENT ON COLUMN public.lemma.frequency IS 'Количество страниц, на которых слово';
COMMENT ON COLUMN public.lemma.lemma IS 'Нормальная форма слова (лемма)';
COMMENT ON COLUMN public.lemma.site_id IS 'ID веб-сайта из таблицы site';

CREATE TABLE public."index"
(
    id       int8 default nextval('public.index_id_seq'::regclass) NOT NULL,
    "rank"   float4                                                NOT NULL,
    lemma_id int8                                                  NOT NULL,
    page_id  int8                                                  NOT NULL,
    CONSTRAINT index_pk PRIMARY KEY (id),
    CONSTRAINT index_page_fk FOREIGN KEY (page_id) REFERENCES public.page (id),
    CONSTRAINT index_lemma_fk FOREIGN KEY (lemma_id) REFERENCES public.lemma (id)
);
COMMENT ON TABLE public."index" IS 'Поисковый индекс';
COMMENT ON COLUMN public."index".id IS 'ID поискового индекса';
COMMENT ON COLUMN public."index"."rank" IS 'Количество данной леммы для данной страницы';
COMMENT ON COLUMN public."index".lemma_id IS 'Идентификатор леммы';
COMMENT ON COLUMN public."index".page_id IS 'Идентификатор страницы';
