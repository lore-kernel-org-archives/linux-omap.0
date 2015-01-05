From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Date: Mon, 5 Jan 2015 10:59:02 -0800
Message-ID: <20150105185902.GH4081@atomide.com>
References: <20141014192518.GH4972@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141014192518.GH4972-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Dziedzic <gostrc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [141014 12:27]:
> This allows testing the watchdog easily with distros just by
> doing pkill -9 watchdog.
> 
> Reported-by: Thomas Dziedzic <gostrc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Wim, still not seeing this applied, did you forget about this one?

Regards,

Tony
 
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
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
