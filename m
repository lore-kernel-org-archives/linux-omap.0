From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Initialize XCCR and RCCR McBSP registers
	for McBSP DAI driver
Date: Thu, 18 Dec 2008 15:41:37 +0200
Message-ID: <20081218134137.GD30366@atomide.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49514 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYLRNll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 08:41:41 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

* Lopez Cruz, Misael <x0052729@ti.com> [081218 12:16]:
> This patch enables XCCR and RCCR McBSP register writing in OMAP 24xx/34xx
> platforms. It also explicitly initializes those registers to their default
> values in ASoC McBSP DAI driver.

Can you please describe a bit what these registers do? It's impossible
for anybody to decipher without looking at the TRM right now.

> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    6 ++++++
>  arch/arm/plat-omap/mcbsp.c              |    4 ++++
>  sound/soc/omap/omap-mcbsp.c             |    4 ++++
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index 6a0d1a0..5885f3a 100644
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
> @@ -267,6 +271,8 @@ struct omap_mcbsp_reg_cfg {
>  	u16 rcerh;
>  	u16 xcerg;
>  	u16 xcerh;
> +	u16 xccr;
> +	u16 rccr;
>  };
>  
>  typedef enum {
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index af33fc7..d71b30b 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -173,6 +173,10 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
>  	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
>  	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
>  	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +		OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
> +		OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
> +	}
>  }
>  EXPORT_SYMBOL(omap_mcbsp_config);
>  

You can do the above with cpu_class_is_omap2() instead. Might be worth
checking that these registers are available on 2420 too.

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 8485a8a..2e7000d 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -295,6 +295,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  	regs->spcr1	|= RINTM(3);
>  	regs->rcr2	|= RFIG;
>  	regs->xcr2	|= XFIG;
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +		regs->xccr = DXENDLY(1) | XDMAEN;
> +		regs->rccr = RFULL_CYCLE | RDMAEN;
> +	}
>  
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> -- 

I agree with Jarkko's comment, the ASoC change should go via alsa list
as a separate patch.

Regards,

Tony

