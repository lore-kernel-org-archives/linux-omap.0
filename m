From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer resolution on read/write
Date: Fri, 20 Jul 2018 20:14:55 +0200
Message-ID: <9888773.rgnYII6m0f@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-5-jmkrzyszt@gmail.com> <20180719082538.222396bf@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719082538.222396bf@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, July 19, 2018 8:25:38 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:06 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Further optimize processing speed of read/write callback functions by
> > resolving private structure pointer only once per callback and passing
> > it to all subfunctions instead of mtd_info.

OK, I'll call it simplification (the code looks more simple after that, doesn't 
it), not optimization if you agree.

Thanks,
Janusz
