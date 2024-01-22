// Typst template for making NOI-like problems
// Author: Wallbreaker5th
// MIT License

#import "@preview/codelst:2.0.0": sourcecode
#import "@preview/tablex:0.0.8": tablex, gridx, hlinex, vlinex, colspanx, rowspanx


#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)
#let mono = "Consolas"
#let serif = "New Computer Modern"
#let cjk-serif = "FZShuSong-Z01S"
#let cjk-sans = "FZHei-B01S"
#let cjk-mono = "FZFangSong-Z02S"
#let cjk-italic = "FZKai-Z03S"

#let problem-counter = counter("problem")
#let saved-prob-list = state("all-problems", ())

#let empty-par = {
  par()[
    #v(0em, weak: true)
    #h(0em)
  ]
}
#let add-empty-par(it) = {
  it
  empty-par
}

// Dotted strong text
#let dstrong(content, dot-color: black) = {
  show regex("\p{sc=Hani}"): s => {
    box(s + place(bottom+center, dy: 0.35em, circle(radius: 0.05em, fill: dot-color, stroke: none)))
  }
  strong(content)
}

#let filename(it) = {
  set text(style: "italic", weight: "bold")
  it
}

#let title(contest-info) = {
  align(center, {
    strong(text(contest-info.name, size: 字号.二号))

    parbreak()

    let name-en = contest-info.at("name-en", default: none)
    if (name-en != none) {
      text(name-en, size: 字号.小一)
    }

    parbreak()

    let round = contest-info.at("round", default: none)
    if (round != none) {
      emph(text(round, size: 字号.二号))
    }

    parbreak()

    let author = contest-info.at("author", default: none)
    if (author != none) {
      text(author, size: 字号.小三, font: (serif, cjk-sans))
    }

    parbreak()

    let time = contest-info.at("time", default: none)
    if (time != none) {
      text(time, size: 字号.小三, font: (serif, cjk-sans))
    }
  })
}

#let problem-information-table(
  problems, // an array of dictionaries.
  extra-rows: (), // an array of (key, name[, style[, always-display[, default]]]) tuples. default can be a string or a function.
  languages: (("C++", "cpp"),), // an array of (name, extension) tuples.
  compile-options: (("C++", "-O2 -std=c++14 -static"),), // an array of (name, options) tuples.
) = {
  let rows = (
    ("name", "题目名称", text, true, "无"),
    ("type", "题目类型", text, true, "传统型"),
    ("name-en", "目录", raw, true, "无"),
    ("executable", "可执行文件名", raw, true, x => x.name-en),
    ("input", "输入文件名", raw, true, x => x.name-en + ".in"),
    ("output", "输出文件名", raw, true, x => x.name-en + ".out"),
    ("time-limit", "每个测试点时限", text, false, "无"),
    ("memory-limit", "内存限制", text, false, "无"),
    ("test-case-count", "测试点数目", text, false, "10"),
    ("test-case-count", "子任务数目", text, false, "1"),
    ("test-case-equal", "测试点是否等分", text, false, "是"),
  );

  for r in extra-rows {
    if (r.len() == 2) {
      r.push(text);
    }
    if (r.len() == 3) {
      r.push(false);
    }
    if (r.len() == 4) {
      r.push("无");
    }
    let appeared = false;
    for i in range(rows.len()) {
      if (rows.at(i).at(0) == r.at(0)) {
        rows.at(i) = r;
        appeared = true;
        break;
      }
    }
    if (not appeared) {
      rows.push(r);
    }
  }

  let first-column-width = if(problems.len() <=3 ) { 0.22 } else { 1/(problems.len()+1) } * 100%;
  set table(align: bottom)

  table(
    columns: (first-column-width, ) + (1fr,) * problems.len(),
    stroke: 0.4pt,
    ..{
      rows.filter(r=>{
        if (r.at(3)) {
          true
        } else {
          problems.any(p => p.at(r.at(0), default: none)!=none)
        }
      }).map(r => {
        (text(r.at(1)), ) + problems.map(p => {
          let v = p.at(r.at(0), default: none);
          let w = if (v == none) {
            if (type(r.at(4)) == str) {
              r.at(4)
            } else if (type(r.at(4)) == function) {
              r.at(4)(p)
            } else if (type(r.at(4)) == content) {
              r.at(4)
            }
          } else {
            v
          }

          if (type(w) == str) { r.at(2)(w) } else { w }
        })
      }).flatten()
    }
  )

  h(2em)
  [提交源程序文件名]
  table(
    columns: (first-column-width, ) + (1fr,) * problems.len(),
    stroke: 0.4pt,
    ..{
      languages.map(l => {
        (box(stack(dir:ttb)[对于 #l.at(0)][#h(5.5em)]) + "语言",) + problems.map(p => {
          let v = p.at("submit-file-name", default: p.name-en + "." + l.at(1));
          if (type(v) == str) { raw(v) } else { v }
        })
      }).flatten()
    }
  )

  h(2em)
  [编译选项]
  table(
    columns: (first-column-width, 1fr),
    align: (left+bottom, center+bottom),
    stroke: 0.4pt,
    ..{
      compile-options.map(l => {
        (box(stack(dir:ttb)[对于 #l.at(0)][#h(5.5em)]) + "语言", raw(l.at(1)))
      }).flatten()
    }
  )
}

#let current-problem(loc) = {
  saved-prob-list.at(loc).at(problem-counter.at(loc).at(0)-1)
}
#let next-problem() = {
  problem-counter.step()
  pagebreak()
  locate(loc => {
    let prob = current-problem(loc)
    heading(level: 1)[
      #prob.name（#prob.name-en）
    ]
  })
}

#let sample(it) = {

  show table: set text(size: 1.25em, font: (mono, cjk-mono))
  let content = if (type(it) == str) {
    raw(it, block: true, lang: "text")
  } else {
    it
  }
  let res = pad(left: 10pt, sourcecode(frame: block.with(
    fill: none,
    stroke: 0.5pt + rgb("#00f"),
    inset: (left: -10pt, y: 5pt),
  ),
  numbers-style: {lno => {
    box(text(
      raw(lno),
      size: 0.8em,
      fill: gray
    ), inset: (top: 0.2em, bottom: 0.35em))
  }}, content))

  res

  empty-par
}
#let code=sample

#let oi(
  x,
  prob-list,
  contest-info
) = {
  saved-prob-list.update(prob-list)

  // Set fonts for different elements
  set text(font: (serif, cjk-serif))
  show emph: set text(font: (serif, cjk-italic))
  show strong: st => {
    set text(font: (serif, cjk-sans))
    show regex("[\p{sc=Hani}\u3000-\u303F\uFF01-\uFF60]+"): s => text(s, weight: 100)
    show math.equation: set text(weight: 200)
    st
  }
  show raw: set text(font: (mono, cjk-mono), size: 1.25em)

  // List and enum
  set list(indent: 1.75em, marker: ([•], [#h(-1em)•]))
  set enum(indent: 1.75em)
  

  // Heading
  show heading: set text(font: (serif, cjk-sans), weight: 400)
  show heading.where(level: 1): it => {
    set text(size: 字号.小二)
    set heading(bookmarked: true)
    pad(top: 8pt, bottom: 6pt, align(center, it))
  }
  show heading.where(level: 2): it => {
    set text(size: 字号.小四)
    set heading(bookmarked: true)
    pad(left: 1.5em, top: 1em, bottom: 1em, [【]+box(it)+[】])
  }

  show figure: it => {
    it
    v(1em)
  }

  // Page Layout
  set page(
    margin: 2.5cm,
    header: {
      set text(size: 字号.五号)
      contest-info.name
      h(1fr)
      let round = contest-info.at("round", default: none)
      if (round != none) {
        round + " "
      }
      locate(loc => {
        let prob = current-problem(loc)
        prob.name + "（" + prob.name-en + "）"
      })
      v(-0.8em)
      line(length: 100%, stroke: 0.3pt)
    },
    footer: {
      set text(size: 字号.五号)
      align(center,{
        [第]
        counter(page).display()
        [页]
        h(2em)
        [共]
        locate(loc => {
          let cnt = counter(page).final(loc).at(0)
          link((page:cnt, x:0pt, y:0pt), text(fill: rgb("#00f"), [#cnt]))
        })
        [页]
      })
    }
  )


  // Dealing with the first line indent in the first paragraph
  // You have to manually add a empty paragraph sometimes
  show figure: add-empty-par
  show heading: add-empty-par
  show list: add-empty-par
  show enum: add-empty-par
  show raw.where(block: true): add-empty-par
  set par(first-line-indent: 2em, leading: 0.8em)

  [
    #x
  ]
}

