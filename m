From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Make dummy wrapper if the OMAP_GPIO_SWITCH
	is not set
Date: Fri, 30 Nov 2007 16:06:16 -0800
Message-ID: <20071201000616.GM7498@atomide.com>
References: <20071129080137.GA1395@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071129080137.GA1395@party>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [071129 00:02]:
> OMAP_GPIO_SIWTCH is optional, so omap_reister_gpio_switches will be null.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/include/asm-arm/arch-omap/gpio-switch.h b/include/asm-arm/arch-omap/gpio-switch.h
> index 10da0e0..a143253 100644
> --- a/include/asm-arm/arch-omap/gpio-switch.h
> +++ b/include/asm-arm/arch-omap/gpio-switch.h
> @@ -48,7 +48,11 @@ struct omap_gpio_switch {
>  };
>  
>  /* Call at init time only */
> +#ifdef CONFIG_OMAP_GPIO_SWITCH
>  extern void omap_register_gpio_switches(const struct omap_gpio_switch *tbl,
>  					int count);
> +#else
> +#define omap_register_gpio_switches(tbl, count)	do { } while (0)
> +#endif
>  
>  #endif

Pushing today.

Tony
