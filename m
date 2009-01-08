From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Enable writing to XCCR and RCCR McBSP
	registers for OMAP 2430/34xx
Date: Thu, 8 Jan 2009 17:57:19 +0200
Message-ID: <20090108155718.GX27566@atomide.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57791 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbZAHP5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 10:57:20 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

* Lopez Cruz, Misael <x0052729@ti.com> [081219 04:53]:
> This patch enables writing to McBSP Transmit Configuration Control
> Register (XCCR) and Receive Configuration Control Register (RCCR)
> for 2430/34xx platforms. It also adds XCCR, RCCR entries in McBSP
> register configuration structure and bit definitions for both
> registers.

Pushing to l-o. Can you briefly describe what happens with ASoC
if these registers are not used? We may be able to send this
as a fix to mainline during the -rc cycle.

Regards,

Tony

> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    7 +++++++
>  arch/arm/plat-omap/mcbsp.c              |    4 ++++
>  2 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index 6a0d1a0..cc48f2f 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -231,11 +231,16 @@
>  #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
>  
>  /*********************** McBSP XCCR bit definitions *************************/
> +#define EXTCLKGATE		0x8000
> +#define PPCONNECT		0x4000
> +#define DXENDLY(value)		((value)<<12)	/* Bits 12:13 */
> +#define XFULL_CYCLE		0x0800
>  #define DILB			0x0020
>  #define XDMAEN			0x0008
>  #define XDISABLE		0x0001
>  
>  /********************** McBSP RCCR bit definitions *************************/
> +#define RFULL_CYCLE		0x0800
>  #define RDMAEN			0x0008
>  #define RDISABLE		0x0001
>  
> @@ -267,6 +272,8 @@ struct omap_mcbsp_reg_cfg {
>  	u16 rcerh;
>  	u16 xcerg;
>  	u16 xcerh;
> +	u16 xccr;
> +	u16 rccr;
>  };
>  
>  typedef enum {
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index af33fc7..f2401a8 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -173,6 +173,10 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
>  	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
>  	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
>  	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
> +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
> +		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
> +	}
>  }
>  EXPORT_SYMBOL(omap_mcbsp_config);
>  
> -- 
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
