From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: pending patch
Date: Fri, 25 Apr 2008 21:45:43 +0300
Message-ID: <20080425184543.GB27479@kedavra.cpe.vivax.com.br>
References: <20080425075245.GX23350@gandalf.research.nokia.com> <200804250235.21910.david-b@pacbell.net> <20080425101837.GZ23350@gandalf.research.nokia.com> <20080425163644.GC23025@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57036 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbYDYSoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 14:44:22 -0400
Content-Disposition: inline
In-Reply-To: <20080425163644.GC23025@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, ext David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

On Fri, Apr 25, 2008 at 09:36:44AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080425 03:19]:
> > On Fri, Apr 25, 2008 at 02:35:21AM -0700, David Brownell wrote:
> > > On Friday 25 April 2008, Felipe Balbi wrote:
> > > > Hi Tony and Dave,
> > > > 
> > > > there's this one pending patch [1]. Do you guys have any comments on that
> > > > one?
> > > > 
> > > > Author: Felipe Balbi <felipe.balbi@nokia.com>
> > > > Date:   Thu Apr 17 17:34:20 2008 +0300
> > > > 
> > > >     USB: MUSB: Don't ignore disconnect on suspend
> > > >     
> > > >     As soon as a usb device is disconnect we should
> > > >     fall into a_wait_bcon state, ignoring disconnect
> > > >     irq will prevent this behaviour.
> > > 
> > > If it passes the OTG tests, fine.  I don't recall how the
> > > HNP handoff's disconnect signaling is handled ... presumably
> > > it's different from some "real" disconnect.
> > 
> > No opt available for now...
> > The problem is that when you ignore disconnect on suspend you only ack
> > the disconnect interrupt after attaching other device. It won't get us
> > too much trouble besides the bit will still set in int_src, but still
> > musb should ack disconnect as soon as it happens, shouldn't it? And
> > right after that start the timer for switching from a_wait_bcon to
> > a_wait_vfall and after that a_idle.
> > 
> > But as soon as I have and opt available, I'll try to run this test and
> > report you if I can see any issues with this patch applied.
> > 
> > For now, let's keep it as pending so.
> 
> Yeah. I have not applied any musb/tusb patches because of being afraid
> of the HS OTG OPT tests breaking.. Still have them all in my l-o mailbox
> though. So let's plan on applying things after somebody (Felipe?) gets
> to run HS OTG OPT on them for musb and tusb.

I think current driver won't pass opt at all. First of all we have a bug
in queued control transfers that gives us an oops. Quite easy to
reproduce: testusb -t 10 (just put a g_zero on the other side).

According to Dave we have two patches on ehci to help with that. I'm
looking for them in the archives without much luck but once I find them
it should be easy to make any other necessary changes to musb driver
(if any). Anyways, I get an oops in drivers/usb/hcd.c:unmap_urb_for_dma,
right in the test if (is_root_hub(urb->dev), tracking back to musb, we
would fall in __musb_giveback_urb()...

Also, we don't have the messaging support (but that's piece of cake).

> Of course this discussion should get moved to linux-usb-devel..

Yeah, i'm waiting to get all opt and testusb stuff ready so I can
prepare patches on top of mailine and send to linux-usb-devel. It's
about time.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
