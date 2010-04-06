From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
Date: Tue, 06 Apr 2010 15:51:27 -0700
Message-ID: <87mxxgi49c.fsf@deeprootsystems.com>
References: <1269268704-31347-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62432 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab0DFWvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 18:51:37 -0400
Received: by gxk9 with SMTP id 9so231595gxk.8
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 15:51:36 -0700 (PDT)
In-Reply-To: <1269268704-31347-1-git-send-email-charu@ti.com> (Charulatha V.'s message of "Mon\, 22 Mar 2010 20\:08\:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org

Charulatha V <charu@ti.com> writes:

> Access to some of the OMAP4 GPIO registers are not properly handled.
> This patch fixes it.
>

Tested on... ?

> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   61 +++++++++++++++++++++++++++++++++++---------
>  1 files changed, 55 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 76a347b..3a9891c 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -137,7 +137,11 @@
>  #define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
>  #define OMAP4_GPIO_IRQWAKEN0		0x0044
>  #define OMAP4_GPIO_IRQWAKEN1		0x0048
> -#define OMAP4_GPIO_SYSSTATUS		0x0104
> +#define OMAP4_GPIO_SYSSTATUS		0x0114
> +#define OMAP4_GPIO_IRQENABLE1		0x011c
> +#define OMAP4_GPIO_WAKE_EN		0x0120
> +#define OMAP4_GPIO_IRQSTATUS2		0x0128
> +#define OMAP4_GPIO_IRQENABLE2		0x012c
>  #define OMAP4_GPIO_CTRL			0x0130
>  #define OMAP4_GPIO_OE			0x0134
>  #define OMAP4_GPIO_DATAIN		0x0138
> @@ -148,6 +152,10 @@
>  #define OMAP4_GPIO_FALLINGDETECT	0x014c
>  #define OMAP4_GPIO_DEBOUNCENABLE	0x0150
>  #define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
> +#define OMAP4_GPIO_CLEARIRQENABLE1	0x0160
> +#define OMAP4_GPIO_SETIRQENABLE1	0x0164
> +#define OMAP4_GPIO_CLEARWKUENA		0x0180
> +#define OMAP4_GPIO_SETWKUENA		0x0184
>  #define OMAP4_GPIO_CLEARDATAOUT		0x0190

[...]

> @@ -1570,9 +1603,14 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
>  		reg += OMAP7XX_GPIO_DIR_CONTROL;
>  		break;
>  	case METHOD_GPIO_24XX:
> -	case METHOD_GPIO_44XX:
>  		reg += OMAP24XX_GPIO_OE;
>  		break;
> +	case METHOD_GPIO_44XX:
> +		reg += OMAP4_GPIO_OE;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;

If you add a WARN, please add a helpful string.

Otherwise, this looks OK to me.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

