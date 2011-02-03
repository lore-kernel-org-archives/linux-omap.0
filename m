From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 v5] OMAP2430: hwmod data: Add USBOTG
Date: Thu, 3 Feb 2011 11:25:07 +0200
Message-ID: <20110203092507.GD23561@legolas.emea.dhcp.ti.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com>
 <1291991739-21705-2-git-send-email-hemahk@ti.com>
 <3b6a23e346e75947e09f70dae78f2d88@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3b6a23e346e75947e09f70dae78f2d88-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Feb 03, 2011 at 11:24:48AM +0530, Hema Kalliguddi wrote:
> Any comments?

For me these are ok, Tony/Kevin, do you want me to prepare a pull
request when we're closer to .39 merge window for one of you guys to
pull from and get this part in mainline ? pm_runtime parts (which only
touch drivers/usb/musb/omap2430.c) I can get in mainline through Greg,
but not this.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
