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
  = ('ms'i / 'milliseconds'i / 'millisecond'i / 'milisegundos'i / 'milisegundo'i) { return 1; }

seconds
  = ('seconds'i / 'second'i / 'secs'i / 'sec'i / 's'i / 'segundos'i / 'segundo'i) { return 1000; }

minutes
  = ('minutes'i / 'minute'i / 'mins'i / 'min'i / 'm'i / 'minutos'i / 'minuto'i) { return 60000; }

hours
  = ('hours'i / 'hour'i / 'hrs'i / 'hr'i / 'h'i / 'heures'i / 'heure'i / 'horas'i / 'hora'i) { return 3600000; }

days
  = ('days'i / 'day'i / 'd'i / 'jours'i / 'jour'i / 'j'i / 'días'i / 'día'i) { return 86400000; }

weeks
  = ('weeks'i / 'week'i / 'wks'i / 'wk'i / 'w'i / 'semaines'i / 'semaine'i / 'semanas'i / 'semana'i / 'sem'i / 'smn'i) { return 604800000; }

months
  = ('months'i / 'month'i / 'mos'i / 'mois'i / 'meses'i / 'mes'i) { return 2629800000; }

years
  = ('years'i / 'year'i / 'yrs'i / 'yr'i / 'y'i / 'ans'i / 'an'i / 'años'i / 'año'i) { return 31557600000; }

sep
  = [' '\t]

number
  = float
  / integer

integer "integer"
  = [0-9]+ { return parseInt(text(), 10); }

float "float"
  = [0-9]* '.' [0-9]+ { return parseFloat(text(), 10); }