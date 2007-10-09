From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: GPIO IRQSTATUS2 workaround applies to 2430
Date: Tue, 9 Oct 2007 15:20:27 -0700
Message-ID: <20071009222027.GF4151@atomide.com>
References: <20071004004816.190243397@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071004004816.190243397@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071003 17:49]:
> The workaround to clear both sides of GPIO IRQ applies to 2430 as well
> as 2420.  Use cpu_is_omap24xx() instead of cpu_is_omap2420()
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> ---
>  arch/arm/plat-omap/gpio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: dev/arch/arm/plat-omap/gpio.c
> ===================================================================
> --- dev.orig/arch/arm/plat-omap/gpio.c
> +++ dev/arch/arm/plat-omap/gpio.c
> @@ -709,7 +709,7 @@ static void _clear_gpio_irqbank(struct g
>  
>  	/* Workaround for clearing DSP GPIO interrupts to allow retention */
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> -	if (cpu_is_omap2420() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		__raw_writel(gpio_mask, bank->base + OMAP24XX_GPIO_IRQSTATUS2);
>  #endif
>  }

Pushing today.

Tony
