From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix building with CONFIG_OMAP_GPIO_SWITCH
	off.
Date: Thu, 24 May 2007 17:34:30 -0700
Message-ID: <20070525003430.GE19506@atomide.com>
References: <fb249edb0705221025s4447c7e1s2119e5a62ebb2198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0705221025s4447c7e1s2119e5a62ebb2198@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [070522 10:26]:
> Define omap_register_gpio_switches when CONFIG_OMAP_GPIO_SWITCH is
> off. This will prevent adding a CONFIG_OMAP_GPIO_SWITCH check in the
> board files and enable building board-palmte.c with gpio-switch off.
> Also add __initdata to the two variables in gpio-switch that are used only
> during init.
>
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

> @@ -48,7 +49,12 @@ struct omap_gpio_switch {
>  };
>  
>  /* Call at init time only */
> -extern void omap_register_gpio_switches(const struct omap_gpio_switch *tbl,
> -					int count);
> +#ifdef CONFIG_OMAP_GPIO_SWITCH
> +extern void omap_register_gpio_switches(
> +		const struct omap_gpio_switch *tbl, int count);
> +#else
> +static inline void omap_register_gpio_switches(
> +		const struct omap_gpio_switch *tbl, int count) {}
> +#endif
>  
>  #endif
> -- 
> 1.4.4.3
> 

Can you please put the extern functions into a header file?
We got some comments on that on LKML few weeks ago.

Tony
