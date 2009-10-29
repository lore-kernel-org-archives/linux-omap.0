From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap2: mux: intoduce omap_mux_{read,write}
Date: Thu, 29 Oct 2009 08:50:11 -0700
Message-ID: <20091029155010.GI7180@atomide.com>
References: <cover.1256734115.git.mike@compulab.co.il> <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52500 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbZJ2PuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 11:50:10 -0400
Content-Disposition: inline
In-Reply-To: <afa6b6ded8db35578a200c71938174a61eaa4ef9.1256734115.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [091028 06:17]:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-omap2/mux.c |   25 +++++++++++++++++++------
>  1 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 32c953e..eb6e202 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -37,6 +37,22 @@
>  
>  static struct omap_mux_cfg arch_mux_cfg;
>  
> +static inline u16 omap_mux_read(u16 reg)
> +{
> +	if (cpu_is_omap24xx())
> +		return omap_ctrl_readb(reg);
> +	else
> +		return omap_ctrl_readw(reg);
> +}
> +
> +static inline void omap_mux_write(u16 val, u16 reg)
> +{
> +	if (cpu_is_omap24xx())
> +		return omap_ctrl_writeb(val, reg);
> +	else
> +		return omap_ctrl_writew(val, reg);
> +}
> +

The void function should not return any values above..

I suggest we standardize on:

static void __iomem *mux_base;

static inline u16 omap_mux_read(u16 reg)
{
       if (cpu_is_omap24xx())
               return __raw_readb(mux_base + reg);
       else
               return __raw_readw(mux_base + reg);
}

static inline void _omap_mux_write(u16 val, u16 reg)
{
       if (cpu_is_omap24xx())
               __raw_writeb(val, mux_base + reg);
       else
               __raw_writew(val, mux_base + reg);
}

And then ioremap the mux_base during init. We should
also specifiy the mux base as the start of the mux
registers, 0x48002030 for omap3 instead of the ctrl
base at 0x48002000.

This means that we should deduct 0x30 from the
existing offset values to make conversion to new
data less error prone..

>  /* NOTE: See mux.h for the enumeration */
>  
>  #ifdef CONFIG_ARCH_OMAP24XX
> @@ -566,10 +582,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
>  	u16 orig;
>  	u8 warn = 0, debug = 0;
>  
> -	if (cpu_is_omap24xx())
> -		orig = omap_ctrl_readb(cfg->mux_reg);
> -	else
> -		orig = omap_ctrl_readw(cfg->mux_reg);
> +	orig = omap_mux_read(cfg->mux_reg);
>  
>  #ifdef	CONFIG_OMAP_MUX_DEBUG
>  	debug = cfg->debug;

Or maybe use orig = omap_mux_read(cfg->mux_reg - 0x30);
here instead for the old mux data?

> @@ -599,7 +612,7 @@ static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
>  	if (cfg->pu_pd_val)
>  		reg |= OMAP2_PULL_UP;
>  	omap2_cfg_debug(cfg, reg);
> -	omap_ctrl_writeb(reg, cfg->mux_reg);
> +	omap_mux_write(reg, cfg->mux_reg);
>  	spin_unlock_irqrestore(&mux_spin_lock, flags);
>  
>  	return 0;
> @@ -618,7 +631,7 @@ static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
>  	spin_lock_irqsave(&mux_spin_lock, flags);
>  	reg |= cfg->mux_val;
>  	omap2_cfg_debug(cfg, reg);
> -	omap_ctrl_writew(reg, cfg->mux_reg);
> +	omap_mux_write(reg, cfg->mux_reg);
>  	spin_unlock_irqrestore(&mux_spin_lock, flags);
>  
>  	return 0;
> -- 
> 1.6.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
