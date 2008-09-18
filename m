From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Thu, 18 Sep 2008 12:22:53 -0700
Message-ID: <200809181222.54393.david-b@pacbell.net>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com> <20080823232238.GL4713@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:34469 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752983AbYIRTW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 15:22:56 -0400
In-Reply-To: <20080823232238.GL4713@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>

On Saturday 23 August 2008, Tony Lindgren wrote:
> 
> > I'll get the ehci-omap code in better shape and submit separately to the
> > linux-usb list.

Given that we've not yet seen patches splitting out the board-specific
bits into arch/arm/mach-omap2, I can't imagine those fixes being ready
for the 2.6.28 merge window.  (Hint for TI folk:  why not write the
code that way in the first place, avoiding all the delays inherent in
writing code you *know* is unsuitable for merging to mainline?)

They'd have to get in through the "new driver" exception ... but that
doesn't seem workable either, since the mach-omap2 updates aren't ready
yet *either*, and there's not much time left for them to get into the
OMAP tree, tested, reviewed for the ARM merge window, and then pulled
into Russell's patch queue ...

In short:  unless that's ready in the next few days, that stuff may
not be able to hit mainline until 2.6.29 merges start (I'm guessing
that will mean January 2009).


> Well we should really sync all usb code with mainline now that musb is
> merged.

There are still a bunch of essential musb build fixes waiting to get
into mainline (from moving include/asm-arm in RC1).

I cc'd Greg; I'm hoping he plans to get those upstream soon, so
the 2.6.28-rc0 merge window can focus on the remaining functional
updates to make platforms work ... instead of build fixes, and then
needing another merge window for functional fixes.  It seems DaVinci
will be ready (platform updates are in Russell's queue).  OMAP3 looks
to be more involved.

- Dave

