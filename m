From: David Brownell <david-b@pacbell.net>
Subject: Re: USB-webcam support
Date: Tue, 12 Aug 2008 15:38:44 -0700
Message-ID: <20080812223844.48AB1362B0F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
 <E78C46F1-DB17-4BE0-A310-D1F5072B26B8@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:40716 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752113AbYHLWdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 18:33:03 -0400
In-Reply-To: <E78C46F1-DB17-4BE0-A310-D1F5072B26B8@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunedarath@mistralsolutions.com, k.kooi@student.utwente.nl, gadiyar@ti.com
Cc: linux-omap@vger.kernel.org

> >> If I have a USB camera with good Linux support, can I connect it
> >> to omap3evm(or any omap2) and make it functional?

I'm told some folk have used ISO transfer support, but when I last did
much work with the musb code, none of it was tested.


> > I don't see why not. Do you expect a problem with using it? You could
> > use MUSB in host or OTG mode and connect the camera to the MUSB port.
>
> Not quite, MUSB doesn't support the 'high bandwidth' flag, which most  
> usb webcams seem to use (even the puny 12mbit ones). Tested on the  
> MUSB port of my beagle and bf548.

Since "high bandwidth" is a mode restricted to 480 mbps hardware, I
think generic ISO transfer problems are more likely the issue than
anything related to isochronous video streams topping 8 MByte/second...
no 12mbit camera can possibly care about high bandwidth.

The integrated MUSB controllers (2430, OMAP3[45]xx) have hardware
support for "high bandwidth".  Technically, "high bandwidth" is when
you have a 480 Mbit/sec connection and it's issuing more than one
isochronous or interrupt packet per microframe (8 microframes/msec).
Those packet top out at 1 KByte each, ergo 8 MByte/second is the
most you can get without high bandwidth support.  Endpoints can issue
at most three such packets per microframe ... so, max 24 MByte/sec is
the most you can get *with* high bandwidth support.  (The USB 2.0
spec is self contradictory about whether you can have two streams
at that rate going concurrently.  One is clearly OK; two would exceed
the bandwidth reserved for periodic transfers, by around 3%.)


So ... first, someone should get ISO to work well.  Start with full
speed webcams, which can do one 1023 byte packet per millisecond.
I think you'll need to make sure double buffering works right, and
tweak the default FIFO allocations a bit.

Then go to high speed webcams, and make sure that same code can work
eight times faster (one 1024 byte packet every microframe, you get an
extra byte).  Then it's time to work on the high bandwidth stuff.

- Dave

