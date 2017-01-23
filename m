From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1/2: clock: Remove unused mpurate cmdline option
Date: Mon, 23 Jan 2017 07:10:56 -0800
Message-ID: <20170123151055.GQ7403@atomide.com>
References: <1485020215-6550-1-git-send-email-amurray@embedded-bits.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1485020215-6550-1-git-send-email-amurray@embedded-bits.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Andrew Murray <amurray@embedded-bits.co.uk> [170121 09:38]:
> The 'mpurate' option, historically used for specifying an initial
> MPU rate at boot, no longer has any effect due to the supporting
> code being removed as it was 'wrong and dangerous' [1].
> 
> This patch removes the remaining dead code associated with the
> __setup macros to avoid confusion and reduce bloat.
> 
> [1] https://patchwork.kernel.org/patch/5954631/

Yeah AFAIK this is unused for mach-omap2. Adding Aaro to
Cc for mach-omap1 in case there might be issues with this
patch.

Regards,

Tony


> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
> ---
>  arch/arm/mach-omap1/clock.c | 20 --------------------
>  arch/arm/mach-omap1/clock.h |  2 --
>  arch/arm/mach-omap2/clock.c | 20 --------------------
>  3 files changed, 42 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 4f5fd4a..43e3e18 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -720,26 +720,6 @@ EXPORT_SYMBOL(clk_get_parent);
>   * OMAP specific clock functions shared between omap1 and omap2
>   */
>  
> -int __initdata mpurate;
> -
> -/*
> - * By default we use the rate set by the bootloader.
> - * You can override this with mpurate= cmdline option.
> - */
> -static int __init omap_clk_setup(char *str)
> -{
> -	get_option(&str, &mpurate);
> -
> -	if (!mpurate)
> -		return 1;
> -
> -	if (mpurate < 1000)
> -		mpurate *= 1000000;
> -
> -	return 1;
> -}
> -__setup("mpurate=", omap_clk_setup);
> -
>  /* Used for clocks that always have same value as the parent clock */
>  unsigned long followparent_recalc(struct clk *clk)
>  {
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index 1e4918a..f2d1be2 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -173,8 +173,6 @@ struct clk_functions {
>  	void		(*clk_disable_unused)(struct clk *clk);
>  };
>  
> -extern int mpurate;
> -
>  extern int clk_init(struct clk_functions *custom_clocks);
>  extern void clk_preinit(struct clk *clk);
>  extern int clk_register(struct clk *clk);
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index d058125..d999295 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -112,26 +112,6 @@ void omap2_init_clk_clkdm(struct clk_hw *hw)
>  	}
>  }
>  
> -static int __initdata mpurate;
> -
> -/*
> - * By default we use the rate set by the bootloader.
> - * You can override this with mpurate= cmdline option.
> - */
> -static int __init omap_clk_setup(char *str)
> -{
> -	get_option(&str, &mpurate);
> -
> -	if (!mpurate)
> -		return 1;
> -
> -	if (mpurate < 1000)
> -		mpurate *= 1000000;
> -
> -	return 1;
> -}
> -__setup("mpurate=", omap_clk_setup);
> -
>  /**
>   * omap2_clk_print_new_rates - print summary of current clock tree rates
>   * @hfclkin_ck_name: clk name for the off-chip HF oscillator
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
