start
  = time
  / '0' { return 0; }

time
  = left:signed sep* right:time { return left + right; }
  / signed

signed
  = '+' sep* time:timestring { return time; }
  / '-' sep* time:timestring { return -time; }
  / timestring

timestring
  = left:timechunk &(!(sep* ['+''-'])) sep* right:timestring { return left + right; }
  / timechunk

timechunk
  = num:number sep* mult:multiplier { return num * mult; }

multiplier
  = months
  / weeks
  / milliseconds
  / seconds
  / minutes
  / hours
  / days
  / years

milliseconds
  = ('milliseconds'i / 'millisecond'i / 'millisecondes'i / 'milissegundos'i / 'milisegundos'i / 'milissegundo'i / 'milisegundo'i / 'ms'i) { return 1; }

seconds
  = ('milliseconds'i / 'secondes'i / 'segundos'i / 'seconds'i / 'segundo'i / 'second'i / 'secs'i / 'sec'i / 's'i) { return 1000; }

minutes
  = ('minutes'i / 'minute'i / 'minutos'i / 'minuto'i / 'mins'i / 'min'i / 'm'i) { return 60000; }

hours
  = ('hours'i / 'heures'i / 'horas'i / 'hour'i / 'heure'i / 'hora'i / 'hrs'i / 'hr'i / 'h'i) { return 3600000; }

days
  = ('days'i / 'jours'i / 'días'i / 'dias'i / 'jour'i / 'día'i / 'dia'i / 'day'i / 'j'i / 'd'i) { return 86400000; }

weeks
  = ('weeks'i / 'semaines'i / 'semanas'i / 'semaine'i / 'semana'i / 'week'i / 'sem'i / 'smn'i / 'wks'i / 'wk'i / 'w'i) { return 604800000; }

months
  = ('months'i / 'month'i / 'meses'i / 'mois'i / 'mês'i / 'mes'i / 'mos'i) { return 2629800000; }

years
  = ('years'i / 'años'i / 'anos'i / 'year'i / 'año'i / 'ano'i / 'ans'i / 'yrs'i / 'yr'i / 'an'i / 'y'i) { return 31557600000; }

sep
  = [' '\t]

number
  = float
  / integer

integer "integer"
  = [0-9]+ { return parseInt(text(), 10); }

float "float"
  = [0-9]* '.' [0-9]+ { return parseFloat(text(), 10); }