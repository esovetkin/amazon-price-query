# A simple amazon price tracker

Collect and report any changes in prices

## Installation

```
make init
```
will install all the python dependencies.

## Usage

For the query to work a urls file should be present. Default location:
`~/.amazon-tracker/urls.csv.gz`. The file is a gzip csv file, and is
given in the following format:
```
"https://www.amazon.de/gp/product/B00CS46EIS", sram chain 11
"https://www.amazon.de/gp/product/B001A0666G", sram chain 9
"https://www.amazon.de/gp/product/B07HY8VG1J", degreaser bio
"https://www.amazon.de/gp/product/B001MXN3U8", cassette 9x 11-26T
"https://www.amazon.de/gp/product/B00JYD8E7U", cassette 11x 11-32T
```
The first column is the link, the second column is the comment.

When the urls file is given, then
```
amazon-tracker query
```
queries the data.

The data is stupidly appended to the data-file. So in order to keep
the file small, say regularly
```
amazon-tracker rotate
```
to recompress the data file.

To run a report on the collected data say
```
amazon-tracker report
```

See
```
amazon-tracker --help
```
for full options.
