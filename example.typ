#import "typst-oi-statement.typ": *;

#let prob-list = (
  (
    name: "圆格染色",
    name-en: "color",
    time-limit: "1.0 秒",
    memory-limit: "512 MiB",
    test-case-count: "10",
    test-case-equal: "是",
    year: "2023",
  ),
  (
    name: "桂花树",
    name-en: "tree",
    type: "交互型",
    time-limit: "0.5 秒",
    memory-limit: "512 MiB",
    test-case-count: "10",
    test-case-equal: "是",
    year: "2023",
  ),
  (
    name: "深搜",
    name-en: "dfs",
    type: "提交答案型",
    executable: [无],
    input: [`dfs`1\~10`.in`],
    output: [`dfs`1\~10`.out`],
    test-case-count: "10",
    test-case-equal: "是",
    submit-file-name: [`dfs`1\~10`.out`]
  ),
)

#let contest-info = (
  name: "全国中老年信息学奥林匹克竟赛",
  name-en: "FCC ION 3202",
  round: "第一试",
  time: "时间：2023 年 7 月 24 日 08:00 ~ 13:00",
)

#show: it => oi(
  it,
  prob-list,
  contest-info
)

#title(contest-info)

#problem-information-table(prob-list,
  extra-rows:(
    ("year", "年份", text, false, "2023"),
    // key, name, wrapper, always-show, default-value
    ("contest", "赛事", text.with(fill: blue), true, "NOI"),
    ("setter", "出题人", text, true, p=>{p.name+"的出题人"}),
    ("foo", "bar", text, false, "这一行不会显示"),
  ),
  // languages:(
  //   ("C++", "cpp"),
  //   ("D++", "dpp")
  // ),
  // compile-options: (
  //   ("C++", "-O2 -std=c++20 -DOFFLINE_JUDGE"),
  // )
)

#dstrong[注意事项（请仔细阅读）]
+ 文件名（程序名和输入输出文件名）必须使用英文小写。
+ C++ 中函数 main() 的返回值类型必须是 int，程序正常结束时的返回值必须是 0。
+ 因违反以上两点而出现的错误或问题，申诉时一律不予受理。
+ 若无特殊说明，结果的比较方式为全文比较（过滤行末空格及文末回车）。
+ 选手提交的程序源文件必须不大于 100KB。
+ 程序可使用的栈空间内存限制与题目的内存限制一致。
+ 只提供 Linux 格式附加样例文件。
+ 禁止在源代码中改变编译器参数（如使用 \#pragma 命令），禁止使用系统结构相关指令（如内联汇编）和其他可能造成不公平的方法。


#next-problem()

== 题目描述

输入两个正整数 $a, b$，输出它们的和。

你可以#dstrong[强调一段带 $f+or+mu+l+a$ 的文本]。用 `#underline` 加 ``` `` ``` 来实现 #underline[`underlined raw text`]。

如果需要更换字体，可以修改 `typst-oi-statement.typ` 中的 $28$ 至 $33$ 行。（思源黑体看起来其实风格不太对）

+ 第一点
+ 第二点

- 第一点
  - 列表可以嵌套
  - 但目前，有序列表和无序列表的互相嵌套会有缩进上的问题。
- 第二点
  - 第二点的第一点
  - 第二点的第二点


== 输入格式

从文件 #filename[color.in] 中读入数据。

输入的第一行包含两个正整数 $a, b$，表示需要求和的两个数。

== 输出格式

输出到文件 #filename[color.out] 中。

输出一行一个整数，表示 $a+b$。

== 样例1输入
#sample(read("example-assets/color1.in"))

== 样例1输出
#sample[
```text
13
```
]

== 样例1解释
`#sample` 的参数可以是字符串（可以从文件读入），也可以是代码块。

#figure(caption: "凹包", supplement: "图")[#image("example-assets/fig.png", width: 40%)]

#for (i,case) in range(6).zip(($1 tilde 5$, $6 tilde 9$, $10 tilde 13$, $14 tilde 17$, $18 tilde 19$, $20$)){[
== 样例#{i+2}
见选手目录下的 #filename[color/color#{i+2}#"."in] 与 #filename[color/color#{i+2}#"."ans]。

这个样例满足测试点 #case 的条件限制。
]}

== 数据范围

对于所有测试数据保证：$1 <= a,b <= 10^9$。

#align(center,
box( // 使用 box 来强制让表格处于同一页
tablex(
  columns: 4,
  auto-vlines: false,
  stroke: 0.4pt,
  align: center+horizon,

  (), vlinex(), vlinex(), vlinex(), (),
  hlinex(stroke: 2pt),
  [测试点编号], $n,m <=$, $q<=$, [特殊性质],
  hlinex(stroke: 1.2pt),
  $1 tilde 5$,    $300$,                $300$,                rowspanx(2)[无],
  $6 tilde 9$,    rowspanx(4)[$10^5$],  $2000$,               (),
  $10 tilde 13$,  (),                   rowspanx(4)[$10^5$],  [A],
  $14 tilde 17$,  (),                   (),                   [B],
  $18 tilde 19$,  (),                   (),                   rowspanx(2)[无],
  $20$,           $10^9$,               (),                   (),
  hlinex(stroke: 2pt),
)
)
)

#empty-par

特殊性质 A: 你可以像上面这样创建复杂的表格。

特殊性质 B: 模板没有对 `tablex` 额外封装。在 `tablex` 之后，你需要用 `#empty-par` 插入一个空段落，以确保之后段落的首行缩进正确。你也可以通过 `#h(2em)` 手动添加缩进。







#next-problem()

#dstrong[这是一道交互题。]

== 题目描述
#lorem(50)

== 实现细节
请确保你的程序开头有 `#include "tree.h"`。

#code(```cpp
int query(int x, int y);
void answer(std::vector<int> ans);
```)

#code(```bash
g++ count.cpp -c -O2 -std=c++14 -lm && g++ count.o grader.o -o count
```)

我能吞下玻璃而不伤身体。

- 赵钱孙李周吴郑王，冯陈楮卫蒋沈韩：
  - 杨朱秦尤许何吕施张孔。
    - 曹严华金魏陶姜戚谢。
  - 邹喻柏水窦章云苏潘葛奚。
- 范彭郎鲁韦昌马苗凤花，方俞任袁柳酆鲍史唐费廉岑薛雷。
- 贺倪汤滕殷罗毕郝邬安常乐于时傅皮卞齐康伍余，元卜顾孟平黄和穆萧尹姚邵湛汪，祁毛禹狄米贝明臧计伏成戴。

== 评分标准
#lorem(50)

#lorem(100)

== 数据范围
#lorem(50)




#next-problem()
== 题目描述
……

