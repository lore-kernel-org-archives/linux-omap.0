From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Sat, 9 Oct 2010 13:09:18 +0200
Message-ID: <201010091309.18552.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010081200200.27105-100000@netrider.rowland.org> <201010082153.35192.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58854 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab0JILKb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Oct 2010 07:10:31 -0400
In-Reply-To: <201010082153.35192.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Friday, October 08, 2010, Rafael J. Wysocki wrote:
> On Friday, October 08, 2010, Alan Stern wrote:
> > On Thu, 7 Oct 2010, Rafael J. Wysocki wrote:
> > 
> > > > 	If the PM core simply avoids releasing dev->power.lock before
> > > > 	invoking the runtime_suspend or runtime_resume callback, the
> > > > 	end result is almost the same as with busy-waiting.
> > > 
> > > This is slightly more complicated, because suspend is a bit different from
> > > resume.  I think it's generally acceptable to refuse to do a "fast path" suspend
> > > if the device state is not RPM_ACTIVE at the moment, but refusing to do
> > > a "fast path" resume may be more problematic (more on that later).
> > 
> > That's what I thought too, but Kevin has suggested this might not be 
> > so.
> > 
> > > The particular case we need to handle (I think) is that some devices need to be
> > > resumed "atomically" as a part of bringing a CPU package out of a C-like-state
> > > (Kevin, is that correct?).  In that case not only we can't defer the resume (by
> > > using a workqueue), but also we have to finish the resume within strict time
> > > constraints (the time to leave the given C-like-state is one of the parameters
> > > used by cpuidle governors to decide which state to choose).
> > 
> > To what extent can this really happen?  If the CPU was previously in a 
> > C-like state then it couldn't be in the middle of changing the device's 
> > power state.  Maybe a different CPU was suspending or resuming the 
> > device, but if that's so then why would this CPU need to resume it as 
> > part of bringing the package out of the C-like state?
> 
> That's the case when user space writes to /sys/devices/.../power/control on
> another CPU.
> 
> > > On the other hand, busy waiting (by looping) in the case the state is
> > > RPM_RESUMING is as though the callbacks were executed under a spinlock and we
> > > happened to wait on it.  I'd prefer to avoid that.  Moreover, if the state is
> > > RPM_SUSPENDING at the time a "fast path" resume is started, we are almost
> > > guaranteed to violate the time constraints (by busy waiting for the suspend to
> > > complete and carrying out the resume).
> > 
> > I'm not convinced that the time constraints are all that hard.  At 
> > least, I can't think of a situation where we do face a hard time limit 
> > and also the device might be in the middle of a transition when we need 
> > to resume it.
> 
> Now that I think of it, you seem to be right.

However, there's the following scenario (I don't know how realistic it is, though).
It is not related to the cpuidle case, it is related to the case when the device
is woken up by its own IRQ.  Namely, in that case it is perfectly possible that
the IRQ appears exactly when the device is suspending, so if there's a "fast
resume" in the interrupt handler, it will have to wait for the suspend to
complete (or fail).  That in theory may lead to a violation of time constraints
(if there are any).

...
> > This seems much more complicated than we need.  Why not require for any
> > particular device that all resumes and suspends are either always fast
> > or always normal (i.e., always done with interrupts disabled or always
> > done with interrupts enabled)?  That's what the original patch does.
> >
> > Sure, maybe some devices don't need to have fast suspend all the time.  
> > But we don't lose anything by requiring them to always use it in order
> > to gain the benefit of fast resume.
> 
> I think we should avoid turning interrupts off for the whole suspend/resume
> time if not strictly necessary.

Well, perhaps that's not a problem.

I wonder if we can do the "fast suspend" and "fast resume" under the
power.lock spinlock.  That would allow us to avoid some complications
related to RPM_RESUMING and RPM_SUSPENDING.  Namely,
if the device is flagged as "power.irq_safe", it will always suspend and
resume "atomically" under its power.lock spinlock.  Then, the status will
always be either RPM_ACTIVE or RPM_SUSPENDED (or RPM_ERROR,
which is uninteresting).  Also, if "fast suspend" doesn't change the device
parent's power.child_count, we won't need to worry about parents any more.

I'm still not sure what to do with _idle() in that case.

Thanks,
Rafael
