From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
Date: Fri, 28 Sep 2012 08:13:13 -0700
Message-ID: <20120928151051.GC4840@atomide.com>
References: <20120927202615.GS4840@atomide.com>
 <1348815748-30072-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348815748-30072-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>, jon-hunter-l0cyMroinI0@public.gmane.org, Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [120928 00:08]:
> In order to make single zImage work for ARM architecture,
> we need to make sure we don't depend on private headers.
> 
> Move USB platform_data to <linux/platform_data/omap-usb.h>

The new standard seems to be subsystem-soc.h, so usb-omap.h :)

> and keep only internal functions in <plat/usb.h>.

Can the remaining parts be in #include "usb.h" in mach-omap2?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
