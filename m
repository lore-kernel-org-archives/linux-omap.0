From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: [PATCH] ARM: omap2: mtd split nand_scan in ident and tail
Date: Fri, 15 Apr 2011 15:34:56 +0200
Message-ID: <1302874496.7246.11.camel@lws-weitzel>
References: <1302772529-15641-1-git-send-email-j.weitzel@phytec.de>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.de ([217.6.246.34]:47937 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607Ab1DONfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 09:35:19 -0400
In-Reply-To: <1302772529-15641-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: s.hauer@pengutronix.de, dwmw2@infradead.org, tony@atomide.com, s-ghorai@ti.com, vimalsingh@ti.com, Artem.Bityutskiy@nokia.com

Am Donnerstag, den 14.04.2011, 11:15 +0200 schrieb Jan Weitzel:
> nand_scan calls nand_scan_ident and nand_scan_tail, setting values like oobvail
> according to ecc.layout. If we change the layout afterwards values are wrong.
> 
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> ---
>  drivers/mtd/nand/omap2.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index da9a351..288423f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1073,9 +1073,9 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  	/* DIP switches on some boards change between 8 and 16 bit
>  	 * bus widths for flash.  Try the other width if the first try fails.
>  	 */
> -	if (nand_scan(&info->mtd, 1)) {
> +	if (nand_scan_ident(&info->mtd, 1, NULL)) {
>  		info->nand.options ^= NAND_BUSWIDTH_16;
> -		if (nand_scan(&info->mtd, 1)) {
> +		if (nand_scan_ident(&info->mtd, 1, NULL)) {
>  			err = -ENXIO;
>  			goto out_release_mem_region;
>  		}
> @@ -1101,6 +1101,12 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  		info->nand.ecc.layout = &omap_oobinfo;
>  	}
>  
> +	/* second phase scan */
> +	if (nand_scan_tail(&info->mtd)) {
> +		err = -ENXIO;
> +		goto out_release_mem_region;
> +	}
> +
>  #ifdef CONFIG_MTD_PARTITIONS
>  	err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
>  	if (err > 0)

So no comments? Is any rework needed? Without this patch I am not able
to mount partions with OMAP_ECC_HAMMING_CODE_HW_ROMCODE. 
Regards, Jan

