From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Fri, 19 Sep 2008 01:19:33 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007ED9@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com>
 <20080823232238.GL4713@atomide.com>,<200809181222.54393.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58614 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbYIRTtw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 15:49:52 -0400
In-Reply-To: <200809181222.54393.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>

> 
> On Saturday 23 August 2008, Tony Lindgren wrote:
> >
> > > I'll get the ehci-omap code in better shape and submit separately to the
> > > linux-usb list.
> 
> Given that we've not yet seen patches splitting out the board-specific
> bits into arch/arm/mach-omap2, I can't imagine those fixes being ready
> for the 2.6.28 merge window.  (Hint for TI folk:  why not write the
> code that way in the first place, avoiding all the delays inherent in
> writing code you *know* is unsuitable for merging to mainline?)

Well, there are only a limited number of hours in a day. :)

Hint taken: that that code was initially written badly is a valid point.
But fixing it up is a non-trivial effort as is making sure it works. At the time I 
wrote that e-mail (August 25) I did intend to have it out well before Felipe's
11 September plan.

As they say, the best laid plans of mice and men... At the moment it does
not look like I'll be able to do this anytime soon.

And if it's going upstream, it needs to be in better shape than it currently is.

Even assuming that linux-usb decides to take it in it's current shape, it's 
definitely not going to help things when the OHCI driver comes in. And if
I'm going to be doing that cleanup anyway, I might as well get it right the
first time. Correct?

I'm going to be re-arranging this code, writing it the way it ought to have
been the first time. But please don't expect this tomorrow.

- Anand


> 
> They'd have to get in through the "new driver" exception ... but that
> doesn't seem workable either, since the mach-omap2 updates aren't ready
> yet *either*, and there's not much time left for them to get into the
> OMAP tree, tested, reviewed for the ARM merge window, and then pulled
> into Russell's patch queue ...
> 
> In short:  unless that's ready in the next few days, that stuff may
> not be able to hit mainline until 2.6.29 merges start (I'm guessing
> that will mean January 2009).
> 
> 
> > Well we should really sync all usb code with mainline now that musb is
> > merged.
> 
> There are still a bunch of essential musb build fixes waiting to get
> into mainline (from moving include/asm-arm in RC1).
> 
> I cc'd Greg; I'm hoping he plans to get those upstream soon, so
> the 2.6.28-rc0 merge window can focus on the remaining functional
> updates to make platforms work ... instead of build fixes, and then
> needing another merge window for functional fixes.  It seems DaVinci
> will be ready (platform updates are in Russell's queue).  OMAP3 looks
> to be more involved.
> 
> - Dave


