From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 2/4] davinci: da8xx/omap-l1: Remove hard coding of rtc device wakeup
Date: Mon, 01 Jul 2013 17:07:43 -0700
Message-ID: <87a9m5omcw.fsf@linaro.org>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
	<1372412109-986-3-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52674 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab3GBAHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 20:07:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3073300pdj.17
        for <linux-omap@vger.kernel.org>; Mon, 01 Jul 2013 17:07:47 -0700 (PDT)
In-Reply-To: <1372412109-986-3-git-send-email-gururaja.hebbar@ti.com> (Hebbar
	Gururaja's message of "Fri, 28 Jun 2013 15:05:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, vaibhav.bedia@ti.com, sudhakar.raj@ti.com, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@arm.linux.org.uk>

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> Since now rtc-omap driver itself calls deice_init_wakeup(dev, true),
> duplicate call from the rtc device registration can be removed.
>
> This is basically a partial revert of the prev commit
>
> commit 75c99bb0006ee065b4e2995078d779418b0fab54
> Author: Sekhar Nori <nsekhar@ti.com>
>
>     davinci: da8xx/omap-l1: mark RTC as a wakeup source
>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
>
> ---
> :100644 100644 bf57252... 85a900c... M	arch/arm/mach-davinci/devices-da8xx.c
>  arch/arm/mach-davinci/devices-da8xx.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index bf57252..85a900c 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -827,14 +827,7 @@ static struct platform_device da8xx_rtc_device = {
>  
>  int da8xx_register_rtc(void)
>  {
> -	int ret;
> -
> -	ret = platform_device_register(&da8xx_rtc_device);
> -	if (!ret)
> -		/* Atleast on DA850, RTC is a wakeup source */
> -		device_init_wakeup(&da8xx_rtc_device.dev, true);
> -
> -	return ret;
> +	return  platform_device_register(&da8xx_rtc_device);

nit: extra space between 'return' and 'platform_'

>  }
>  
>  static void __iomem *da8xx_ddr2_ctlr_base;

Otherwise,

Acked-by: Kevin Hilman <khilman@linaro.org>

