From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [v2] ARM: omap1: add nand_chip declaration
Date: Wed, 26 Sep 2018 07:59:32 -0700
Message-ID: <20180926145932.GR5662@atomide.com>
References: <20180926142029.619397-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926142029.619397-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Paul Burton <paul.burton@mips.com>, Wolfram Sang <wsa@the-dreams.de>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180926 14:26]:
> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: remove unused linux/mtd/mtd.h inclusion

Acked-by: Tony Lindgren <tony@atomide.com>
