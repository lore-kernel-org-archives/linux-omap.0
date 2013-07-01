From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] N900: fix operation on emulator
Date: Mon, 01 Jul 2013 22:22:21 +0400
Message-ID: <51D1C8DD.6040409@cogentembedded.com>
References: <20130613132624.GA3464@amd.pavel.ucw.cz> <20130613141001.GF8164@atomide.com> <20130613142809.GA3775@amd.pavel.ucw.cz> <20130613145724.GH8164@atomide.com> <20130613155240.GB3775@amd.pavel.ucw.cz> <20130613161418.GJ8164@atomide.com> <20130613230808.GA14876@amd.pavel.ucw.cz> <20130614055629.GM8164@atomide.com> <20130614212816.GA31768@atrey.karlin.mff.cuni.cz> <20130617111031.GQ20992@atomide.com> <20130701140315.GA15318@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:36046 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab3GASW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 14:22:26 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so4633733lab.41
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 11:22:25 -0700 (PDT)
In-Reply-To: <20130701140315.GA15318@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>

Hello.

On 07/01/2013 06:03 PM, Pavel Machek wrote:

> Errata workarounds for N900 hardware actually break operation on
> emulator. Fix it.

> This approach was suggested by Pali Roh=E1r <pali.rohar@gmail.com>
> (thanks!).

> (Also explain what "sleep_ind" led actually does).

    Looks like unrelated change and probably worth another patch?

> Signed-off-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/b=
oard-rx51.c
> index 74f83a5..81f7b9f 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -33,9 +33,12 @@
>   #include "pm.h"
>   #include "sdram-nokia.h"
>   #include "board-rx51-secure.h"
> +#include "soc.h"
>
>   #define RX51_GPIO_SLEEP_IND 162
>
> +/* This lights up left part of keyboard */
> +
>   static struct gpio_led gpio_leds[] =3D {
>   	{
>   		.name	=3D "sleep_ind",
> @@ -107,9 +110,11 @@ static void __init rx51_init(void)
>   	rx51_camera_init();
>
>   #ifdef CONFIG_ARM_ERRATA_430973
> -	printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n")=
;
> -	/* set IBE to 1 */
> -	rx51_secure_update_aux_cr(1 << 6, 0);
> +	if (omap_type() =3D=3D OMAP2_DEVICE_TYPE_SEC) {
> +		printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n"=
);

    How about pr_info() instead?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
