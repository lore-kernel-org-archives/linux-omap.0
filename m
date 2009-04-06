From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] musb: refresh nop transceiver support for musb
Date: Mon, 6 Apr 2009 17:16:21 +0300
Message-ID: <20090406141621.GK22170@scadufax.research.nokia.com>
References: <1239024889-28597-1-git-send-email-ajay.gupta@ti.com> <20090406134406.GG22170@scadufax.research.nokia.com> <19F8576C6E063C45BE387C64729E73940427EE8F27@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50657 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbZDFOTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 10:19:07 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940427EE8F27@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "tony@atomide.com" <tony@atomide.com>

On Mon, Apr 06, 2009 at 04:08:01PM +0200, Ajay Kumar Gupta wrote:
> > >  void __init usb_musb_init(void)
> > >  {
> > >  	if (cpu_is_omap243x()) {
> > > @@ -172,10 +159,7 @@ void __init usb_musb_init(void)
> > >  	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
> > >
> > >  #ifdef CONFIG_NOP_USB_XCEIV
> > > -	if (platform_device_register(&nop_xceiv_device) < 0) {
> > > -		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
> > > -		return;
> > > -	}
> > > +	usb_nop_xceiv_register();
> > 
> > how about you move the ifdef also to the definition of
> > usb_nop_xceiv_register(). It's probably in a header file somewhere so
> > you:
> 
> It is at: include/linux/usb/otg.h,
> ==============
> #ifdef CONFIG_NOP_USB_XCEIV
> extern void usb_nop_xceiv_register(void);
> extern void usb_nop_xceiv_unregister(void);
> #endif
> ================
> But one of the David's queued patch [1] removes the #ifdef part.
> [1] http://marc.info/?l=linux-usb&m=123852883820097&w=2
> 
> Is it ok to add it back in this patch?
> 
> David, what's your comment on this?

if the user doesn't select the nop transceiver, I guess that symbol
should become a static inline doing nothing.

What do you think Dave ?

-- 
balbi
