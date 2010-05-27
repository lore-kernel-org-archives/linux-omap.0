From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 13:00:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010, Thomas Gleixner wrote:

> The whole notion of treating suspend to RAM any different than a plain
> idle C-State is wrong. It's not different at all. You just use a
> different mechanism which has longer takedown and wakeup latencies and
> requires to shut down stuff and setup extra wakeup sources.

This is where you are wrong.  Maybe not wrong in principle, but wrong 
in practice -- the kernel's present suspend-to-RAM (or just "suspend") 
implementation is _very_ different from C-states (or just "idle").

The primary difference is that the kernel can be forced into suspend
even when the system isn't idle.  In particular, it may be in the
middle of processing a potential wakeup event -- and the current design
gives the PM core no way to know if that is so.  This is a weakness
that in-kernel suspend blockers fix.

With C-states this can't happen.  If the CPU goes into a deeper C-state 
then ipso facto it isn't busy processing anything, much less a wakeup 
event.

Now maybe this difference is a bad thing, and the whole PM 
suspend/hibernate infrastructure should be rewritten.  But the fact, 
remains, that's how it works now.  And it can't be changed easily or 
quickly.

Alan Stern
