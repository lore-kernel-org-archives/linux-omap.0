From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API
 for data I/O
Date: Wed, 21 Nov 2018 15:56:39 +0100
Message-ID: <20181121155639.77873f7f@bbrezillon>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20181121110806.32076-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 21 Nov 2018 12:08:02 +0100
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Finalize implementation of the idea suggested by Artem Bityutskiy and
> Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
> request_mem_region() failure"). Use pure GPIO consumer API, as reqested
> by Boris Brezillon.
> 
> Janusz Krzysztofik (4):
>       ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
>       mtd: rawnand: ams-delta: Request data port GPIO resource
>       mtd: rawnand: ams-delta: Use GPIO API for data I/O
>       ARM: OMAP1: ams-delta: Drop obsolete NAND resources
> 
>  arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
>  drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
>  2 files changed, 80 insertions(+), 62 deletions(-)
> 
> Performance on Amstrad Delta is now acceptable after recent extensions
> to GPIO API and rawnanad enhancements.
> 
> Series intented to be merged via mtd tree, should not conflict with
> other OMAP1 patches submitted for 4.21.

We'll prepare an immutable tag, just in case.
