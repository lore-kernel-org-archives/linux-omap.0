From: Tony Lindgren <tony@atomide.com>
Subject: Re: usb: musb: Fix LapDock enumeration on omap for boot and slow
 cable insertion
Date: Thu, 16 May 2013 10:15:20 -0700
Message-ID: <20130516171520.GZ5600@atomide.com>
References: <20130503175016.GV28721@atomide.com>
 <20130503180132.GW28721@atomide.com>
 <20130515140537.GC26183@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22614 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab3EPRPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 13:15:23 -0400
Content-Disposition: inline
In-Reply-To: <20130515140537.GC26183@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>

* Felipe Balbi <balbi@ti.com> [130515 07:11]:
> On Fri, May 03, 2013 at 11:01:33AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [130503 10:55]:
> > > Looks like we can get VBUS interrupt before the ID interrupt
> 
> how can this happen ? VBUS interrupt happens when you connect to a port
> which is sourcing VBUS to you, while ID interrupt happens when ID is
> grounded, meaning that you should be sourcing VBUS.

Yes, in this case we get both interrupts and the order depends
on how fast/slow the cable is inserted.
 
> Have you hacked a Hub to backfeed 5V to OMAP by any chance ?

..as that's how the LapDock seems to behave backfeeding 5V.

It would be interesting to take a look at the signaling on it,
but I think my old beagle sniffer is fried.

Looking at the "Figure 6-1: Common State Diagram" on page 32 in
"USB_OTG_and_EH_3-0_release_1_1_10May2012.pdf" the logic is the
following depending on the order of interrupt:

start -> id ground -> a_idle -> a_wait_vrise -> a_wait_bcon...

or

start -> vbus -> b_idle -> id ground -> a_idle -> a_wait_vrise ->
a_wait_bcon...

I don't think having the VBUS there actually violates that if
we just should follow the ID state and accept that a_wait_vrise
is already satisfied and not even try to turn the VBUS at MUSB
end in that case.

Regards,

Tony
