From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Mon, 21 May 2018 09:44:20 +0300
Message-ID: <CAHp75VcCVNGey1TmAR7EJ3wJL1q+KSOXpbwJ3XmoU70tKOm+Bg@mail.gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com> <5456625.lDWjtgZygK@z50>
 <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
 <3505791.x6nWYTo8eb@z50> <CAHp75Vdp5A58JMTf8vaET84QEzzZ_T7eKLUYfWV9qpWt5ptYCA@mail.gmail.com>
 <20180520192523.32dde632@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180520192523.32dde632@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Sun, May 20, 2018 at 8:25 PM, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> On Sun, 20 May 2018 19:17:04 +0300, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

> Do we actually have the possibility to rename this gpio? I guess no
> since it would break DT backward compatibility.

No we don't.

> Otherwise it would have
> been more descriptive to call it something like 'gpio-rb'.

"gpio" prefix, actually "gpios" suffix is a mandatory part of the
name. For sake of convenience it's not used in API calls.

-- 
With Best Regards,
Andy Shevchenko
