From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2]OMAP3 NAND: Enable support for nand driver on
	OMAP3430
Date: Mon, 6 Oct 2008 14:21:21 +0300
Message-ID: <20081006112120.GG2806@atomide.com>
References: <19F8576C6E063C45BE387C64729E739403CD517C24@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56843 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbYJFLSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 07:18:22 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD517C24@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Singh, Vimal" <vimalsingh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Singh, Vimal <vimalsingh@ti.com> [080826 13:19]:
> From: Teerth Reddy <teerth@ti.com>
> 
> This patch enables the support for nand driver on 3430sdp

Pushing today.

Tony

> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig  |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletion(-)
> 
> Index : linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
> =====================================================================================
> --- a/arch/arm/configs/omap_3430sdp_defconfig 2008-08-06 13:03:38.859241000 +0530
> +++ b/arch/arm/configs/omap_3430sdp_defconfig 2008-08-05 16:02:20.037348000 +0530
> @@ -493,7 +493,17 @@ CONFIG_MTD_OMAP_NOR=y
>  # CONFIG_MTD_DOC2000 is not set
>  # CONFIG_MTD_DOC2001 is not set
>  # CONFIG_MTD_DOC2001PLUS is not set
> -# CONFIG_MTD_NAND is not set
> +CONFIG_MTD_NAND=y
> +# CONFIG_MTD_NAND_VERIFY_WRITE is not set
> +CONFIG_MTD_NAND_ECC_SMC=y
> +# CONFIG_MTD_NAND_MUSEUM_IDS is not set
> +CONFIG_MTD_NAND_OMAP2=y
> +CONFIG_MTD_NAND_OMAP_HWECC=y
> +CONFIG_MTD_NAND_IDS=y
> +# CONFIG_MTD_NAND_DISKONCHIP is not set
> +# CONFIG_MTD_NAND_NANDSIM is not set
> +# CONFIG_MTD_NAND_PLATFORM is not set
> +# CONFIG_MTD_ALAUDA is not set
>  CONFIG_MTD_ONENAND=y
>  CONFIG_MTD_ONENAND_VERIFY_WRITE=y
>  # CONFIG_MTD_ONENAND_GENERIC is not set--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
