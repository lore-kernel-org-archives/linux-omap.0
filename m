From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 2/2] omap: rx51: initialize platform data for twl4030
 powerbutton
Date: Mon, 14 Mar 2011 12:57:08 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103141253370.23033@esdhcp041196.research.nokia.com>
References: <078f4a01fa523a0f9e0033c52f52413d60cc5431.1299860654.git.ext-denis.2.karpov@nokia.com> <0aaadf1ebe1864fa310a8b1330dd688079983f8d.1299860654.git.ext-denis.2.karpov@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:26237 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab1CNK71 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 06:59:27 -0400
In-Reply-To: <0aaadf1ebe1864fa310a8b1330dd688079983f8d.1299860654.git.ext-denis.2.karpov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi,

On Fri, 11 Mar 2011, Denis Karpov wrote:
> From: Denis Karpov <ext-denis.2.karpov@nokia.com>
>
> Adds and initializes platform data for TWL4030 powerbutton.
> Disable repeat input events from a button press (default behaviour).

[...]

> +static struct twl4030_pwrbutton_data rx51_pwrbutton_data = {
> +	.rep		= 1,
> +};
> +

Doesn't this enable them? If you want to keep the default behaviour,
you can just omit the platform data.

> static struct twl4030_madc_platform_data rx51_madc_data = {
> 	.irq_line		= 1,
> };
> @@ -758,6 +762,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
> 	/* platform_data for children goes here */
> 	.gpio			= &rx51_gpio_data,
> 	.keypad			= &rx51_kp_data,
> +	.pwrbutton		= &rx51_pwrbutton_data,

A.
