From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: GPIO: Enable debounce clock only when debounce
 is enabled v2.
Date: Tue, 16 Sep 2008 06:19:51 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809160618250.21341@utopia.booyaka.com>
References: <873ak0mk5t.fsf@deeprootsystems.com> <1221567379-2177-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40723 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbYIPMTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:19:52 -0400
In-Reply-To: <1221567379-2177-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Jouni,

sorry to make you rework this again, but:

On Tue, 16 Sep 2008, Jouni Hogander wrote:

> This patch changes gpio "driver" to enable debounce clock for
> gpio-bank only when debounce is enabled for some gpio in that bank.

>  
> +#if defined(CONFIG_ARCH_OMAP3)
> +	if (cpu_is_omap34xx())
> +		enable ? clk_enable(bank->dbck) : clk_disable(bank->dbck);
> +#endif

the #ifdefs here are unnecessary, since the preprocessor will reduce 
cpu_is_omap34xx() to a constant for single-OMAP builds..

> @@ -1513,6 +1515,15 @@ static int __init _omap_gpio_init(void)
>  		}
>  		set_irq_chained_handler(bank->irq, gpio_irq_handler);
>  		set_irq_data(bank->irq, bank);
> +
> +#if defined(CONFIG_ARCH_OMAP3)
> +		if (cpu_is_omap34xx()) {
> +			sprintf(clk_name, "gpio%d_dbck", i + 1);
> +			bank->dbck = clk_get(NULL, clk_name);
> +			if (IS_ERR(bank->dbck))
> +				printk(KERN_ERR "Could not get %s\n", clk_name);
> +		}
> +#endif

as above.


- Paul
