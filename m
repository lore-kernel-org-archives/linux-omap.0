From: Tony Lindgren <tony@atomide.com>
Subject: Re: What happened to the serial console on BeagleBoard with
	2.6.28-rc2?
Date: Sun, 2 Nov 2008 14:07:41 -0800
Message-ID: <20081102220741.GP28924@atomide.com>
References: <E1KwhIl-0001an-Ro@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60487 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbYKBWHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2008 17:07:44 -0500
Content-Disposition: inline
In-Reply-To: <E1KwhIl-0001an-Ro@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: david-b@pacbell.net, linux-omap@vger.kernel.org, nmonson@gmail.com, felipe.contreras@gmail.com, tom.leiming@gmail.com

* Rick Bronson <rick@efn.org> [081102 10:07]:
> 
> > Leaving only one map_desc[] entry left using MT_DEVICE not MT_MEMORY_SO...
> > I didn't try this, since I'm currently not hooking up that serial port,
> > but dmesg does show(*):
> > 
> >  Serial: 8250/16550 driver3 ports, IRQ sharing disabled
> >  serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
> >  serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
> >  serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16650V2
> >  console [ttyS2] enabled
> > 
> > Is that what you saw too?
> 
>   Yep, that's what I saw, but only if I had DEBUG_LL=y.  Without that
> I had nothing except "Uncompressing Linux........".  ST16650V2 is a
> clue that something went awry in auto-detection of the type of 8250
> serial port.  With the MT_MEMORY_SO change, I get:
> 
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled                           
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654                  
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654                  
> serial8250.0: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654                  
> console [ttyS2] enabled                                                         
> 
>   I guess we don't see this problem on the other 2 ports since they
> are mapped MT_MEMORY_SO and not MT_DEVICE (L4_34XX_PHYS).

Rick, can you please reply with your Signed-off-by for your patch?

Let's push that one, then continue thinking about the so/device
issues.

Tony
