From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: Add inituart macro to initialize DEBUG_LL
 serial port based on the machine ID
Date: Fri, 4 Feb 2011 08:44:37 -0800
Message-ID: <20110204164436.GT3322@atomide.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
 <20110204012207.26298.16649.stgit@baageli.muru.com>
 <20110204083934.GB15004@n2100.arm.linux.org.uk>
 <20110204123220.GG15004@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28399 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab1BDQpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:45:08 -0500
Content-Disposition: inline
In-Reply-To: <20110204123220.GG15004@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110204 04:31]:
> On Fri, Feb 04, 2011 at 08:39:34AM +0000, Russell King - ARM Linux wrote:
> > Can't we just hard-configure the virtual/physical address at build
> > time and be done with it?
> > 
> > I've given up with the current state of affairs which tries to use the
> > platform ID to select the UART to use as it never seems to work, and I
> > have a couple of patches which hard-code the address at compile time -
> > one for the SDP4430 board and one for the LDP3430 board.
> > 
> > If it's complicated, then it probably won't work.  Keep it simple.
> > That's especially true for debugging code, otherwise you need extra
> > debugging code to debug why the debugging code doesn't work.
> 
> There's another good reason to hard-configure the UART port rather
> than select it by ID.
> 
> The common usage scenario: you're bringing up a new board.  You know
> you're going to have your console connected to UART2.  So, no matter
> what you want your debug messages to come out of UART2 even if the
> machine ID is wrong.

Yes that's an important debugging case too. Another common use
case is "this kernel boots on machines a and b, but fails to boot
on c and d".
 
> By detecting the UART port from the machine number, you immediately
> lose that ability, and therefore the confidence, that "if I build the
> kernel for X with LL debug enabled, and monitor port Y, I will get
> messages out of port Y, and not some other random port Z which I'd to
> solder wires to to monitor."

True, but that easily also leads to confusion on why some kernel only
boots on one machine. So maybe we can do something that can easily be
selected in Kconfig for forcing certain port?
 
> In other words, no messages on the monitored port changes from "we didn't
> get into the kernel, or something early in the kernel boot before the C
> code went wrong" to "... or maybe the debugging code failed to get the
> right port too."
> 
> It is invaluable to know that the debugging code will always talk to
> the same UART which you're monitoring.

I'll take a look how we can allow forcing the uart easily.

Regards,

Tony
