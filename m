From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH 1/8] mtd: rawnand: ams-delta: Use private structure
Date: Fri, 20 Jul 2018 19:57:12 +0200
Message-ID: <1763213.HC3d3VW7aF@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-2-jmkrzyszt@gmail.com> <20180719081728.46eb7ab5@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719081728.46eb7ab5@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, July 19, 2018 8:17:28 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:03 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Introduce a driver private structure and allocate it on device probe.
> > Use it for storing nand_chip structure, GPIO descriptors prevoiusly
> > stored in static variables as well as io_base pointer previously passed
> > as nand controller data or platform driver data.
> 
> That's a good thing. Thanks for doing that.
> 
> > Subsequent patches
> > may populate the structure with more members as needed.
> > 
> > While at it, fix missing mtd->dev.parent and drop useless mtd->owner.
> 
> I'd prefer to have it done in a separate patch if you don't mind.

No problem, I'll split it.

Thanks,
Janusz
