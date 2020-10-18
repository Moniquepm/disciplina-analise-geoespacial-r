

## --------------------------------------------------------------------------------------------------------------------------------
si_wide <- si %>% 
  tidyr::pivot_wider(id_cols = id, 
                     names_from = state_abbreviation,
                     values_from = species_number, 
                     values_fill = list(species_number = 0))
si_wide


## --------------------------------------------------------------------------------------------------------------------------------
sp[1:1000, c("id", "species", "individuals")]


## --------------------------------------------------------------------------------------------------------------------------------
sp_wide <- sp[1:1000, ] %>% 
  tidyr::replace_na(list(individuals = 0)) %>% 
  tidyr::pivot_wider(id_cols = id, 
                     names_from = species, 
                     values_from = individuals, 
                     values_fill = list(individuals = 0))
sp_wide


## --------------------------------------------------------------------------------------------------------------------------------
si_long <- si_wide %>% 
  tidyr::pivot_longer(cols = -id, 
                      names_to = "record", 
                      values_to = "species_number")
si_long


## ----echo=FALSE------------------------------------------------------------------------------------------------------------------
countdown(minutes = 1, seconds = 00, color_background = "gray30")


## --------------------------------------------------------------------------------------------------------------------------------
si_local <- si %>% 
  tidyr::unite("local_total", 
               c(country, state, state_abbreviation, municipality, site), 
               sep = ", ")
si_local$local_total


## ----echo=FALSE------------------------------------------------------------------------------------------------------------------
countdown(minutes = 5, seconds = 00, color_background = "gray30")


## --------------------------------------------------------------------------------------------------------------------------------
family_wide <- sp[1:1000, ] %>% 
  tidyr::replace_na(list(individuals = 0)) %>% 
  tidyr::drop_na(family) %>% 
  tidyr::pivot_wider(id_cols = id, 
                     names_from = family, 
                     values_from = individuals, 
                     values_fn = list(individuals = sum),
                     values_fill = list(individuals = 0))
family_wide


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## tb_dplyr <- tb %>%
##   funcao_verbal(argumento1, argumento2)


## --------------------------------------------------------------------------------------------------------------------------------
si_select <- si %>% 
  dplyr::select(id, longitude, latitude)
si_select


## --------------------------------------------------------------------------------------------------------------------------------
si_select <- si %>% 
  dplyr::select(-c(id, longitude, latitude))
si_select


## --------------------------------------------------------------------------------------------------------------------------------
#  starts_with(), ends_with() e contains()
si_select <- si %>% 
  dplyr::select(contains("sp"))
si_select


## --------------------------------------------------------------------------------------------------------------------------------
# coluna para vetor
si_pull <- si %>% 
  dplyr::pull(id)
si_pull


## --------------------------------------------------------------------------------------------------------------------------------
# coluna para vetor
si_pull <- si %>% 
  dplyr::pull(species_number)
si_pull


## --------------------------------------------------------------------------------------------------------------------------------
# rename sp column
si_rename <- si %>%
  dplyr::rename(sp = species_number)
si_rename


## --------------------------------------------------------------------------------------------------------------------------------
# add column record as factor
si_mutate <- si %>% 
  dplyr::mutate(record_factor = as.factor(record))
si_mutate$record_factor


## --------------------------------------------------------------------------------------------------------------------------------
si_arrange <- si %>% 
  dplyr::arrange(species_number)
si_arrange


## --------------------------------------------------------------------------------------------------------------------------------
si_arrange <- si %>% 
  dplyr::arrange(desc(species_number))
si_arrange


## --------------------------------------------------------------------------------------------------------------------------------
si_arrange <- si %>% 
  dplyr::arrange(-species_number)
si_arrange


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(species_number > 5)
## si_filter


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(between(species_number, 1, 5))
## si_filter


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(is.na(passive_methods))
## si_filter


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(!is.na(passive_methods))
## si_filter


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(!is.na(active_methods) & !is.na(passive_methods))
## si_filter


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(species_number > 5 & state_abbreviation == "BR-SP")
## si_filter


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## si_filter <- si %>%
##   dplyr::filter(species_number > 5 | state_abbreviation == "BR-SP")
## si_filter


## --------------------------------------------------------------------------------------------------------------------------------
si_distinct <- si %>% 
  dplyr::distinct(species_number)
si_distinct


## --------------------------------------------------------------------------------------------------------------------------------
si_distinct <- si %>% 
  dplyr::distinct(species_number, .keep_all = TRUE)
si_distinct


## --------------------------------------------------------------------------------------------------------------------------------
si_slice <- si %>% 
  dplyr::slice(1:10)
si_slice


## --------------------------------------------------------------------------------------------------------------------------------
si_sample_n <- si %>% 
  dplyr::sample_n(100)
si_sample_n


## --------------------------------------------------------------------------------------------------------------------------------
si_summarise <- si %>% 
  dplyr::summarise(mean_sp = mean(species_number), 
                   sd_sp = sd(species_number))
si_summarise


## --------------------------------------------------------------------------------------------------------------------------------
si_summarise_group <- si %>% 
  dplyr::group_by(country) %>% 
  dplyr::summarise(mean_sp = mean(species_number), 
                   sd_sp = sd(species_number))
si_summarise_group


## --------------------------------------------------------------------------------------------------------------------------------
si_coord <- si %>% 
  select(id, longitude, latitude)
si_coord 


## --------------------------------------------------------------------------------------------------------------------------------
# join dos dados
sp_join <- sp %>% 
  left_join(si_coord, by = "id")
sp_join


## --------------------------------------------------------------------------------------------------------------------------------
colnames(sp_join)


## --------------------------------------------------------------------------------------------------------------------------------
sp_wide_rename <- sp_wide %>% 
  dplyr::rename_at(vars(contains(" ")), 
                   list(~stringr::str_replace_all(., " ", "_"))) %>% 
  dplyr::rename_all(list(~stringr::str_to_lower(.)))
sp_wide_rename


## --------------------------------------------------------------------------------------------------------------------------------
da <- si %>% 
  dplyr::select(id, state_abbreviation, species_number)
da


## --------------------------------------------------------------------------------------------------------------------------------
da <- si %>% 
  dplyr::select(id, state_abbreviation, species_number) %>% 
  dplyr::filter(species_number > 5)
da


## --------------------------------------------------------------------------------------------------------------------------------
da <- si %>% 
  dplyr::select(id, state_abbreviation, species_number) %>% 
  dplyr::filter(species_number > 5) %>% 
  dplyr::group_by(state_abbreviation) %>% 
  dplyr::summarise(nsp_state_abb = n())
da


## --------------------------------------------------------------------------------------------------------------------------------
da <- si %>% 
  dplyr::select(id, state_abbreviation, species_number) %>% 
  dplyr::filter(species_number > 5) %>% 
  dplyr::group_by(state_abbreviation) %>% 
  dplyr::summarise(nsp_state_abb = n()) %>% 
  dplyr::arrange(nsp_state_abb)
da


## ----echo=FALSE------------------------------------------------------------------------------------------------------------------
countdown(minutes = 1, seconds = 30, color_background = "gray30")


## --------------------------------------------------------------------------------------------------------------------------------
# solucao
si <- si %>% 
  dplyr::mutate(alt_log = log10(altitude),
                tem_log = log10(temperature),
                pre_log = log10(precipitation))
si[, 25:28]


## ----echo=FALSE------------------------------------------------------------------------------------------------------------------
countdown(minutes = 1, seconds = 30, color_background = "gray30")


## --------------------------------------------------------------------------------------------------------------------------------
# solucao
si_ar <- si %>% 
  dplyr::arrange(-altitude)
si_ar


## ----echo=FALSE------------------------------------------------------------------------------------------------------------------
countdown(minutes = 1, seconds = 30, color_background = "gray30")


## --------------------------------------------------------------------------------------------------------------------------------
# solucao
si_fi <- si %>% 
  dplyr::filter(altitude > 1000,
                temperature < 15,
                precipitation > 1000)
si_fi


## ----echo=FALSE------------------------------------------------------------------------------------------------------------------
countdown(minutes = 1, seconds = 30, color_background = "gray30")


## --------------------------------------------------------------------------------------------------------------------------------
# solucao
si_sa <- si %>% 
  dplyr::filter(species_number > 15) %>% 
  dplyr::sample_n(200)
si_sa


## --------------------------------------------------------------------------------------------------------------------------------
str_length("abc")


## --------------------------------------------------------------------------------------------------------------------------------
str_sub("abc", 3)


## --------------------------------------------------------------------------------------------------------------------------------
str_pad("abc", width = 4, side = "left")


## --------------------------------------------------------------------------------------------------------------------------------
str_pad("abc", width = 4, side = "right")


## --------------------------------------------------------------------------------------------------------------------------------
str_trim(" abc ")


## --------------------------------------------------------------------------------------------------------------------------------
str_to_upper("abc")


## --------------------------------------------------------------------------------------------------------------------------------
str_to_title("abc")


## --------------------------------------------------------------------------------------------------------------------------------
str_to_title("aBc")


## --------------------------------------------------------------------------------------------------------------------------------
le <- sample(letters, 26, rep = TRUE)
le


## --------------------------------------------------------------------------------------------------------------------------------
str_sort(le)


## --------------------------------------------------------------------------------------------------------------------------------
str_sort(le, dec = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------
str_extract("abc", "b")


## --------------------------------------------------------------------------------------------------------------------------------
str_replace("abc", "a", "y")


## --------------------------------------------------------------------------------------------------------------------------------
str_split("a-b-c", "-")


## --------------------------------------------------------------------------------------------------------------------------------
# fixar amostragem
set.seed(1)

# cria um fator
fa <- sample(c("alto", "medio", "baixo"), 30, rep = TRUE) %>% 
  forcats::as_factor()
fa


## --------------------------------------------------------------------------------------------------------------------------------
# muda o nome dos niveis
fa_recode <- fa %>% 
  forcats::fct_recode(a = "alto", m = "medio", b = "baixo")
fa_recode


## --------------------------------------------------------------------------------------------------------------------------------
# inverte os niveis
fa_rev <- fa_recode %>% 
  forcats::fct_rev()
fa_rev


## --------------------------------------------------------------------------------------------------------------------------------
# especifica a classificacao de um nivel
fa_relevel <- fa_recode %>% 
  forcats::fct_relevel(c("a", "m", "b"))
fa_relevel


## --------------------------------------------------------------------------------------------------------------------------------
# ordem em que aparece
fa_inorder <- fa_recode %>% 
  forcats::fct_inorder()
fa_inorder


## --------------------------------------------------------------------------------------------------------------------------------
# ordem (decrescente) de frequencia
fa_infreq <- fa_recode %>% 
  forcats::fct_infreq()
fa_infreq


## --------------------------------------------------------------------------------------------------------------------------------
# agregacao de niveis raros em um nivel
fa_lump <- fa_recode %>% 
  forcats::fct_lump()
fa_lump


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## # install
## install.packages("lubridate")


## --------------------------------------------------------------------------------------------------------------------------------
# load
library(lubridate)


## --------------------------------------------------------------------------------------------------------------------------------
# string
data_string <- "2020-04-24"
data_string
class(data_string)


## --------------------------------------------------------------------------------------------------------------------------------
# criar um objeto com a classe data
data_date <- lubridate::date(data_string)
data_date
class(data_date)


## --------------------------------------------------------------------------------------------------------------------------------
# criar um objeto com a classe data
data_date <- lubridate::as_date(data_string)
data_date
class(data_date)


## --------------------------------------------------------------------------------------------------------------------------------
# string
data_string <- "20-10-2020"
data_string
class(data_string)


## --------------------------------------------------------------------------------------------------------------------------------
# criar um objeto com a classe data
data_date <- lubridate::dmy(data_string)
data_date
class(data_date)


## --------------------------------------------------------------------------------------------------------------------------------
# formatos
lubridate::dmy(20102020)
lubridate::dmy("20102020")
lubridate::dmy("20/10/2020")
lubridate::dmy("20.10.2020")


## --------------------------------------------------------------------------------------------------------------------------------
# especificar horarios
lubridate::dmy_h(20102020120)
lubridate::dmy_hm(201020202035)
lubridate::dmy_hms(20102020203535)


## --------------------------------------------------------------------------------------------------------------------------------
# criar
data <- lubridate::dmy_hms(20102020203535)
data


## --------------------------------------------------------------------------------------------------------------------------------
# extrair
lubridate::second(data)
lubridate::day(data)
lubridate::month(data)


## --------------------------------------------------------------------------------------------------------------------------------
# criar
data <- lubridate::dmy_hms(20102020203535)
data


## --------------------------------------------------------------------------------------------------------------------------------
# extrair
lubridate::wday(data)
lubridate::wday(data, label = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------
# criar
data <- lubridate::dmy(20102020)
data


## --------------------------------------------------------------------------------------------------------------------------------
# inlcuir
lubridate::hour(data) <- 13
data


## --------------------------------------------------------------------------------------------------------------------------------
# extrair a data no instante da execucao
lubridate::today() 


## --------------------------------------------------------------------------------------------------------------------------------
# extrair a data e horario no instante da execucao
lubridate::now()


## --------------------------------------------------------------------------------------------------------------------------------
# agora
agora <- lubridate::ymd_hms(lubridate::now(), tz = "America/Sao_Paulo")
agora


## --------------------------------------------------------------------------------------------------------------------------------
# verificar os tz
OlsonNames()


## --------------------------------------------------------------------------------------------------------------------------------
# que horas sao em...
lubridate::with_tz(agora, tzone = "GMT")
lubridate::with_tz(agora, tzone = "Europe/Stockholm")  


## --------------------------------------------------------------------------------------------------------------------------------
# altera o fuso sem mudar a hora
lubridate::force_tz(agora, tzone = "GMT")


## --------------------------------------------------------------------------------------------------------------------------------
# datas
inicio_r <- lubridate::dmy("30-11-2011")
hoje_r <- lubridate::today()

# intervalo
r_interval <- lubridate::interval(inicio_r, hoje_r)
r_interval
class(r_interval)


## --------------------------------------------------------------------------------------------------------------------------------
# outra forma de definir um intervalo: o operador %--%
r_interval <- lubridate::dmy("30-11-2011") %--% lubridate::today() 
namoro_interval <- lubridate::dmy("25-06-2008") %--% lubridate::today()   


## --------------------------------------------------------------------------------------------------------------------------------
# verificar sobreposicao
lubridate::int_overlaps(r_interval, namoro_interval)


## --------------------------------------------------------------------------------------------------------------------------------
# somando datas
inicio_r + lubridate::ddays(1)
inicio_r + lubridate::dyears(1)


## --------------------------------------------------------------------------------------------------------------------------------
# criando datas recorrentes
reunioes <- lubridate::today() + lubridate::weeks(0:10)
reunioes


## --------------------------------------------------------------------------------------------------------------------------------
# duracao de um intervalo 
r_interval <- inicio_r %--% lubridate::today()
r_interval


## --------------------------------------------------------------------------------------------------------------------------------
# transformacoes
r_interval / lubridate::dyears(1)
r_interval / lubridate::ddays(1)


## --------------------------------------------------------------------------------------------------------------------------------
# total do periodo estudando r
lubridate::as.period(r_interval)


## --------------------------------------------------------------------------------------------------------------------------------
# tempo de namoro
lubridate::as.period(namoro_interval)


## ----eval=FALSE------------------------------------------------------------------------------------------------------------------
## li <- list(1:5, c(4, 5, 7), c(98, 34,-10), c(2, 2, 2, 2, 2))
## li


## ----include=FALSE---------------------------------------------------------------------------------------------------------------
x <- list(1:5, c(4, 5, 7), c(98, 34,-10), c(2, 2, 2, 2, 2))
x


## --------------------------------------------------------------------------------------------------------------------------------
purrr::map(x, sum)


## --------------------------------------------------------------------------------------------------------------------------------
purrr::map_dbl(x, sum)


## --------------------------------------------------------------------------------------------------------------------------------
purrr::map_chr(x, paste, collapse = " ")


## --------------------------------------------------------------------------------------------------------------------------------
x <- list(3, 5, 0, 1)
y <- list(3, 5, 0, 1)

purrr::map2_dbl(x, y, prod)


## --------------------------------------------------------------------------------------------------------------------------------
x <- list(3, 5, 0, 1)
y <- list(3, 5, 0, 1)
z <- list(3, 5, 0, 1)

purrr::pmap_dbl(list(x, y, z), prod)


## --------------------------------------------------------------------------------------------------------------------------------
mean_var <- si %>% 
  dplyr::select(species_number, altitude) %>% 
  purrr::map_dbl(mean)
mean_var


## --------------------------------------------------------------------------------------------------------------------------------
sd_var <- si %>% 
  dplyr::select(species_number, altitude) %>% 
  purrr::map_dbl(sd)
sd_var
