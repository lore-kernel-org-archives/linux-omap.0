From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 25 Jun 2011 15:51:40 +0200
Message-ID: <201106251551.40872.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org> <201106232234.21930.rjw@sisk.pl> <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57853 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab1FYNvP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Jun 2011 09:51:15 -0400
In-Reply-To: <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, arve@android.com

Hi,

On Friday, June 24, 2011, Paul Walmsley wrote:
> (Arve cc'ed, also adding Magnus and Kevin back to cc)

Thanks, my mailer is playing tricks on me. :-)

> Hi Rafael,
> 
> On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:
> 
> > On Thursday, June 23, 2011, Alan Stern wrote:
> > > On Thu, 23 Jun 2011, Paul Walmsley wrote:
> > > > On Wed, 15 Jun 2011, Rafael J. Wysocki wrote:
> > > >
> > > > > Well, the freezing of user space by itself doesn't buy you anything
> > > > > power management-wise, you pretty much need to do the other things too to
> > > > > really save energy this way. 
> > > > 
> > > > Freezing user space stops CPU-hogging processes from running.  When the 
> > > > runqueue is empty, the scheduler can go idle.  This in turn allows the 
> > > > CPU(s) to enter low power sleep states via CPUIdle.
> > 
> > But you don't have to freeze user space for this purpose, do you?
> > You may simply send a SIGSTOP to those processes.
> 
> Probably that would be useful for some use-cases.  there are two 
> issues with SIGSTOP/SIGCONT that I'm aware of, compared to freezing:
> 
> 1. if sent from a userspace process, SIGSTOP/SIGCONT are potentially racy 
> with respect to system calls like setsid(), such that the sender may miss 
> some processes;

I must admit I don't know the details here, but that sounds quite plausible.

> 2. SIGSTOP/SIGCONT are observable, so could cause side-effects: see for 
> example 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/cgroups/freezer-subsystem.txt;h=c21d77742a0799424b09466857681ddcc7100f8b;hb=HEAD#l19

That's correct, but on the other hand some user space processes want to be
notified that they're going to be frozen (like NetworkManager, although it
probably wants that because of the suspend that's going to happen next).

My point here is that being observable need not be a bad thing, depending on
the viewpoint.

> > > > As I understand it, this is really the basis for the modern Android 
> > > > use-case for wakelocks and opportunistic suspend.  They prevent 
> > > > non-power-privileged userspace applications from keeping the system from 
> > > > entering a low-power state.  (Secondarily, suspend also prevents kernel 
> > > > code from running, e.g., timers set by filesystems, the networking stack, 
> > > > etc.; but problems here should be fixed in the offending kernel code, 
> > > > rather than hacked around, since some of the users of those timers could 
> > > > be important)
> > > 
> > > I think you have oversimplified things a little, but never mind...
> > 
> > Well, saying "a little" is an overstatement. :-)
> 
> What parts do you feel were oversimplified?

In fact, there are several things that wakelocks are being used for, including
the one you have mentioned, but also:

* Idleness detection (meaning "whole system idleness).
* Detection of races between system suspend and wakeup events.
* Collecting wakeup events statistics (useful for detection of misbehaving
  applications).

The system idleness detection mechanism probably makes the most of the
difference between Android and other Linux-based systems PM-wise.

> > This was given as one of the arguments why using the wakelocks mechanism
> > along with the opportunistic suspend might be regarded as a good idea, but
> > I think the _real_ reason why it is used by Android is that the system
> > suspend framework was usable already when Android was being developed and if
> > they wanted to get acceptable battery lives at that time, they simply had no
> > choice but to use it.
> 
> This is why "modern" was written in the original text: to contrast with 
> the historical rationale for suspend blockers.
> 
> As I understand it, in the original Android implementation, the hardware 
> that they were using didn't have fine-grained power management.  So 
> system-wide suspend made more sense in that context.  But that shouldn't 
> be confused with the modern rationale for wakelocks:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.html
> 
> "On the hardware that shipped we enter the same power state from idle
> and suspend, so the only power savings we get from suspend that we
> don't get in idle is from not respecting the scheduler and timers."

There is a point in that, because timers wake up the CPU from low-power
states entered through CPUuidle.

Anyway, I don't quite get your point overall in the ongoing discussion.
I'd like to understand it, so we know we're talking about the same things. :-)

You seem to be making a point for not supporting system suspend.  That may
mean two different things, though.

First, you may be trying to say that system suspend is a bad idea in general
and it shouldn't be supported at all.  That I strongly disagree with, because
there are platforms where it is the only effective way of saving energy
on systems that are not in use, but should become available quickly if
necessary.  Moreover, there are systems where system suspend makes it possible
to save more energy than CPUidle and runtime PM combined.

Second, your point may be that for some platforms system suspend is not worth
supporting.  I don't agree with that too, although not so strongly.  To be
precise, in my opinion that is a matter of balance between the number of
features the given platform wants to support and the time and effort needed to
implement that support.

Of course, I think that system suspend is one of the features which, if
supported, make a platform more attractive from the point of view of potential
users (where I don't really mean end users, but people wanting to build a
product on top of it), but you can say that I'm biased, because I've been
working on system suspend for a long time and you may be right. :-)
That said I think that the support for system suspend is not too difficult to
implement and the benefits are readily visible.  Your opinion may be different,
but I don't see anything wrong with that as long as it is based on technical
arguments.

To conclude, the kernel will support system suspend in its current form as
long as that depends on me to any extent.  On the other hand, I'm not going to
force anyone to support it.  After all, there are platforms that don't support
system suspend right now and live with that just fine. :-)

Thanks,
Rafael
