From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help creating gpio-switch on ams-delta
Date: Thu, 14 May 2009 11:12:57 -0700
Message-ID: <20090514181257.GP5593@atomide.com>
References: <4A09552F.5090402@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50690 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZENSNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 14:13:06 -0400
Content-Disposition: inline
In-Reply-To: <4A09552F.5090402@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090512 03:54]:
> Hi,
>
> I am playing with OMAP 5910 based Amstrad E3 videophone (ams-delta)  
> machine. I am trying to expose GPIO 4, that hook switch hangs off, to  
> userspace.
>
> I can successfully access the pin by exporting it using gpiolib sysfs. I  
> can check its value, following hook switch state changes. However, I  
> would like the switch to generate events.
>
> I have tried two methods: gpio-switch and gpio-keys. gpio-switch device  
> is able to report the switch initial state correctly, gpio-keys device  
> just initializes without errors. However, for both methods, after first  
> switch change, the system stops responding, giving no error messages.
>
> The code of goip-switch initialization sequence together with my  
> platform device definition (attached) does not look any different to me  
> than those for keyboard or modem (patches available from  
> http://the.earth.li/pub/e3/2.6.19/), that both also use GPIO interrupts  
> and do work for me.
>
> Any hints?

Please don't use the gpio-switch any longer, that is not in the mainline
and will disappear.

There has been some discussion on LKML on doing it via the input layer.
No other tips right now from me :)

Tony

> Janusz
>
> PS. This is my first post to linux-omap list, I don't know if you accept  
> attachments. If not, next time I switch to a different mail user agent  
> that allows me for inline file inclusion (or learn how to do it in my  
> thunderbird).
>

> --- linux-2.6.27.22/arch/arm/mach-omap1/board-ams-delta.c.orig	2009-05-10 18:05:01.000000000 +0200
> +++ linux-2.6.27.22/arch/arm/mach-omap1/board-ams-delta.c	2009-05-10 18:19:18.000000000 +0200
> @@ -243,6 +243,17 @@ static struct uart_port ams_delta_modem_
>  	.line		= 1
>  };
>  
> +static struct omap_gpio_switch ams_delta_switches[] __initdata = {
> +	/* Low when handset is picked up */
> +	{
> +		.name	= "handset",
> +		.gpio	= AMS_DELTA_GPIO_PIN_HOOK_SWITCH,
> +		.type	= OMAP_GPIO_SWITCH_TYPE_ACTIVITY,
> +		.flags	= OMAP_GPIO_SWITCH_FLAG_INVERTED,
> +		/* .notify	= ams_delta_handset_detect, */
> +	},
> +};
> +
>  static void __init ams_delta_init(void)
>  {
>  	printk("ams_delta_init\n\r");
> @@ -259,6 +270,9 @@ static void __init ams_delta_init(void)
>  
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
>  
> +	omap_register_gpio_switches(ams_delta_switches,
> +			ARRAY_SIZE(ams_delta_switches));
> +
>  	early_serial_setup(&ams_delta_modem_port);
>  
>  #ifdef CONFIG_AMS_DELTA_FIQ

