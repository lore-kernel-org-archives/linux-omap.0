From: Rick Bronson <rick@efn.org>
Subject: Re: UART RX wakeup from sleep not working
Date: Fri, 03 Dec 2010 11:33:57 -0800
Message-ID: <E1PObOH-0005EB-5j@amazonia.comcast.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:43415 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab0LCTd5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 14:33:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hi Paul,

  Thanks again for all of the help.

> It's described in the 34xx TRM sections 4.11.2 "Device Off-Mode
> Configuration" and 4.11.3 "CORE Power Domain Off-Mode Sequences".  All the
> references to off-mode just confuse things, since AFAIK, this wakeup
> mechanism also applies to the device in full-chip retention (see also the
> 'NOTE:' portion of section 4.8.4 "Device Wake-Up Events").

  Yes, I had read that in sprugn4c.pdf, hopefully it's the same as the
34xx pdf.  My head is still spinning from trying to understand if I'll
get an interrupt or not ;-)

>  > Does it generate an interrupt?
> 
> An IO chain/ring wakeup event ultimately should generate a PRCM interrupt,
> which should wind up in mach-omap2/pm34xx.c:prcm_interrupt_handler().
> You might want to put some debugging in prcm_clear_mod_irqs(), first to
> see if that function is getting called, and second, to output the state of
> the WKST and GRPSEL registers.
> 
> This may be a stupid question, but are you using serial flow control?  If
> not, enabling wakeup on the RTS line isn't going to help.

  Not a stupid question at all.  We are very pin constrained so we
only have RX and TX, so no modem lines at all.  I was hoping to get
the wakeup mechanism to be fired off of in incoming "polling"
character on the RX line.  The first character gets lost but wakes us
up, then we respond to the next polling character to let the other
side know we're awake, then he sends the packet.

> Just out of curiosity, which kernel are you using?

  It's the Arago (we need the low power management stuff),
Linux omap 2.6.32 #32 Fri Dec 3 10:49:55 PST 2010 armv7l GNU/Linux

> By the way, if you're using a really recent kernel, you may want to see if
> sending a few breaks down the line wakes it up:

  Not very recent, see above.

  I'm still not getting an interrupt but I decided to shift my focus
and I found that this change

http://www.efn.org/~rick/pub/serial.patch

  seems to really improve the variablity in serial timeout when it's
taken low.  I found that when you take DEFAULT_TIMEOUT lower things
start acting very erratic.  We'd like to go back to sleep really
quickly after a packet is received, like 10ms would be nice, 1ms would
be better.

  Thanks again for the help.

  Rick
