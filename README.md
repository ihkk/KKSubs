# KKSubs
## Movies

Subtitles which were re-timed or edited by KK for certain versions.

## Lua Macros

Macros used for adding effect lines, covering and checking lines for bilingual(especially Japanese & Chinese) subtitles.

At the very beginning the macro will ask you to fill in the style name of Japanese and Chinese Subtitles (also JP-UP & CN-UP if needed), then it will automatically do the checking work.

###  Space Check

The macro follows the standard that in Japanese subtitles only full width spaces like `　` exist, while in Chinese subtitles only half width spaces like ` ` exist. Additionally, there should be no spaces at the end of a line.
**The macro will mark out the subtitles which violated the rules above. The following wrong subtitles are listed as examples.**

| Error Type       | Example |
|------------------|---------|
| Full space in CN | 忘不了`　`你的声音  |
| Half space in JP | きみの声` `忘れない|
| Spce at line tail | 忘不了你的声音` `  |

Additionally, when pasting Japanese text from Excel, in some situations there will exist a Left-to-right mark like `　`. This is similar to full-width space but they are different.
| Space type | Example | Ascii |
|------------|---------|-------|
| Full space | `　` |\u3000|
| Half space | ` ` |32|
| Full space with Left-to-right mark | `　‎` |\u3000\u200e|

> The macro cannot search for lines with a half-width space and the control character at the end. This issue might be solved in following updates.

### Number & Time Check

In a bilingual subtitile file, all dialoge lines should have two lines in different languages theoretically. For example, the following two lines will apprear at the same time.

| ID |Time| Layer | Style | Text |
|----|----|-------|-------|------|
| 1  |0:00-0:05|  0    |JP-TEXT|きみの声忘れない|
| 2  |0:02-0:03|  0    |JP-TEXT-UP|涙も忘れない|
| 3  |0:00-0:05|  1    |CN-TEXT|忘不了你的声音|
| 4  |0:02-0:03|  1    |CN-TEXT-UP|也忘不了你的泪水|

Obviously, the total line numbers of JP-TEXT should be same as CN-TEXT; numbers of JP-TEXT-UP and CN-TEXT-UP should also be the same if exists. Additionally, the Japanese subtitile with its corresponding Chinese subtitile should appear at the same time.

**The macro will automatically count the numbers of JP and CN lines and would warn you if the result differs. If the numbers argrees, the macro will then check the time of each subtitle sets, and will report if the times of all lines agree or not.**

### Cover Lines
 
Usually when processing a bilingual subtitile file, lines in the original language are used for timing, and the translated lines' time are coverd by the lines with original lines. This tool will automatically help you cover the translation lines. Subtiltes should be set as below before using the macro.

| ID |Time| Style | Text |
|----|----|-------|------|
| 1  |0:00-0:05|JP-TEXT|きみの声忘れない|
| 2  |0:02-0:03|JP-TEXT-UP|涙も忘れない|
| 3  |0:00-0:00|CN-TEXT|忘不了你的声音|
| 4  |0:00-0:00|CN-TEXT|也忘不了你的泪水|

The macro will process the lines above into:

| ID |Layer|Time| Style | Text |
|----|-----|----|-------|------|
| 1  ||0:00-0:05|JP-TEXT|きみの声忘れない|
| 2  ||0:02-0:03|JP-TEXT-UP|涙も忘れない|
| 3  |**1**|**0:00-0:05**|CN-TEXT|忘不了你的声音|
| 4  |**1**|**0:02-0:03**|**CN-TEXT-UP**|也忘不了你的泪水|

Which means that, the macro can not only copy the time but also reset the correct style of the translation lines.
**Note that: whatever the layers of original language lines were, the macro will always set the layers of translated lines as 1**
> This issue might be solved in following updates.
