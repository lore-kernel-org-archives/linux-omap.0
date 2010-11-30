From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] omap: nand: remove hardware ECC as default
Date: Tue, 30 Nov 2010 10:09:59 -0800
Message-ID: <20101130180958.GQ17222@atomide.com>
References: <1290177926-3526-1-git-send-email-s-ghorai@ti.com>
 <20101130180542.GP17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23878 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab0K3SKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 13:10:03 -0500
Content-Disposition: inline
In-Reply-To: <20101130180542.GP17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101130 09:56]:
> * Sukumar Ghorai <s-ghorai@ti.com> [101119 06:36]:
> > CONFIG_MTD_NAND_OMAP_HWECC defined wrongly in patch submitted for 2.6.36.
> > This flag enables hw ecc by default. Boards like beagle and pandora uses
> > sw ecc for write (e.g. binary flushed from u-boot) and read from kernel.
> > https://patchwork.kernel.org/patch/111036/

Although instead of the link above it should say:

Commit 2c01946c6b9ebaa5a89710bc42ca224a7f52f227 (omap3 nand: cleanup
virtual address usages) wrongly enabled CONFIG_MTD_NAND_OMAP_HWECC
which breaks boards like beagle and pandora that use software ECC
for write.
 
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> 
> This should go in as a fix for the -rc via MTD list if possible.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> > ---
> >  drivers/mtd/nand/omap2.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index cd41c58..15682ec 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -7,7 +7,6 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > -#define CONFIG_MTD_NAND_OMAP_HWECC
> >  
> >  #include <linux/platform_device.h>
> >  #include <linux/dma-mapping.h>
> > -- 
> > 1.7.0.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
