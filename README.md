# Movies

Subtitles which were re-timed or edited by KK for certain versions.

# Lua Macros

Macros used for adding effect lines, covering and checking lines for bilingual(especially Japanese & Chinese) subtitles.

## Auto Template

These functions are under: `\Automation\Auto Template`

Using this macro, you can easily add the following lines by simply clicking the menu selection;

- (commented) code line
- (commented) code syl
- (commented) code once
- (commented) template line
- (commented) template char
- (commented) template noblank
- (commented) template line noblank notext
- (code) “First syl” and related template lines
- (code) char counter `ci` and related template lines
- (code) A table which stores shape
- (code) Add a math fix function
- (code) Add text to shape function using Yutils
- (code) Add functions of 4 types “AutoTags” and related template lines



## Bilingual Tools

These macros are under: `\Automation\Kamigami`

At the very beginning the macros will ask you to fill in the style name of Japanese and Chinese Subtitles (also JP-UP & CN-UP if needed), then it will automatically do the checking or covering work.

###  Space Check

The macro follows the standard that in Japanese subtitles only full width spaces like `　` exist, while in Chinese subtitles only half width spaces like ` ` exist. Additionally, there should be no spaces at the end of a line.
**The macro will mark out the subtitles which violated the rules above. The following wrong subtitles are listed as examples.**

| Error Type       | Example |
|------------------|---------|
| Full space in CN | 忘不了`　`你的声音  |
| Half space in JP | きみの声` `忘れない|
| Space at line tail | 忘不了你的声音` ` |

Additionally, when pasting Japanese text from Excel, in some situations there will exist a Left-to-right mark like `　`. This is similar to full-width space but they are different.
| Space type | Example | Ascii |
|------------|---------|-------|
| Full space | `　` |\u3000|
| Half space | ` ` |32|
| Full space with Left-to-right mark | `　‎` |\u3000\u200e|

> The macro cannot search for lines with a half-width space and the control character at the end. This issue might be solved in following updates.

### Number & Time Check

In a bilingual subtitle file, all dialogue lines should have two lines in different languages theoretically. For example, the following two lines will appear at the same time.

| ID |Time| Layer | Style | Text |
|----|----|-------|-------|------|
| 1  |0:00-0:05|  0    |JP-TEXT|きみの声忘れない|
| 2  |0:02-0:03|  0    |JP-TEXT-UP|涙も忘れない|
| 3  |0:00-0:05|  1    |CN-TEXT|忘不了你的声音|
| 4  |0:02-0:03|  1    |CN-TEXT-UP|也忘不了你的泪水|

Obviously, the total line numbers of JP-TEXT should be same as CN-TEXT; numbers of JP-TEXT-UP and CN-TEXT-UP should also be the same if exists. Additionally, the Japanese subtitle with its corresponding Chinese subtitle should appear at the same time.

**The macro will automatically count the numbers of JP and CN lines and would warn you if the result differs. If the numbers agrees, the macro will then check the time of each subtitle sets, and will report if the times of all lines agree or not.**

Additionally, if there are some labels including `\fs`,`\pos` in text lines, the macro will select these lines with labels to remind the user as the final step of the bilingual checking procedure.

### Cover Lines

Usually when processing a bilingual subtitle file, lines in the original language are used for timing, and the translated lines' time are covered by the lines with original lines. This tool will automatically help you cover the translation lines. Subtitles should be set as below before using the macro.

| Line ID |Layer|Time| Style | Text |
|----|----|-------|------|------|
| 1  |0|0:00-0:05|JP-TEXT|きみの声忘れない|
| 2  |1|0:02-0:03|JP-TEXT-UP|涙も忘れない|
| 3  |*|0:00-0:00|CN-TEXT|忘不了你的声音|
| 4  |*|0:00-0:00|CN-TEXT|也忘不了你的泪水|

↓ The macro will process the lines above into:

| Line ID |Layer|Time| Style | Text |
|----|-----|----|-------|------|
| 1  |0|0:00-0:05|JP-TEXT|きみの声忘れない|
| 2  |1|0:02-0:03|JP-TEXT-UP|涙も忘れない|
| 3  |**1**|**0:00-0:05**|CN-TEXT|忘不了你的声音|
| 4  |**2**|**0:02-0:03**|**CN-TEXT-UP**|也忘不了你的泪水|

Which means that, the macro can not only copy the time but also reset the correct style of the translation lines. The layer will automatically add on 1 to the original layer number.

### Jump to corresponding line

This is a no-GUI function. It can help you quickly jump from one text line to its corresponding line.

Since this macro does not require to input the names of CN and JP styles (as this macro is used as a short-cut function), the default can only match some certain terms. Other style names are not supported.

Matching rules: the style name must contain `CN` or `JP` to indicate its language; there should be no `OP` or `ED` to avoid processing OP or ED lines. For normal lines there should be no `UP` or `U`, while for up lines there must be `U` or `UP`.

| Line ID         | Time      | Style      | Text             |
| --------------- | --------- | ---------- | ---------------- |
| 1 (selected)    | 0:00-0:05 | JP-TEXT    | きみの声忘れない |
| 2               | 0:02-0:03 | JP-TEXT-UP | 涙も忘れない     |
| 3 (re-selected) | 0:00-0:00 | CN-TEXT    | 忘不了你的声音   |
| 4               | 0:00-0:00 | CN-TEXT    | 也忘不了你的泪水 |

If you select Line 1 and run this macro, Line 3 will be automatically selected.

### Cover time from corresponding line

This is a no_GUI function. It can help you quickly cover a line’s time from its corresponding bilingual line.

The style name match rules are same to the **Jump to corresponding line** function.

This function could be used together with the **Jump to corresponding line** function when timing precisely after the rough job.

| Line ID | Time      | Style   | Text             |
| ------- | --------- | ------- | ---------------- |
| 1       | 0:01-0:05 | JP-TEXT | きみの声忘れない |
| **2**   | 0:00-0:03 | CN-TEXT | 忘不了你的声音   |

If you select Line 2 and run this macro, the subtitles will be changed into

| Line ID | Time          | Style   | Text             |
| ------- | ------------- | ------- | ---------------- |
| 1       | 0:01-0:05     | JP-TEXT | きみの声忘れない |
| **2**   | **0:01-0:05** | CN-TEXT | 忘不了你的声音   |

## Reset subset font styles

This is a very private function. The reason I added this is that the nPlayer on my MiTV4 does not display fonts correctly when the MKV files are packaged with font subsets. This macro can automatically change the style with font names in the pattern of `[\c\d]{8}` into `Source Han Sans SC Medium`.

