From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
Date: Fri, 31 Aug 2012 16:52:12 -0700
Message-ID: <20120831235212.GS1303@atomide.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005230.28732.1131.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51448 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab2HaXwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 19:52:18 -0400
Content-Disposition: inline
In-Reply-To: <20120831005230.28732.1131.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

* Tony Lindgren <tony@atomide.com> [120830 17:53]:
> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
> the hardcoded gpio_base with twl_gpiochip.base after it's been
> allocated.
...

> --- a/include/linux/mfd/twl6040.h
> +++ b/include/linux/mfd/twl6040.h
> @@ -194,7 +194,6 @@ struct twl6040_vibra_data {
>  
>  struct twl6040_platform_data {
>  	int audpwron_gpio;	/* audio power-on gpio */
> -	unsigned int irq_base;
>  
>  	struct twl6040_codec_data *codec;
>  	struct twl6040_vibra_data *vibra;

The platform_data irq_base is not being used it seems..

> @@ -222,7 +221,6 @@ struct twl6040 {
>  	unsigned int mclk;
>  
>  	unsigned int irq;
> -	unsigned int irq_base;
>  	u8 irq_masks_cur;
>  	u8 irq_masks_cache;
>  };

..but irq_base here is still in use as that's where the value from
irq_alloc_descs() is being stored to. So I'll drop the changes to
struct twl6040 from this patch as otherwise twl6040 code won't compile.

Turns out I did not have twl6040 selected in any of the testconfigs
that I ran.

Regards,

Tony
