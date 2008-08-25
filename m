From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH resend v2] TWL4030-RTC: Fix the broken functionality
Date: Mon, 25 Aug 2008 16:30:56 +0400
Message-ID: <48B2A600.2060406@gmail.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB027DC93D5A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:5610 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbYHYMbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 08:31:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so962271fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 05:31:08 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB027DC93D5A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pakaravoor, Jagadeesh wrote:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>
> rtc_irq_set_freq() function takes only powers of 2 as a valid
> argument. This stipulates that an ioctl call on /dev/rtc0
> can accept values of 1,2,4 and 8 only. But the function 
> twl4030_rtc_irq_set_freq() takes only values 0-3. RTC_INTERRUPTS_REG
> of TWL4030 also requires value in the range 0-3 for the interrupt
> period. Hence it is required to map the argument from the powers of 2,
> to the corresponding numbers 0-3, via a call to ilog2.
>
Note, the rtc_irq_set_freq() function accepts a frequency measured in
Hz. That is, those values (1,2,4 and 8) should be interpreted as 1Hz,
2Hz, 4Hz and 8Hz while you consider them as 1 == 1 sec period, 2 == 1
minute period, 4 == 1 hour period and 8 == 1 day period, that is wrong.

Yes, TWL4030 RTC has the capability to set only those four periods which
does not fit well to periodic IRQ concept of RTC framework. But it does
not mean you can violate a common concept of periodic IRQs.

The patch might be acceptable as a temporary workaround, but obviously
it won't be accepted in mainline, as well as commit
7ef9abe1e9cf53c2dd7556f12d35b06053847f72 which has introduced periodic
IRQ functionality to rtc-twl4030 driver.


Thanks,
Dmitry

> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> ---
> Fixing a bug in the last patch: argument to set_rtc_irq_bit()
> function should have been "value" instead of "freq".
> Index: my-local-git-dir/drivers/rtc/rtc-twl4030.c
> ===================================================================
> --- my-local-git-dir.orig/drivers/rtc/rtc-twl4030.c	2008-08-22 17:37:33.000000000 +0530
> +++ my-local-git-dir/drivers/rtc/rtc-twl4030.c	2008-08-22 19:25:41.616786397 +0530
> @@ -38,6 +38,7 @@
>  #include <linux/i2c/twl4030-rtc.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/log2.h>
>  
>  #include <asm/mach/time.h>
>  #include <asm/system.h>
> @@ -363,14 +364,26 @@ out:
>  static int twl4030_rtc_irq_set_freq(struct device *dev, int freq)
>  {
>  	struct rtc_device *rtc = dev_get_drvdata(dev);
> +	u8 value;
>  
> -	if (freq < 0 || freq > 3)
> +	/* RTC_INTERRUPTS_REG takes the value of 0 for interrupts every
> +	 * second, 1 for every minute, 2 every hour and 3 every day.
> +	 * But freq is in 2^N format, which needs to be converted back.
> +	 */
> +	value = ilog2(freq);
> +	if (value < 0 || value > 3)
>  		return -EINVAL;
>  
> -	rtc->irq_freq = freq;
> +	rtc->irq_freq = value;
> +
> +	/* Clear the current periodicity of irq*/
> +	mask_rtc_irq_bit(0x3);
>  
> -	/* set rtc irq freq to user defined value */
> -	set_rtc_irq_bit(freq);
> +	/* If the new value is non-zero, set the new periodicity */
> +	if (value) {
> +		/* set rtc irq freq to user defined value */
> +		set_rtc_irq_bit(value);
> +	}
>  
>  	return 0;
>  }
>
> --
> With Regards,
> Jagadeesh Bhaskar P
>  
> ----------------------------
> Some men see things as they are and say why - I dream things that never were and say why not.
> - George Bernard Shaw
> -------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

