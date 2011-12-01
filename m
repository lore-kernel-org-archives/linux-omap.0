From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 01/11] arm:omap:am33xx: Add voltage domain data
Date: Wed, 30 Nov 2011 16:11:20 -0800
Message-ID: <87ipm1w3pz.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46345 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752760Ab1LAALe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 19:11:34 -0500
Received: by mail-ey0-f180.google.com with SMTP id c11so1850151eaa.11
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 16:11:26 -0800 (PST)
In-Reply-To: <1321809555-13833-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 20 Nov 2011 22:49:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> From: Afzal Mohammed <afzal@ti.com>
>
> Currently dummy voltage domain data is being created
> in order to succeed boot process.
> Nothing has been done w.r.t actual hardware (voltage control).
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

[...]

> --- /dev/null
> +++ b/arch/arm/mach-omap2/voltagedomains33xx_data.c
> @@ -0,0 +1,37 @@
> +/*
> + * AM33XX voltage domain data
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include "voltage.h"
> +
> +static struct voltagedomain am33xx_voltdm_mpu = {
> +	.name = "mpu",
> +};

According to the TRM, there is no MPU voltage domain.  Only CORE and RTC
exist.  

However, looking at the data manual (SPRS717 Oct 2011), it seems that
some packages have a separate VDD_MPU while others have a combined
VDD_MPU and VDD_CORE.

This should be clarified and documented in the changelog.

> +static struct voltagedomain am33xx_voltdm_core = {
> +	.name = "core",
> +};
> +
> +static struct voltagedomain am33xx_voltdm_rtc = {
> +	.name = "rtc",
> +};

Won't these basically empty voltage domains fail during voltage init?
At a minimum, it seems they should have '.scaling = false' as well until
voltage scalling is supported.

> +static struct voltagedomain *voltagedomains_am33xx[] __initdata = {
> +	&am33xx_voltdm_mpu,
> +	&am33xx_voltdm_core,
> +	&am33xx_voltdm_rtc,
> +	NULL,
> +};
> +
> +void __init am33xx_voltagedomains_init(void)
> +{
> +	voltdm_init(voltagedomains_am33xx);
> +}

Kevin
