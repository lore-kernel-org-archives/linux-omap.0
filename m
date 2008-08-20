From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] sdrc register defs
Date: Wed, 20 Aug 2008 15:50:23 +0300
Message-ID: <20080820125021.GL29374@atomide.com>
References: <43340.192.168.10.89.1218028472.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65439 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbYHTMur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 08:50:47 -0400
Content-Disposition: inline
In-Reply-To: <43340.192.168.10.89.1218028472.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [080806 16:16]:
> This patch adds some missing sdrc register definitions

Pushing this today (after header path rewriting).

Tony

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> ---
>  arch/arm/mach-omap2/sram34xx.S   |    4 ++--
>  include/asm-arm/arch-omap/sdrc.h |   13 +++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/sram34xx.S
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/sram34xx.S	2008-08-06
> 18:07:31.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/sram34xx.S	2008-08-06 18:10:18.000000000
> +0530
> @@ -165,9 +165,9 @@ omap3_cm_iclken1_core:
>  omap3_sdrc_rfr_ctrl:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
>  omap3_sdrc_actim_ctrla:
> -	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A)
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
>  omap3_sdrc_actim_ctrlb:
> -	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B)
> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
>  omap3_sdrc_dlla_status:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  omap3_sdrc_dlla_ctrl:
> Index: linux-omap-2.6/include/asm-arm/arch-omap/sdrc.h
> ===================================================================
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/sdrc.h	2008-08-06
> 18:07:31.000000000 +0530
> +++ linux-omap-2.6/include/asm-arm/arch-omap/sdrc.h	2008-08-06
> 18:10:18.000000000 +0530
> @@ -21,15 +21,24 @@
>  /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
> 
>  #define SDRC_SYSCONFIG		0x010
> +#define SDRC_CS_CFG		0x040
> +#define SDRC_SHARING		0x044
> +#define SDRC_ERR_TYPE		0x04C
>  #define SDRC_DLLA_CTRL		0x060
>  #define SDRC_DLLA_STATUS	0x064
>  #define SDRC_DLLB_CTRL		0x068
>  #define SDRC_DLLB_STATUS	0x06C
>  #define SDRC_POWER		0x070
> +#define SDRC_MCFG_0		0x080
>  #define SDRC_MR_0		0x084
> -#define SDRC_ACTIM_CTRL_A	0x09c
> -#define SDRC_ACTIM_CTRL_B	0x0a0
> +#define SDRC_ACTIM_CTRL_A_0	0x09c
> +#define SDRC_ACTIM_CTRL_B_0	0x0a0
>  #define SDRC_RFR_CTRL_0		0x0a4
> +#define SDRC_MCFG_1		0x0B0
> +#define SDRC_MR_1		0x0B4
> +#define SDRC_ACTIM_CTRL_A_1	0x0C4
> +#define SDRC_ACTIM_CTRL_B_1	0x0C8
> +#define SDRC_RFR_CTRL_1		0x0D4
> 
>  /*
>   * These values represent the number of memory clock cycles between
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
