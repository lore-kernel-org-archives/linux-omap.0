From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Date: Tue, 14 Oct 2014 13:01:55 -0700
Message-ID: <20141014200155.GA19184@roeck-us.net>
References: <20141014192518.GH4972@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50010 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJNUCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 16:02:01 -0400
Content-Disposition: inline
In-Reply-To: <20141014192518.GH4972@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Dziedzic <gostrc@gmail.com>

On Tue, Oct 14, 2014 at 12:25:19PM -0700, Tony Lindgren wrote:
> This allows testing the watchdog easily with distros just by
> doing pkill -9 watchdog.
> 
> Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
Good catch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -189,7 +189,7 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
>  }
>  
>  static const struct watchdog_info omap_wdt_info = {
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "OMAP Watchdog",
>  };
>  
> --- a/drivers/watchdog/retu_wdt.c
> +++ b/drivers/watchdog/retu_wdt.c
> @@ -94,7 +94,7 @@ static int retu_wdt_set_timeout(struct watchdog_device *wdog,
>  }
>  
>  static const struct watchdog_info retu_wdt_info = {
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "Retu watchdog",
>  };
>  
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -57,7 +57,7 @@ static int twl4030_wdt_set_timeout(struct watchdog_device *wdt,
>  }
>  
>  static const struct watchdog_info twl4030_wdt_info = {
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "TWL4030 Watchdog",
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
