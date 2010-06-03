From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/11] OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
Date: Thu, 03 Jun 2010 11:36:14 -0700
Message-ID: <87aarcrmjl.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
	<1274194260-16401-2-git-send-email-charu@ti.com>
	<1274194260-16401-3-git-send-email-charu@ti.com>
	<1274194260-16401-4-git-send-email-charu@ti.com>
	<1274194260-16401-5-git-send-email-charu@ti.com>
	<1274194260-16401-6-git-send-email-charu@ti.com>
	<1274194260-16401-7-git-send-email-charu@ti.com>
	<1274194260-16401-8-git-send-email-charu@ti.com>
	<1274194260-16401-9-git-send-email-charu@ti.com>
	<1274194260-16401-10-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34572 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab0FCSgU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 14:36:20 -0400
Received: by pvg16 with SMTP id 16so199771pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 11:36:19 -0700 (PDT)
In-Reply-To: <1274194260-16401-10-git-send-email-charu@ti.com> (Charulatha V.'s message of "Tue\, 18 May 2010 20\:20\:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> This patch adds support for handling GPIO as a HWMOD FW adapted
> platform device for OMAP2PLUS chips.
>
> Signed-off-by: Charulatha V <charu@ti.com>

[...]

> +/*
> + * gpio_init needs to be done before
> + * machine_init functions access gpio APIs.
> + * Hence gpio_init is a postcore_initcall.
> + */
> +#ifdef CONFIG_ARCH_OMAP2
> +static int __init omap242x_gpio_init(void)
> +{	if (!cpu_is_omap2420())
> +		return -EINVAL;
> +
> +	return gpio_init(METHOD_GPIO_24XX);
> +}
> +postcore_initcall(omap242x_gpio_init);
> +
> +static int __init omap243x_gpio_init(void)
> +{
> +	if (!cpu_is_omap2430())
> +		return -EINVAL;
> +
> +	return gpio_init(METHOD_GPIO_24XX);
> +}
> +postcore_initcall(omap243x_gpio_init);
> +#endif

Minor nit: you don't need separate functions for 2420 and 2430?
A single one for OMAP2 with 'if (!cpu_is_omap24xx())' should do.

Kevin
