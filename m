From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/8] OMAP2PLUS:GPIO:Add OMAP2PLUS specific gpio support
Date: Tue, 06 Apr 2010 15:08:45 -0700
Message-ID: <87ochwkzde.fsf@deeprootsystems.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
	<1270038239-1090-2-git-send-email-charu@ti.com>
	<1270038239-1090-3-git-send-email-charu@ti.com>
	<1270038239-1090-4-git-send-email-charu@ti.com>
	<1270038239-1090-5-git-send-email-charu@ti.com>
	<1270038239-1090-6-git-send-email-charu@ti.com>
	<20100401093020.GF31200@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42425 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062Ab0DFWIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 18:08:51 -0400
Received: by pva18 with SMTP id 18so308976pva.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 15:08:50 -0700 (PDT)
In-Reply-To: <20100401093020.GF31200@atomide.com> (Tony Lindgren's message of "Thu\, 1 Apr 2010 02\:30\:21 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Charulatha V <charu@ti.com>, linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com

Tony Lindgren <tony@atomide.com> writes:

> * Charulatha V <charu@ti.com> [100331 05:15]:
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -0,0 +1,36 @@
>> +/*
>> + * gpio.c - OMAP2PLUS architecture specific common gpio code
>> + *
>> + * Copyright (C) 2010 Texas Instruments, Inc.
>> + *
>> + * Author:
>> + *	Charulatha V <charu@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <mach/gpio.h>
>
> Should be include <linux/gpio.h>
>
>> +void __init omap_gpio_early_init(void)
>> +{
>> +	struct platform_device **pdev;
>> +	int no_of_dev;
>> +
>> +	if (cpu_is_omap24xx()) {
>> +		omap2_gpio_init_data();
>> +		no_of_dev = omap2_early_init_gpio(&pdev);
>> +	} else if (cpu_is_omap34xx()) {
>> +		omap3_gpio_init_data();
>> +		no_of_dev = omap3_early_init_gpio(&pdev);
>> +	} else if (cpu_is_omap44xx()) {
>> +		omap4_gpio_init_data();
>> +		no_of_dev = omap4_early_init_gpio(&pdev);
>> +	} else
>> +		return;
>> +
>> +	early_platform_add_devices(pdev, no_of_dev);
>> +	early_platform_driver_register_all("earlygpio");
>> +	early_platform_driver_probe("earlygpio", no_of_dev, 0);
>> +}
>> diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
>> index d2d9d17..3a0fcb1 100644
>> --- a/arch/arm/mach-omap2/include/mach/gpio.h
>> +++ b/arch/arm/mach-omap2/include/mach/gpio.h
>> @@ -115,4 +115,5 @@ extern void omap4_gpio_init_data(void);
>>  extern int omap2_early_init_gpio(struct platform_device ***pdev);
>>  extern int omap3_early_init_gpio(struct platform_device ***pdev);
>>  extern int omap4_early_init_gpio(struct platform_device ***pdev);
>> +extern void __init omap_gpio_early_init(void);
>>  #endif
>
> Uhh, is this some April fool's day joke? :)
>
> To me it looks like you have no need for ***pdev, just swap the init
> code around so the omap specific code calls omap_gpio_init with the
> platform data.

Or better yet, just use hwmod + omap_device for early platform_devices
and drop this patch entirely.

Kevin

