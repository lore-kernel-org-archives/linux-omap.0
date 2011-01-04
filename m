From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Tue, 04 Jan 2011 09:52:37 -0800
Message-ID: <87aajg7dzu.fsf@ti.com>
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:38286 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886Ab1ADRwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 12:52:41 -0500
Received: by mail-yi0-f50.google.com with SMTP id 1so3775832yic.9
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 09:52:41 -0800 (PST)
In-Reply-To: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	(Mika Westerberg's message of "Wed, 29 Dec 2010 13:01:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
> updating reg and l values. However, at the end of the function we
> perform a write:
>
> 	__raw_writel(l, reg);
>
> So on OMAP2+ we end up writing 0 to the bank->base which is not
> correct (typically this points to GPIO_REVISION register).
>
> Fix this by returning immediately after call to
> set_24xx_gpio_triggering().
>
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, this should be added to omap-for-linus as it fixes a problem in
the recently merged GPIO omap_device/hwmod conversion.

Thanks,

Kevin

> ---
>  arch/arm/plat-omap/gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index c05c653..4dcb66f 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -867,7 +867,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  	case METHOD_GPIO_24XX:
>  	case METHOD_GPIO_44XX:
>  		set_24xx_gpio_triggering(bank, gpio, trigger);
> -		break;
> +		return 0;
>  #endif
>  	default:
>  		goto bad;
