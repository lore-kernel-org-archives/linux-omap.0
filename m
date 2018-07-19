From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap
 accessors for data I/O
Date: Thu, 19 Jul 2018 08:15:08 +0200
Message-ID: <20180719081508.5dafebde@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

On Thu, 19 Jul 2018 01:57:02 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
> described in commit b027274d2e3a ("mtd: ams-delta: fix
> request_mem_region() failure").

Thanks for doing that. I'll review the patches, but I already have a
extra request: can you convert this driver to ->exec_op()? It does not
necessarily have to be done in this patchset, but, that'd be great to
have one more driver converted to the new interface.

BTW, there seems to be a nand_gpio driver, maybe we should merge
ams-delta code into nand_gpio after it's been patched to use the GPIO
consumer API.

> 
>  arch/arm/mach-omap1/board-ams-delta.c |   22 -
>  drivers/gpio/gpio-omap.c              |   88 ++++++
>  drivers/mtd/nand/raw/ams-delta.c      |  436 +++++++++++++++++++++-------------
>  3 files changed, 376 insertions(+), 170 deletions(-)
> 
