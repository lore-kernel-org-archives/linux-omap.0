From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH][OMAPZOOM] OMAP3: Initialize XCCR and RCCR registers
	for McBSP DAI driver
Date: Mon, 15 Dec 2008 16:16:58 -0800
Message-ID: <20081216001658.GG19551@atomide.com>
References: <1227565078-29925-1-git-send-email-x0052729@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50131 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbYLPARA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 19:17:00 -0500
Content-Disposition: inline
In-Reply-To: <1227565078-29925-1-git-send-email-x0052729@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0052729@ti.com
Cc: linux-omap@vger.kernel.org, vikram.pandita@ti.com

* x0052729@ti.com <x0052729@ti.com> [081124 14:18]:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> This patch initializes XCCR and RCCR registers for OMAP McBSP DAI driver for
> OMAP 2430/34xx platforms. Those registers were being set to 0 as they were
> not properly initialized.

This patch should be refreshed against the mainline kernel so I can
pick it up for merging.

Regards,

Tony

> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    5 +++++
>  arch/arm/plat-omap/mcbsp.c              |    1 +
>  sound/soc/omap/omap-mcbsp.c             |    4 ++++
>  3 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index 3e38575..faa9164 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -245,11 +245,16 @@
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
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 906e8e3..2b29033 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -174,6 +174,7 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
>  	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
>  	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
>  	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
> +	/* Write to xccr and rccr only for omap2430/34xx */
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>  		if (mcbsp->pdata->ops->config)
>  			mcbsp->pdata->ops->config(id, config);
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 3a4cc4b..51a9313 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -285,6 +285,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  	regs->spcr1	|= RINTM(3);
>  	regs->rcr2	|= RFIG;
>  	regs->xcr2	|= XFIG;
> +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +		regs->xccr = DXENDLY(1) | XDMAEN;
> +		regs->rccr = RFULL_CYCLE | RDMAEN;
> +	}
>  
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
