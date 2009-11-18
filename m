From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] omap3: zoom2/3: make MMC slot work again
Date: Wed, 18 Nov 2009 11:04:40 -0600
Message-ID: <003f01ca6871$37cd3930$544ff780@am.dhcp.ti.com>
References: <1258551550-25301-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45133 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757746AbZKRREi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Nov 2009 12:04:38 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAIH4ijs031323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 11:04:44 -0600
In-Reply-To: <1258551550-25301-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Anand Gadiyar' <gadiyar@ti.com>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Anand Gadiyar
> Sent: Wednesday, November 18, 2009 7:39 AM
> To: linux-omap@vger.kernel.org
> Cc: Anand Gadiyar
> Subject: [PATCH] omap3: zoom2/3: make MMC slot work again
> 
> omap3: zoom2/3: make MMC slot work again
> 
> Commit 12f8dfb56 accidentally broke MMC on zoom2/3.
> The .vmmc1 field of zoom_twldata was deleted. Restoring it
> allows the MMC slot to work again
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Good catch. Ack.
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-zoom-peripherals.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -236,6 +236,7 @@ static struct twl4030_platform_data zoom
>  	.gpio		= &zoom_gpio_data,
>  	.keypad		= &zoom_kp_twl4030_data,
>  	.codec		= &zoom_codec_data,
> +	.vmmc1          = &zoom_vmmc1,
>  	.vmmc2          = &zoom_vmmc2,
>  	.vsim           = &zoom_vsim,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


