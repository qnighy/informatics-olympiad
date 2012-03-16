s/</\&lt;/g
s/;/,/g
s/ 5 / \\leq /g
s//*/g
s//\\times/g
s/[-+=a-zA-Z0-9 (),\%&]\+/<var>\0<\/var>/g
s/\([A-Z]\)\([ij]\)/\1_\2/g
s/<var> / <var>/g
s/ <\/var>/<\/var> /g
s/<var><\/var>//g
s/<var>JOI<\/var>/JOI/g
s/<var>IOI<\/var>/IOI/g
s/<var>(<\/var>/(/g
s/<var>)<\/var>/)/g
s/ 000/\\,000/g

