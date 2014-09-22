From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 4/5] mtd: nand: Rename OMAP NAND driver
Date: Mon, 22 Sep 2014 11:49:09 -0700
Message-ID: <20140922184909.GS1193@ld-irv-0074>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1411231996-6387-5-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63969 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbaIVStN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2014 14:49:13 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so871461pdb.0
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 11:49:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411231996-6387-5-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Roger Quadros <rogerq@ti.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Sep 20, 2014 at 05:53:15PM +0100, Ezequiel Garcia wrote:
> Rename it to a less generic name, so the module is built with a meaningful
> name instead of the previous 'omap2.ko'.

You mention renaming only so that you can change the module name, but
you also (partly at my prompting) argued for future merging of omap_nand
and omap_elm into a single module. So it seems like you might have to do
several renamings, in that case, right?

omap2.c => omap_nand.c (this patch)

omap_nand.c => <somethingelse>.c (later)
 ...so you can link somethingelse.o and omap_elm.o into omap_nand.{o,ko}

If I'm right here, then maybe (rather than multiple renames), you just
want this patch for now? (untested)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index b3237b742eb5..1a4d5e9db75b 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
-obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
+obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH)		+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
@@ -52,3 +52,4 @@ obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
 obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o
+omap_nand-objs := omap2.o

> Acked-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/mtd/nand/Makefile                  | 2 +-
>  drivers/mtd/nand/{omap2.c => omap2_nand.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/mtd/nand/{omap2.c => omap2_nand.c} (100%)

[snip]

Brian
