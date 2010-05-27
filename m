From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:33:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005272332320.3478@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271724430.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271724430.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Alan Stern wrote:

> On Thu, 27 May 2010, Matthew Garrett wrote:
> 
> > On Thu, May 27, 2010 at 10:23:50PM +0200, Thomas Gleixner wrote:
> > > On Thu, 27 May 2010, Matthew Garrett wrote:
> > > > A wakeup event is defined as one that wakes the system - if a system 
> > > > can't be woken by a specific event then it's impossible to lose it, 
> > > > since it wasn't a wakeup event to begin with.
> > > 
> > > So where is the problem ?
> > 
> > The problem is that, right now, if a wakeup event is received between 
> > the point where userspace decides to start a suspend and userspace 
> > actually starts a suspend, that event may not abort the suspend.
> 
> The two of you are talking at cross purposes.  Thomas is referring to 
> idle-based suspend and Matthew is talking about forced suspend.

Yes, and forced suspend to disk is the same as force suspend to disk,
which has both nothing to do with sensible resource management.

Thanks,

	tglx
