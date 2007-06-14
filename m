From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 9 /12 ] Plat-omap files updating to support OMAP3
Date: Thu, 14 Jun 2007 04:58:22 -0700
Message-ID: <20070614115821.GH28804@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011E6098@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E6098@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070613 22:06]:
> Plat-omap files updating to support OMAP3
> 

<snip>

> diff -purN linux-omap/arch/arm/plat-omap/dmtimer.c val_3430_GIT/arch/arm/plat-omap/dmtimer.c
> --- linux-omap/arch/arm/plat-omap/dmtimer.c	2007-04-04 18:13:49.000000000 -0500
> +++ val_3430_GIT/arch/arm/plat-omap/dmtimer.c	2007-06-13 16:45:06.000000000 -0500
> @@ -70,7 +70,7 @@
>  struct omap_dm_timer {
>  	unsigned long phys_base;
>  	int irq;
> -#ifdef CONFIG_ARCH_OMAP2
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  	struct clk *iclk, *fclk;
>  #endif
>  	void __iomem *io_base;
> @@ -122,6 +122,34 @@ static const char *dm_source_names[] = {
>  
>  static struct clk *dm_source_clocks[3];
>  
> +#elif defined(CONFIG_ARCH_OMAP3)
> +
> +#define omap_dm_clk_enable(x) clk_enable(x)
> +#define omap_dm_clk_disable(x) clk_disable(x)
> +
> +static struct omap_dm_timer dm_timers[] = {
> +	{ .phys_base	= 0x48318000, .irq	= INT_24XX_GPTIMER1 },
> +	{ .phys_base	= 0x49032000, .irq	= INT_24XX_GPTIMER2 },
> +	{ .phys_base	= 0x49034000, .irq	= INT_24XX_GPTIMER3 },
> +	{ .phys_base	= 0x49036000, .irq	= INT_24XX_GPTIMER4 },
> +	{ .phys_base	= 0x49038000, .irq	= INT_24XX_GPTIMER5 },
> +	{ .phys_base	= 0x4903A000, .irq	= INT_24XX_GPTIMER6 },
> +	{ .phys_base	= 0x4903C000, .irq	= INT_24XX_GPTIMER7 },
> +	{ .phys_base	= 0x4903E000, .irq	= INT_24XX_GPTIMER8 },
> +	{ .phys_base	= 0x49040000, .irq	= INT_24XX_GPTIMER9 },
> +	{ .phys_base	= 0x48086000, .irq	= INT_24XX_GPTIMER10 },
> +	{ .phys_base	= 0x48088000, .irq	= INT_24XX_GPTIMER11 },
> +	{ .phys_base	= 0x48304000, .irq	= INT_24XX_GPTIMER12 },
> +};
> +
> +static const char *dm_source_names[] = {
> +	"sys_ck",
> +	"func_32k_ck",
> +	"alt_ck"
> +};
> +
> +static struct clk *dm_source_clocks[3];
> +
>  #else
>  
>  #error OMAP architecture not supported!

This adds an extra artificial barrier to compiling in omap2 and omap3.
Could you please change to be something like this:

#ifdef CONFIG_ARCH_OMAP1
...

#elif defined(CONFIG_ARCH_OMAP2)

#ifdef CONFIG_ARCH_OMAP24XX
static struct omap_dm_timer omap24xx_dmtimers[] = {
...
};
#endif

#ifdef CONFIG_ARCH_OMAP34XX
static struct omap34xx_dmtimers[] = {
...
};
#endif
#endif

Then just put the right table in place during init like you did
in io.c.


> @@ -171,7 +199,7 @@ static void omap_dm_timer_reset(struct o
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
>  	l |= 0x02 << 3;
>  
> -	if (cpu_class_is_omap2() && timer == &dm_timers[0]) {
> +	if (cpu_class_is_omap2() && (timer == &dm_timers[0])) {
>  		/* Enable wake-up only for GPT1 on OMAP2 CPUs*/
>  		l |= 1 << 2;
>  		/* Non-posted mode */
> @@ -191,7 +219,6 @@ struct omap_dm_timer *omap_dm_timer_requ
>  	struct omap_dm_timer *timer = NULL;
>  	unsigned long flags;
>  	int i;
> -
>  	spin_lock_irqsave(&dm_timer_lock, flags);
>  	for (i = 0; i < dm_timer_count; i++) {
>  		if (dm_timers[i].reserved)

This line removal seems unnecessary.


> diff -purN linux-omap/arch/arm/plat-omap/gpio.c val_3430_GIT/arch/arm/plat-omap/gpio.c
> --- linux-omap/arch/arm/plat-omap/gpio.c	2007-05-07 20:57:49.000000000 -0500
> +++ val_3430_GIT/arch/arm/plat-omap/gpio.c	2007-06-13 16:45:33.000000000 -0500
...
> @@ -1290,7 +1328,7 @@ static int __init _omap_gpio_init(void)
>  				clk_enable(gpio5_fck);
>  		}
>  #endif
> -}
> +	}
>  
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap15xx()) {

Is the formatting change above correct?

Regards,

Tony
