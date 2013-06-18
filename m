From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ARM: OMAP1: nokia770: enable Tahvo
Date: Tue, 18 Jun 2013 03:16:29 -0700
Message-ID: <20130618101628.GK5523@atomide.com>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
 <1371389712-29516-6-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371389712-29516-6-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> [130616 06:41]:
> Add platform data for Tahvo.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>

Thanks, applying into omap-for-v3.11/board. I left out
the .extcon entry to remove the dependency to the USB patches.

Then the rest of the series can be queued along with other
USB patches, and you can do a follow-up patch to patch in
.extcon.

Regards,

Tony 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
