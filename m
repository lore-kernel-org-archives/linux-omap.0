From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip specific GPIO
Date: Wed, 12 May 2010 07:49:25 -0700
Message-ID: <87ljbpqioa.fsf@deeprootsystems.com>
References: <20100505223147.GG29604@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C54EF826@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:41296 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997Ab0ELOt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 10:49:29 -0400
Received: by pxi5 with SMTP id 5so45183pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 07:49:29 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C54EF826@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Wed\, 12 May 2010 17\:59\:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Tony/Kevin,
>
>> > > +{
>> > > +	if (cpu_is_omap242x())
>> > > +		gpio_bank_count = 4;
>> > > +	else if (cpu_is_omap243x())
>> > > +		gpio_bank_count = 5;
>> > > +	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
>> > > +		gpio_bank_count = OMAP34XX_NR_GPIOS;
>> > > +
>> > > +	if (gpio_init())
>> > > +		return -EINVAL;
>> > > +
>> > > +	early_platform_driver_register_all("earlygpio");
>> > > +	early_platform_driver_probe("earlygpio", gpio_bank_count, 0);
>> > > +	return 0;
>> > > +}
>> >
>> > Then please replace this init with something like:
>> 
>> Okay.
>> 
>> >
>> > #ifdef CONFIG_ARCH_OMAP2
>> > int __init omap242x_gpio_init(void)
>> > {
>> > 	if (!cpu_is_omap2420())
>> > 		return -EINVAL;
>> >
>> > 	gpio_bank_count = 4;
>> >
>> > 	return gpio_init(METHOD_GPIO_24XX);
>> > }
>> > subsys_initcall(omap242x_gpio_init);
>> >
>> > int __init omap243x_gpio_init(void)
>> > {
>> > 	if (!cpu_is_omap2430())
>> > 		return -EINVAL;
>> >
>> > 	gpio_bank_count = 5;
>> >
>> > 	return gpio_init(METHOD_GPIO_24XX);
>> > }
>> > subsys_initcall(omap243x_gpio_init);
>> > #endif
>> >
>> > #ifdef CONFIG_ARCH_OMAP3
>> > int __init omap34xx_gpio_init(void)
>> > {
>> > 	if (!cpu_is_omap34xx())
>> > 		return -EINVAL;
>> >
>> > 	gpio_bank_count = OMAP34X_NR_GPIOS;
>> >
>> > 	return gpio_init(METHOD_GPIO_34XX);
>> > }
>> > subsys_initcall(omap34xx_gpio_init);
>> > #endif
>> > ...
>> >
>> > This way it will be more future proof when new omaps get added
>> > and the if else stuff disappears. Also then you'll have an omap
>> > specific function to initialize the gpio stuff.
>> >
>> > Note that then early_platform_driver_register_all and
>> > early_platform_driver_probe can be moved to gpio_init.
>> >
>> > With multi-omap build the subsys_initcall runs for all of the
>> > selected platforms, but returns early except for the machine
>> > we're running on. All the code is optimized out for omap
>> > specific product kernels.
>> 
>> Okay. Will do the needful and send new patch series in 2 weeks.
>
> subsys_initcall is not sufficient for SoC specific gpio_init as it needs
> to be done before machine_init functions access gpio APIs. Hence I am 
> making SoC specific gpio_init as postcore_initcall.

OK.  Please add a comment at the postcore_initcall() location with the
details as to why it is needed and what it needs to go before etc.

Kevin
