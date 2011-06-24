From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Fri, 24 Jun 2011 13:53:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org> <201106232234.21930.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59205 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1FXTx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 15:53:56 -0400
In-Reply-To: <201106232234.21930.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, arve@android.com

(Arve cc'ed, also adding Magnus and Kevin back to cc)

Hi Rafael,

On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:

> On Thursday, June 23, 2011, Alan Stern wrote:
> > On Thu, 23 Jun 2011, Paul Walmsley wrote:
> > > On Wed, 15 Jun 2011, Rafael J. Wysocki wrote:
> > >
> > > > Well, the freezing of user space by itself doesn't buy you anything
> > > > power management-wise, you pretty much need to do the other things too to
> > > > really save energy this way. 
> > > 
> > > Freezing user space stops CPU-hogging processes from running.  When the 
> > > runqueue is empty, the scheduler can go idle.  This in turn allows the 
> > > CPU(s) to enter low power sleep states via CPUIdle.
> 
> But you don't have to freeze user space for this purpose, do you?
> You may simply send a SIGSTOP to those processes.

Probably that would be useful for some use-cases.  there are two 
issues with SIGSTOP/SIGCONT that I'm aware of, compared to freezing:

1. if sent from a userspace process, SIGSTOP/SIGCONT are potentially racy 
with respect to system calls like setsid(), such that the sender may miss 
some processes;

2. SIGSTOP/SIGCONT are observable, so could cause side-effects: see for 
example 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/cgroups/freezer-subsystem.txt;h=c21d77742a0799424b09466857681ddcc7100f8b;hb=HEAD#l19

> > > As I understand it, this is really the basis for the modern Android 
> > > use-case for wakelocks and opportunistic suspend.  They prevent 
> > > non-power-privileged userspace applications from keeping the system from 
> > > entering a low-power state.  (Secondarily, suspend also prevents kernel 
> > > code from running, e.g., timers set by filesystems, the networking stack, 
> > > etc.; but problems here should be fixed in the offending kernel code, 
> > > rather than hacked around, since some of the users of those timers could 
> > > be important)
> > 
> > I think you have oversimplified things a little, but never mind...
> 
> Well, saying "a little" is an overstatement. :-)

What parts do you feel were oversimplified?

> This was given as one of the arguments why using the wakelocks mechanism
> along with the opportunistic suspend might be regarded as a good idea, but
> I think the _real_ reason why it is used by Android is that the system
> suspend framework was usable already when Android was being developed and if
> they wanted to get acceptable battery lives at that time, they simply had no
> choice but to use it.

This is why "modern" was written in the original text: to contrast with 
the historical rationale for suspend blockers.

As I understand it, in the original Android implementation, the hardware 
that they were using didn't have fine-grained power management.  So 
system-wide suspend made more sense in that context.  But that shouldn't 
be confused with the modern rationale for wakelocks:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.html

"On the hardware that shipped we enter the same power state from idle
and suspend, so the only power savings we get from suspend that we
don't get in idle is from not respecting the scheduler and timers."


- Paul
