From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/13 v5] OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
Date: Mon, 09 Aug 2010 17:21:40 -0700
Message-ID: <87zkwv8gh7.fsf@deeprootsystems.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49368 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab0HJAVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 20:21:42 -0400
Received: by pzk26 with SMTP id 26so3868516pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 17:21:42 -0700 (PDT)
In-Reply-To: <1281098065-24177-10-git-send-email-charu@ti.com> (Charulatha
	V.'s message of "Fri, 6 Aug 2010 18:04:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, "Basak, Partha" <p-basak2@ti.com>

Charulatha V <charu@ti.com> writes:

> This patch adds support for handling GPIO as a HWMOD FW adapted
> platform device for OMAP2PLUS chips.
>
> gpio_init needs to be done before machine_init functions access
> gpio APIs.Hence gpio_init is made as a postcore_initcall.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
> ---
>  arch/arm/mach-omap2/gpio.c |  120 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 120 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/gpio.c
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> new file mode 100644
> index 0000000..30aeef9
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -0,0 +1,120 @@
> +/*
> + * gpio.c - OMAP2PLUS-specific gpio code
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * Author:
> + *	Charulatha V <charu@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +
> +/*
> + * For GPIO, it is a must to relinquish clocks in the Idle-path
> + * as it is possible to have a GPIO bank requested and still
> + * allow PER domain to go to OFF. 

What clocks are you referring to?   

There is no main_clk associated with this hwmod, so hwmod is not
managing any clocks for you and the driver is handling the debounce
clock (opt_clk.)

> In the idle path (interrupt
> + * disabled context), omap_device APIs cannot be used as they
> + * are not mutex-free functions. Hence the below wrappers are
> + * required to handle interrupts disabled context and interrupts
> + * enabled context.
> + */
> +static int gpio_enable_hwmod(struct omap_device *od)
> +{
> +	struct omap_hwmod *oh = *od->hwmods;
> +
> +	if (irqs_disabled())
> +		_omap_hwmod_enable(oh);
> +	else
> +		omap_device_enable_hwmods(od);
> +	return 0;
> +}
> +
> +static int gpio_idle_hwmod(struct omap_device *od)
> +{
> +	struct omap_hwmod *oh = *od->hwmods;
> +
> +	if (irqs_disabled())
> +		_omap_hwmod_idle(oh);
> +	else
> +		omap_device_idle_hwmods(od);
> +	return 0;
> +}

The use of hwmod to disable GPIO hwmods in the idle path needs some more
explanation since it differs from what is done in the current GPIO code.

As mentioned above, the (optional) clocks are being managed by the
driver already, so what exactly are you wanting hwmod to do for you?
The only thing that will happen is the toggling of no-idle/smart-idle,
and it's not clear to me that is what you want.

Whatever the new behavior you're trying to get, it should be described
well in the changelog since it's different from current behavior of the
GPIO code.  In fact, a change like this which is signifcantly different
from current behavior should be done in a separate patch.

> +
> +static struct omap_device_pm_latency omap_gpio_latency[] = {
> +	[0] = {
> +		.deactivate_func = gpio_idle_hwmod,
> +		.activate_func   = gpio_enable_hwmod,
> +		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	},
> +};

So, to keep the same behavior as the current code, you could just drop
the omap_gpio_latency part here, and you don't have to worry about
calling into omap_hwmod_* with interrupts disabled.

Kevin

