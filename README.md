# KKSubs
## Movies

Subtitles which were re-timed or edited by KK for certain versions.

一些处理过的、重调时过的轴，通常改自互联网公开字幕，原译者、轴君的信息均未修改。相关对应的版本可以在ASS/SRT的注释处或commit中找到。


## Lua Macros

Macros used for adding effect lines, covering and checking lines for bilingual(especially Japanese & Chinese) subtitles.

###  Space Check

The macro follows the standard that in Japanese subtitles only full width spaces like `　` exist, while in Chinese or English subtitles only half width spaces like ` ` exist. Additionally, there should be no spaces at the end of a line.
The macro will mark out the subtitles which violated the rules above. The following wrong subtitles are listed as examples.
| Error Type       | Example |
|------------------|---------|
| Full space in CN | 忘不了`　`你的声音  |
| Half space in JP | きみの声` `忘れない|
| Spce at line tail | 忘不了你的声音` `  |
