From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Check gpio_fck not gpio_ick.
Date: Fri, 11 Aug 2006 13:14:10 +0300
Message-ID: <20060811101409.GI6720@atomide.com>
References: <1150197615.26712.263694540@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1150197615.26712.263694540@webmail.messagingengine.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060613 14:22]:

> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -983,7 +983,7 @@ static int __init _omap_gpio_init(void)
>  		else
>  			clk_enable(gpio_ick);
>  		gpio_fck = clk_get(NULL, "gpios_fck");
> -		if (IS_ERR(gpio_ick))
> +		if (IS_ERR(gpio_fck))
>  			printk("Could not get gpios_fck\n");
>  		else
>  			clk_enable(gpio_fck);

Pushing today.

Tony
