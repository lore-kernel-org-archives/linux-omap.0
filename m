From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/4] OMAP3 I2C document why cpu type and not peripheral
 unit ID used to probe
Date: Thu, 3 Mar 2011 22:12:33 +0100
Message-ID: <4D700441.50206@ti.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135030.30648.14923.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38377 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805Ab1CCVMl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 16:12:41 -0500
In-Reply-To: <20110303135030.30648.14923.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Andy Green <andy.green@linaro.org>

On 3/3/2011 2:50 PM, Andy Green wrote:
> Describe why we can't simply probe the peripheral unit ID
> to make the decision about what register map to use
>
> Cc: patches@linaro.org
> Signed-off-by: Andy Green<andy.green@linaro.org>
> ---
>
>   drivers/i2c/busses/i2c-omap.c |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b605ff3..d6500ec 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1032,6 +1032,17 @@ omap_i2c_probe(struct platform_device *pdev)
>   	else
>   		dev->reg_shift = 2;
>
> +	dev->regs = (u8 *)reg_map;
> +
> +	/*
> +	 * this is a bit tricky, implementation on 4430 has the active
> +	 * part of its ID register moved to +4 instead of +0 as
> +	 * previously.  So, we can't probe just using the ID register
> +	 * Complicating matters the older implementation using the
> +	 * simpler register set on 3530 also reports its revision as
> +	 * 0x40, same as the 4430 newer implementation.
> +	 */

The issue is that this revision field is not really documented in OMAP4 
TRM, so you should not rely on it. Moreover, as you already noticed, the 
revision number is not even accurate. OMAP3 and 4 are using a different 
programming model but this is not reflected in this field.

Since that issue is quite common in many OMAP IPs, we introduced a SW 
field in hwmod_class that should reflect the change in IP programming 
model. For the moment it is a simple integer that we increment each time 
there is change in a programming model that will impact the driver.

You can check how it was done for the timer for example:
https://patchwork.kernel.org/patch/587211/
Then you need to copy that info to a pdata field in order to allow the 
driver to access it. Check omap_timer_init in:
https://patchwork.kernel.org/patch/587241/

> +
>   	if (cpu_is_omap44xx())
>   		dev->regs = (u8 *) omap4_reg_map;

OK, this is not part of your patch, but any call to cpu_is are forbidden 
from the driver. As soon as you have the revision field from hwmod you 
can get rid of all that code.

Regards,
Benoit
