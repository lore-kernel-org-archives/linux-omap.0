From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 0/3] RTC platform data structure defined
Date: Sat, 22 Aug 2009 19:27:31 +0300
Message-ID: <87fxbjvmoc.fsf@deeprootsystems.com>
References: <1250091912-5334-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52914 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969AbZHVQ1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 12:27:34 -0400
Received: by ewy3 with SMTP id 3so1359905ewy.18
        for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2009 09:27:35 -0700 (PDT)
In-Reply-To: <1250091912-5334-1-git-send-email-charu@ti.com> (charu@ti.com's message of "Wed\, 12 Aug 2009 21\:15\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com

charu@ti.com writes:

> This series contains patches which
>         1. define TWL4030 rtc platform data which has msecure gpio line info
>         2. initialise msecure gpio line from rtc driver
>         3. twl core file passes rtc platform data from board file to rtc driver
>         4. Board files handle mux configuration of msecure gpio line
>
> This series applies on top of linux-2.6.31-rc5.
>
> CharuLatha (4):
>
>         [PATCH 0/3] RTC platform data structure defined

Normally, PATCH 0/n is a summary of the other patches, and does not
include a patch itself.

I recommend using 'git format-patch' which will take care of the
formatting and the numbering for you.

>         [PATCH 1/3] RTC periodic interrupts enabling and msecure init
>         [PATCH 2/3] handling rtc platform data
>         [PATCH 3/3] board files do msecure line mux configuration
>
> Structure "twl4030_rtc_platform_data" is defined with msecure_gpio in it. 
> This structure would be initialised in board file. 
> RTC msecure line initialization happens in RTC driver.
> The same structure can be used for any future enhancements in RTC.
>
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  include/linux/i2c/twl4030.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index 15edfaa..6ae582b 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -341,6 +341,13 @@ struct twl4030_gpio_platform_data {
>  				unsigned gpio, unsigned ngpio);
>  };
>  
> +struct twl4030_rtc_platform_data {
> +	int 		msecure_gpio;
> +	/* More structures/elements can be added
> +	 * for future Triton RTC driver enhancements
> +	 */

very true, but does not need to be documented.

> +};
> +
>  struct twl4030_madc_platform_data {
>  	int		irq_line;
>  };
> @@ -395,6 +402,7 @@ struct twl4030_platform_data {
>  	unsigned				irq_base, irq_end;
>  	struct twl4030_bci_platform_data	*bci;
>  	struct twl4030_gpio_platform_data	*gpio;
> +	struct twl4030_rtc_platform_data	*rtc;
>  	struct twl4030_madc_platform_data	*madc;
>  	struct twl4030_keypad_data		*keypad;
>  	struct twl4030_usb_data			*usb;
> -- 
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kevin
