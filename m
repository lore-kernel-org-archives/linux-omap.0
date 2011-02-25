From: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch-v2.6.39 12/12] usb: otg: notifier: switch to atomic
 notifier
Date: Fri, 25 Feb 2011 13:07:41 +0200
Message-ID: <20110225110741.GC30637@esdhcp034230>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-13-git-send-email-balbi@ti.com>
 <20110225104653.GA30637@esdhcp034230>
 <20110225105013.GB30637@esdhcp034230>
 <20110225105317.GE4190@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110225105317.GE4190-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 25, 2011 at 12:53:17PM +0200, ext Felipe Balbi wrote:
> > > drivers/power/twl4030_charger.c will need to be made atomic notifier
> > > safe.
> 
> oops, that thing is doing i2c transfers. Would you care to send a patch
> since you have that hardware easily available ??

I can make a patch for this if you like, but I don't have the hw.

-- 
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
