From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH v2 0/8] gpio: omap: cleanup: get rid of system GPIO <->
 GPIO offset converseations
Date: Fri, 27 Mar 2015 12:27:29 +0200
Message-ID: <55153091.6040400@linaro.org>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35777 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbbC0K1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2015 06:27:41 -0400
Received: by wibbg6 with SMTP id bg6so21079191wib.0
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2015 03:27:40 -0700 (PDT)
In-Reply-To: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org, Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/23/2015 02:18 PM, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Now in TI OMAP GPIO driver there are a lot of places where
> System GPIO number calculated and then converted to GPIO offset.
> What is worse is that in many place such conversation performed twice
> or even three times. But actually, we don't need to do that at all, because
> - gpiolib always passes GPIO offset to GPIO controller
> - OMAP GPIO driver converted to use IRQ domain, so
>    struct irq_data->hwirq contains GPIO offset
>
> Hence, it is safe to convert all GPIO OMAP functions to use GPIO
> offset instead of system GPIO numbers. Also, this allows to remove
> unneeded conversations routines
>   #define GPIO_INDEX(bank, gpio)
>   #define GPIO_BIT(bank, gpio)
>   int omap_irq_to_gpio()
>
> Tested on:
> - dra7-evm.
> - omap1 (osk5912), 770 and E3.
>
> Last two patches have to be tested on OMAP1:
> -  gpio: omap: get rid of omap_irq_to_gpio()
> -  gpio: omap: get rid of GPIO_INDEX() macro
>
> Based on top of Linux 4.0-rc4 plus patch
> '[PATCH 1/2] gpio: omap: irq_shutdown: remove unnecessary call of gpiochip_unlock_as_irq'
> http://www.spinics.net/lists/linux-omap/msg116482.html
>
> Changes in v2:
> - fixed build failure with Patch 5, no functional code
>    changes.
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>

Thanks Linus.

regards,
-grygorii



-- 
regards,
-grygorii
