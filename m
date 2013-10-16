From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 4/9] mtd: nand: omap: enable auto-detection of
 bus-width for omap-nand drivers
Date: Wed, 16 Oct 2013 15:22:48 -0700
Message-ID: <20131016222248.GZ23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:54022 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760894Ab3JPWWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 18:22:54 -0400
Content-Disposition: inline
In-Reply-To: <1381816197-20477-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Oct 15, 2013 at 11:19:52AM +0530, Pekon Gupta wrote:
> Autodetection of NAND device bus-width was added in generic NAND driver as
> part of following commit
> 	commit 64b37b2a63eb2f80b65c7185f0013f8ffc637ae3
> 	Author:     Matthieu CASTET <matthieu.castet@parrot.com>
> 	AuthorDate: 2012-11-06
> 	mtd: nand: add NAND_BUSWIDTH_AUTO to autodetect bus width
> This patch enables this feature for OMAP2 NAND driver
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/omap2.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 5596368..57a3f51 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c

[...]

> @@ -1904,6 +1903,21 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->chip_delay = 50;
>  	}
>  
> +	/* scan for NAND device connected to chip controller */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		err = -ENXIO;
> +		goto out_release_mem_region;
> +	}
> +	if ((nand_chip->options & NAND_BUSWIDTH_16) !=
> +			(pdata->devsize & NAND_BUSWIDTH_16)) {
> +		pr_err("%s: detected %s device but driver configured for %s\n",
> +			DRIVER_NAME,
> +			(nand_chip->options & NAND_BUSWIDTH_16) ? "x16" : "x8",
> +			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");

I'm not sure on the policy choice here; if you're using BUSWIDTH_AUTO,
do you even want to try to configure the buswidth by platform data?
You're not really getting the full use out of NAND_BUSWIDTH_AUTO because
the platform data has to guess the same buswidth that nand_base.c
determines. This is worse than the previous behavior, in which you would
try both buswidths if the specified type failed.

IOW, what are you trying to achieve with auto-buswidth? Automatic
determination of the buswidth or just automatic validation? What do you
achieve with platform data's selection of buswidth? Specification of the
buswidth or just a hint? Do the goals conflict? Perhaps you can just
warn, and not error out if the two selections don't match? Or maybe you
really wanted to replace the platform data selection mechanism entirely
with auto-buswidth?

> +		err = -EINVAL;
> +		goto out_release_mem_region;
> +	}
> +
>  	switch (pdata->xfer_type) {
>  	case NAND_OMAP_PREFETCH_POLLED:
>  		nand_chip->read_buf   = omap_read_buf_pref;

[...]

Brian
