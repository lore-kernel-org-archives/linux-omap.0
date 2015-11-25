From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx
 hwmod data
Date: Wed, 25 Nov 2015 10:55:20 -0800
Message-ID: <20151125185520.GO2517@atomide.com>
References: <56461001.3050707@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56461001.3050707@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [151113 08:30]:
> Add missing HWMOD_NO_IDLEST hwmod flag for entries not
> having omap4 clkctrl values.
> The emac0 hwmod flag fixes the davinci_emac driver probe
> since the return of pm_resume() call is now checked.
> 
> This solves the following boot errors :
> [    0.121429] omap_hwmod: l4_ls: _wait_target_ready failed: -16
> [    0.121441] omap_hwmod: l4_ls: cannot be enabled for reset (3)
> [    0.124342] omap_hwmod: l4_hs: _wait_target_ready failed: -16
> [    0.124352] omap_hwmod: l4_hs: cannot be enabled for reset (3)
> [    1.967228] omap_hwmod: emac0: _wait_target_ready failed: -16
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for checking the TI tree also in addition to the docs,
applying this one into omap-for-v4.4/fixes.

Tony


> ---
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> index b1288f5..6256052 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> @@ -144,6 +144,7 @@ static struct omap_hwmod dm81xx_l4_ls_hwmod = {
>  	.name		= "l4_ls",
>  	.clkdm_name	= "alwon_l3s_clkdm",
>  	.class		= &l4_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,
>  };
> 
>  /*
> @@ -155,6 +156,7 @@ static struct omap_hwmod dm81xx_l4_hs_hwmod = {
>  	.name		= "l4_hs",
>  	.clkdm_name	= "alwon_l3_med_clkdm",
>  	.class		= &l4_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,
>  };
> 
>  /* L3 slow -> L4 ls peripheral interface running at 125MHz */
> @@ -850,6 +852,7 @@ static struct omap_hwmod dm816x_emac0_hwmod = {
>  	.name		= "emac0",
>  	.clkdm_name	= "alwon_ethernet_clkdm",
>  	.class		= &dm816x_emac_hwmod_class,
> +	.flags		= HWMOD_NO_IDLEST,
>  };
> 
>  static struct omap_hwmod_ocp_if dm81xx_l4_hs__emac0 = {
> -- 
> 1.9.1
> 
