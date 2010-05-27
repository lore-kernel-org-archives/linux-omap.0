From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 15:22:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271520070.3239-100000@iolanthe.rowland.org>
References: <1274982447.27810.5684.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34157 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756693Ab0E0TWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 15:22:34 -0400
In-Reply-To: <1274982447.27810.5684.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 27 May 2010, Peter Zijlstra wrote:

> On Thu, 2010-05-27 at 18:40 +0100, Matthew Garrett wrote:
> > On Thu, May 27, 2010 at 07:34:40PM +0200, Peter Zijlstra wrote:
> > > > we still need to be able to enter suspend while the system isn't idle.
> > > 
> > > _WHY_!?
> > 
> > Because if I'm running a kernel build in a tmpfs and I hit the sleep 
> > key, I need to go to sleep. Blocking processes on driver access isn't 
> > sufficient.
> 
> But that's a whole different issue. I agree that a forced suspend for
> things like that make sense, just not for power managing a running
> system.

Why not?  Or rather, why shouldn't it?

> PC style hardware like that doesn't wake up from suspend for
> funny things like a keypress either (good thing too).

Yes it does.  If I close the lid of my laptop, wait a few seconds for 
it to suspend, then open the lid (which does not wake it up), and hit a 
key -- it wakes up.

> Anyway all that already works (more or less), so I don't see the
> problem.

The "less" part is the problem.  It would be nice to have a forced 
suspend mode that is more dicriminating: Instead of activating 
immediately it would wait until all pending events were handled.

Alan Stern

