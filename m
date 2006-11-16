From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] plat-omap changes for 2430 SDP
Date: Thu, 16 Nov 2006 02:53:13 +0200
Message-ID: <20061116005313.GJ21064@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA524@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFA524@DLEE09.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Some comments below.

* Syed Mohammed, Khasim <x0khasim@ti.com> [061114 03:20]:
> Hi,
> 
> The attached patch adds 2430 support to arch/arm/plat-omap folder.
> 
> The following files are modified devices.c, dmtimer.c, gpio.c, mcbsp.c
> 
> Since the changes were very minimal I thought of sending them as a
> single patch.
...

> diff -purN linux-omap/arch/arm/plat-omap/dmtimer.c mydev-linux-omap/arch/arm/plat-omap/dmtimer.c
> --- linux-omap/arch/arm/plat-omap/dmtimer.c	2006-11-11 21:48:05.000000000 -0600
> +++ mydev-linux-omap/arch/arm/plat-omap/dmtimer.c	2006-11-13 18:08:34.000000000 -0600
> @@ -100,7 +100,12 @@ static struct omap_dm_timer dm_timers[] 
>  #define omap_dm_clk_disable(x) clk_disable(x)
>  
>  static struct omap_dm_timer dm_timers[] = {
> +#ifdef CONFIG_ARCH_OMAP2420
>  	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
> +#endif
> +#ifdef CONFIG_ARCH_OMAP2430
> +	{ .phys_base = 0x49018000, .irq = INT_24XX_GPTIMER1 },
> +#endif		
>  	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
>  	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
>  	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },

Please change this to use just if (cpu_is_omap2430()) in init instead of
ifdefs. Almost all the code already uses base address + offsets, so
compiling in all the similar platforms should be easy.

Actually considering how easy it's to do, I'd rather see the existing patch
boot with both 2420 and 2430 compiled in rather than adding more ifdefs
that would make the changes more complicated later.

> diff -purN linux-omap/arch/arm/plat-omap/gpio.c mydev-linux-omap/arch/arm/plat-omap/gpio.c
> --- linux-omap/arch/arm/plat-omap/gpio.c	2006-11-11 21:48:06.000000000 -0600
> +++ mydev-linux-omap/arch/arm/plat-omap/gpio.c	2006-11-13 18:56:48.000000000 -0600
> @@ -86,10 +86,19 @@
>  /*
>   * omap24xx specific GPIO registers
>   */
> +#if defined(CONFIG_ARCH_OMAP2420)
>  #define OMAP24XX_GPIO1_BASE		(void __iomem *)0x48018000
>  #define OMAP24XX_GPIO2_BASE		(void __iomem *)0x4801a000
>  #define OMAP24XX_GPIO3_BASE		(void __iomem *)0x4801c000
>  #define OMAP24XX_GPIO4_BASE		(void __iomem *)0x4801e000
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +#define OMAP24XX_GPIO1_BASE		(void __iomem *)0x4900C000
> +#define OMAP24XX_GPIO2_BASE		(void __iomem *)0x4900E000
> +#define OMAP24XX_GPIO3_BASE		(void __iomem *)0x49010000
> +#define OMAP24XX_GPIO4_BASE		(void __iomem *)0x49012000
> +#define OMAP24XX_GPIO5_BASE		(void __iomem *)0x480B6000
> +#endif
> +	
>  #define OMAP24XX_GPIO_REVISION		0x0000
>  #define OMAP24XX_GPIO_SYSCONFIG		0x0010
>  #define OMAP24XX_GPIO_SYSSTATUS		0x0014
> @@ -169,12 +178,23 @@ static struct gpio_bank gpio_bank_730[7]
>  #endif
>  
>  #ifdef CONFIG_ARCH_OMAP24XX
> -static struct gpio_bank gpio_bank_24xx[4] = {
> -	{ OMAP24XX_GPIO1_BASE, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,	METHOD_GPIO_24XX },
> -	{ OMAP24XX_GPIO2_BASE, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,	METHOD_GPIO_24XX },
> -	{ OMAP24XX_GPIO3_BASE, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,	METHOD_GPIO_24XX },
> -	{ OMAP24XX_GPIO4_BASE, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,	METHOD_GPIO_24XX },
> +
> +#if defined(CONFIG_ARCH_OMAP2420)
> +#define OMAP2_GPIO_MAX_BANK		4
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +#define OMAP2_GPIO_MAX_BANK		5
> +#endif
> +
> +static struct gpio_bank gpio_bank_24xx[OMAP2_GPIO_MAX_BANK] = {
> +	{ OMAP24XX_GPIO1_BASE, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,       METHOD_GPIO_24XX },
> +	{ OMAP24XX_GPIO2_BASE, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,  METHOD_GPIO_24XX },
> +	{ OMAP24XX_GPIO3_BASE, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,  METHOD_GPIO_24XX },
> +	{ OMAP24XX_GPIO4_BASE, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,  METHOD_GPIO_24XX },
> +#ifdef CONFIG_ARCH_OMAP2430
> +	{ OMAP24XX_GPIO5_BASE, INT_24XX_GPIO_BANK5, IH_GPIO_BASE + 128, METHOD_GPIO_24XX },
> +#endif
>  };
> +
>  #endif
>  
>  static struct gpio_bank *gpio_bank;

Same here, please just define gpio banks for 2430 instead of ifdefs.

Regards,

Tony
