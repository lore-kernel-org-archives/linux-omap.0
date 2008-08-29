From: David Brownell <david-b@pacbell.net>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 13:50:16 -0700
Message-ID: <200808291350.17181.david-b@pacbell.net>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <200808291305.31639.david-b@pacbell.net> <20080829202114.GA14130@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:32473 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753262AbYH2UuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 16:50:19 -0400
In-Reply-To: <20080829202114.GA14130@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Friday 29 August 2008, Felipe Balbi wrote:
> > You're talking about some other problem.  I'm talking about
> > the one where it *OOPSES* while binding to the gadget driver.
> 
> Hmm, that I've never seend. Using musb with omap3 and n810.

Right, that's why I thought I'd chase the easier host-side issue
first.  Must have "apt-get install ..." working after all!!


> > > Beagle should be sourcing up to 200mA. See if this patch helps:
> > 
> > Just 200 mA?  That could explain a lot.  Though looking
> > at the Beagle TRM, it says "100mA" (as with TUSB) ...
> > some version of this patch seems necessary.  (I have some
> > others to usb-musb.c, will send them all.)
> 
> Yeah, the TRM says 100mA but I could use 200mA storage devices with
> heavy transfers without any problems.

Were those self-powered devices, or bus-powered?  Descriptors
are not entirely trustworthy about current usage.  Sometimes
they represent worst-case; sometimes it's best-case.


> Do you have the BLACKLIST_HUB set? (just to be sure).

No, that's not set.


> > > I think I recall seeing this with my sniffer, but as it seemed not be
> > > generating much problems, I let it be since I had other stuff to check.
> > > Looks like I was wrong... :-s
> > 
> > The ep3in/status stuff is no problem.  The problem is the VBUS_ERR irq.
> 
> That irq is buggy, we had to put a retry since musb was rasing that
> interrupt durring enumeration for a few usb devices (bad capacitors?).

IMO it's the silicon that's buggy.  The specific window I kept seeing
was between VBUS_ON and the 100msec later where it's expected to be
stable.  During that window, VBUS is allowed to not be stable ... which
is good, because that's when current spikes happen while charging the
various capacitances involved.  (Cable, caps at either end, etc.)

I saw TUSB6010 reporting VBUS_ERR during that 100msec window ... and
same thing with DaVinci.  Both needed retry logic to cope with the
inappropriate VBUS fault reports.  The thing in common is the silicon
IP, not the hardware.

- Dave
