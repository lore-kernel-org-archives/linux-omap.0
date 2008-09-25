From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/4] i2c: clean add_children a bit
Date: Thu, 25 Sep 2008 10:28:00 -0700
Message-ID: <200809251028.00242.david-b@pacbell.net>
References: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com> <1222354133-12919-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:45703 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753392AbYIYR2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 13:28:03 -0400
In-Reply-To: <1222354133-12919-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thursday 25 September 2008, Felipe Balbi wrote:
> Clean up add_children a bit before adding more children
> to twl4030-core.c
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

ACK, except for:

> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -145,4 +145,10 @@ int twl4030_free_gpio(int gpio);
>  	static inline int twl4030charger_usb_en(int enable) { return 0; }
>  #endif
>  
> +#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
> +#define twl_has_rtc()	(1)
> +#else
> +#define twl_has_rtc()	(0)
> +#endif

Who else would need this, other than the core?
I think the answer is "nobody" ... so these macros
belong in the core itself, not a public header.

Also:  parens not appropriate around those values; and
"true" and "false" values would be a bit more clear...

> +
>  #endif /* End of __TWL4030_H */
> -- 
> 1.6.0.2.307.gc427
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


