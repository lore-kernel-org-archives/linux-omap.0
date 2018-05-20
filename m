From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Sun, 20 May 2018 19:25:23 +0200
Message-ID: <20180520192523.32dde632@xps13>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
        <5456625.lDWjtgZygK@z50>
        <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
        <3505791.x6nWYTo8eb@z50>
        <CAHp75Vdp5A58JMTf8vaET84QEzzZ_T7eKLUYfWV9qpWt5ptYCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdp5A58JMTf8vaET84QEzzZ_T7eKLUYfWV9qpWt5ptYCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Sun, 20 May 2018 19:17:04 +0300, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> >> Though, I completely dislike "rdy" name of GPIO. Where is it documented?  
> >
> > No documentation files for Amstrad Delta nor for its NAND driver specifically
> > exist under Documentation/. However, there exist some for generic GPIO NAND
> > driver where the pin name "rdy" is used explicitly:
> > Documentation/driver-api/gpio/drivers-on-gpio.rst
> > Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
> > You can find that mnemonic used across drivers/mtd/nand/, standalone or as a
> > suffix, including the Amstrad Delta NAND driver before the change discussed.  
> 
> > To be honest, I don't like it much either, but I'm just using it instead of
> > inventing something new.  
> 
> OK, that's what I was looking for. Since it's already in use and
> documented, then it's fine for me.

Do we actually have the possibility to rename this gpio? I guess no
since it would break DT backward compatibility. Otherwise it would have
been more descriptive to call it something like 'gpio-rb'.

Anyway, if you find the time, documentation for this controller would be
welcome!

Thanks,
Miquèl
