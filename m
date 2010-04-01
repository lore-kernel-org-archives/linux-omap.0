From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 02:31:09 -0700
Message-ID: <20100401093109.GG31200@atomide.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54975 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0DAJ3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:29:18 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com

* Charulatha V <charu@ti.com> [100331 05:15]:
> +
> +int __init omap3_early_init_gpio(struct platform_device ***pdev)
> +{
> +	*pdev = omap3_gpio_early_dev;
> +	return OMAP34XX_NR_GPIOS;
> +}

...

> +int __init omap3_gpio_dev_reg(void)
> +{
> +	if (cpu_is_omap34xx()) {
> +		platform_device_register(&omap3_gpio1);
> +		platform_device_register(&omap3_gpio2);
> +		platform_device_register(&omap3_gpio3);
> +		platform_device_register(&omap3_gpio4);
> +		platform_device_register(&omap3_gpio5);
> +		platform_device_register(&omap3_gpio6);
> +	}
> +	return 0;
> +}
> +arch_initcall(omap3_gpio_dev_reg);

Just call omap_gpio_init for each platform data.

Tony
