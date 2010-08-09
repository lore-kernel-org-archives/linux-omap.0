From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform device
Date: Mon, 09 Aug 2010 16:06:02 -0700
Message-ID: <878w4ffkth.fsf@deeprootsystems.com>
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
	<1281098065-24177-11-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0HIXGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 19:06:06 -0400
Received: by pzk26 with SMTP id 26so3848147pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 16:06:05 -0700 (PDT)
In-Reply-To: <1281098065-24177-11-git-send-email-charu@ti.com> (Charulatha
	V.'s message of "Fri, 6 Aug 2010 18:04:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, "Basak, Partha" <p-basak2@ti.com>

Charulatha V <charu@ti.com> writes:

> @@ -650,21 +511,28 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
>  	__raw_writel(debounce, reg);
>  
>  	reg = bank->base;
> -	if (cpu_is_omap44xx())
> +	if (bank->method == METHOD_GPIO_44XX)
>  		reg += OMAP4_GPIO_DEBOUNCENABLE;
>  	else
>  		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
>  
>  	val = __raw_readl(reg);
>  
> +	if (!bank->dbck) {
> +		struct platform_device *pdev = to_platform_device(bank->dev);
> +		struct omap_device *odev = to_omap_device(pdev);

insert empty line

> +		if (odev->hwmods[0]->opt_clks->_clk)
> +			bank->dbck = odev->hwmods[0]->opt_clks->_clk;

As was discussed in Bangalore, drivers should have no knowledge of hwmod
internals.

Instead, please propose an API to hwmod for getting the optional
clock(s), or possibly cleaner, an API to directly enable/disable
optional clocks for an omap_device.

Kevin

> +		if (IS_ERR(bank->dbck))
> +			dev_err(bank->dev, "Could not get gpio dbck\n");
> +	}
> +
