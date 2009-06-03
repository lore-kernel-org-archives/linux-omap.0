From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 Overo: add EXPORT_SYMBOLs for Overo ASoC audio
	to be built as a module.
Date: Wed, 3 Jun 2009 09:31:06 -0700
Message-ID: <20090603163105.GB5026@atomide.com>
References: <5a7b8b7b0906011802y4abc5ba6m8813d6884825e805@mail.gmail.com> <20090602173543.GE27332@atomide.com> <20090603162012.877be077.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58300 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZFCQbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 12:31:07 -0400
Content-Disposition: inline
In-Reply-To: <20090603162012.877be077.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Hugo Vincent <hugo.vincent@gmail.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [090603 06:20]:
> On Tue, 2 Jun 2009 10:35:43 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Hugo Vincent <hugo.vincent@gmail.com> [090601 18:03]:
> > > I'm pretty new to kernel development, so I don't know any potential
> > > problems with doing this, but without this, audio/ASoC support must be
> > > built into the kernel (modpost fails when trying to build as modules),
> > > whereas with this patch, it can be built and used as a module.
> > > 
> > > Comments?
> > 
> > To me it looks like we should rather fix sound/soc/omap/omap-mcbsp.c
> > to use the clock framework rather than access omap_ctrl_read/write
> > directly.
> > 
> Yeah, I have something like below in my mind.
> 
> I don't know is this idea working but at least I know there is need to define
> McBSP FCLK parent clocks for 24xx similar way as they are defined for
> 34xx and to figure out something for the FIXMEs. McBSP module is
> enabling the clocks at request time but fclk must be off in order to change
> its parent.

Sounds like you might be able to fix this easily with clk_add_alias()
like what's queued up for 770 framebuffer:

http://patchwork.kernel.org/patch/26796/

This patch to make clk_add_alias() common is not merged yet though.

Tony
 
> -- 
> Jarkko
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index bb154ea..3ebbe3f 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -389,6 +389,7 @@ int omap_mcbsp_request(unsigned int id);
>  void omap_mcbsp_free(unsigned int id);
>  void omap_mcbsp_start(unsigned int id);
>  void omap_mcbsp_stop(unsigned int id);
> +int omap_mcbsp_set_fclk_src(unsigned int id, const char *clk_name);
>  void omap_mcbsp_xmit_word(unsigned int id, u32 word);
>  u32 omap_mcbsp_recv_word(unsigned int id);
>  
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index efa0e01..f36c6a6 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -398,6 +398,30 @@ void omap_mcbsp_stop(unsigned int id)
>  }
>  EXPORT_SYMBOL(omap_mcbsp_stop);
>  
> +int omap_mcbsp_set_fclk_src(unsigned int id, const char *clk_name)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	struct clk *fclk_src;
> +	int err;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	mcbsp = id_to_mcbsp_ptr(id);
> +	fclk_src = clk_get(mcbsp->dev, clk_name);
> +	if (IS_ERR(fclk_src))
> +		return PTR_ERR(fclk_src);
> +	clk_disable(mcbsp->fclk); /* FIXME, Hack! */
> +	err = clk_set_parent(mcbsp->fclk, fclk_src);
> +	clk_enable(mcbsp->fclk); /* FIXME, Hack! */
> +	clk_put(fclk_src);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_set_fclk_src);
> +
>  /* polled mcbsp i/o operations */
>  int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
>  {
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 9126142..d03a3c0 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -397,8 +397,7 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
>  static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
>  				       int clk_id)
>  {
> -	int sel_bit;
> -	u16 reg, reg_devconf1 = OMAP243X_CONTROL_DEVCONF1;
> +	const char *clks_src;
>  
>  	if (cpu_class_is_omap1()) {
>  		/* OMAP1's can use only external source clock */
> @@ -408,43 +407,16 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
>  			return 0;
>  	}
>  
> -	if (cpu_is_omap2420() && mcbsp_data->bus_id > 1)
> -		return -EINVAL;
> -
> -	if (cpu_is_omap343x())
> -		reg_devconf1 = OMAP343X_CONTROL_DEVCONF1;
> -
> -	switch (mcbsp_data->bus_id) {
> -	case 0:
> -		reg = OMAP2_CONTROL_DEVCONF0;
> -		sel_bit = 2;
> -		break;
> -	case 1:
> -		reg = OMAP2_CONTROL_DEVCONF0;
> -		sel_bit = 6;
> -		break;
> -	case 2:
> -		reg = reg_devconf1;
> -		sel_bit = 0;
> -		break;
> -	case 3:
> -		reg = reg_devconf1;
> -		sel_bit = 2;
> -		break;
> -	case 4:
> -		reg = reg_devconf1;
> -		sel_bit = 4;
> -		break;
> -	default:
> -		return -EINVAL;
> +	if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK) {
> +		if (cpu_is_omap24xx())
> +			clks_src = "func_96m_ck";
> +		if (cpu_is_omap343x())
> +			clks_src = "core_96m_fck";
> +	} else {
> +		clks_src = "mcbsp_clks";
>  	}
>  
> -	if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK)
> -		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
> -	else
> -		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
> -
> -	return 0;
> +	return omap_mcbsp_set_fclk_src(mcbsp_data->bus_id, clks_src);
>  }
>  
>  static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
