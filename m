From: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch-v2.6.39 12/12] usb: otg: notifier: switch to atomic
 notifier
Date: Fri, 25 Feb 2011 12:50:13 +0200
Message-ID: <20110225105013.GB30637@esdhcp034230>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-13-git-send-email-balbi@ti.com>
 <20110225104653.GA30637@esdhcp034230>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110225104653.GA30637@esdhcp034230>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 25, 2011 at 12:46:53PM +0200, ext Heikki Krogerus wrote:
> Hi Felipe,
> 
> On Thu, Feb 17, 2011 at 02:38:49PM +0200, ext Felipe Balbi wrote:
> > most of our notifications, will be called from IRQ
> > context, so an atomic notifier suits the job better.
> > 
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/usb/otg/ab8500-usb.c    |    6 +++---
> >  drivers/usb/otg/nop-usb-xceiv.c |    2 +-
> >  drivers/usb/otg/twl4030-usb.c   |    6 +++---
> >  drivers/usb/otg/twl6030-usb.c   |    8 ++++----
> >  include/linux/usb/otg.h         |    6 +++---
> >  5 files changed, 14 insertions(+), 14 deletions(-)
> 
> You should fix drivers/usb/otg/ab8500-usb.c as well.

Sorry, ignore that :).

> drivers/power/twl4030_charger.c will need to be made atomic notifier
> safe.

Still valid I belive.

-- 
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
