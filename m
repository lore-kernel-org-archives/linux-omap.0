From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] FIX BUG in GPT1 Clock Selection
Date: Fri, 12 Oct 2007 13:25:25 -0700
Message-ID: <20071012202525.GI7979@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701F4A222@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701F4A222@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [071010 16:21]:
> The GPT1 CLK SEL register was getting wrong src register, due to which GPT1 was not able to select SYS_CLK as input.
> 
> Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
> 
> File:
>  arch/arm/mach-omap2/clock24xx.h
> =======================================================================
> 
> diff -purN linux-omap/arch/arm/mach-omap2/clock24xx.h my_linux-omap/arch/arm/mach-omap2/clock24xx.h
> --- linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-10-09 18:14:08.000000000 -0500
> +++ my_linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-10-10 17:27:07.000000000 -0500
> @@ -1489,7 +1489,7 @@ static struct clk gpt1_fck = {
>  	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
>  	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
>  	.init		= &omap2_init_clksel_parent,
> -	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
> +	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL1),
>  	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
>  	.clksel		= omap24xx_gpt_clksel,
>  	.recalc		= &omap2_clksel_recalc,

Pushing today.

Tony
