From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Fri, 8 Oct 2010 12:18:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010081200200.27105-100000@netrider.rowland.org>
References: <201010072311.31071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57447 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758521Ab0JHQS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 12:18:59 -0400
In-Reply-To: <201010072311.31071.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thu, 7 Oct 2010, Rafael J. Wysocki wrote:

> > 	If the PM core simply avoids releasing dev->power.lock before
> > 	invoking the runtime_suspend or runtime_resume callback, the
> > 	end result is almost the same as with busy-waiting.
> 
> This is slightly more complicated, because suspend is a bit different from
> resume.  I think it's generally acceptable to refuse to do a "fast path" suspend
> if the device state is not RPM_ACTIVE at the moment, but refusing to do
> a "fast path" resume may be more problematic (more on that later).

That's what I thought too, but Kevin has suggested this might not be 
so.

> The particular case we need to handle (I think) is that some devices need to be
> resumed "atomically" as a part of bringing a CPU package out of a C-like-state
> (Kevin, is that correct?).  In that case not only we can't defer the resume (by
> using a workqueue), but also we have to finish the resume within strict time
> constraints (the time to leave the given C-like-state is one of the parameters
> used by cpuidle governors to decide which state to choose).

To what extent can this really happen?  If the CPU was previously in a 
C-like state then it couldn't be in the middle of changing the device's 
power state.  Maybe a different CPU was suspending or resuming the 
device, but if that's so then why would this CPU need to resume it as 
part of bringing the package out of the C-like state?

> On the other hand, busy waiting (by looping) in the case the state is
> RPM_RESUMING is as though the callbacks were executed under a spinlock and we
> happened to wait on it.  I'd prefer to avoid that.  Moreover, if the state is
> RPM_SUSPENDING at the time a "fast path" resume is started, we are almost
> guaranteed to violate the time constraints (by busy waiting for the suspend to
> complete and carrying out the resume).

I'm not convinced that the time constraints are all that hard.  At 
least, I can't think of a situation where we do face a hard time limit 
and also the device might be in the middle of a transition when we need 
to resume it.

> So, here's an idea:
> 
> First, let's introduce two flags in struct dev_pm_info, irq_safe and
> fast_resume.  The former has to be set so that the things above work.
> 
> Second, let's add a new flag to pass to __pm_runtime_{suspend|resume}(),
> RPM_FAST_RESUME such that if it is passed to __pm_runtime_suspend(), it
> causes fast_resume to be set for the given device (if the status is already
> RPM_SUSPENDED, it just sets the flag, otherwise it suspends the device
> normally and then sets the flag).  Now, if fast_resume is set,
> __pm_runtime_resume() has to be passed RPM_FAST_RESUME, or it will
> fail (it also will fail if passed RPM_FAST_RESUME and fast_resume isn't
> set).  In that case the status has to be RPM_SUSPENDED or RPM_RESUMING
> (otherwise fast_resume won't be set)

Why not?  Does fast_resume ever get cleared?

>  and if it is RPM_RESUMING, this means
> that the other resume has been called with RPM_FAST_RESUME too (it would
> fail otherwise), so it's fine to busy loop until the status is RPM_SUSPENDED
> (it's the caller's problem to avoid that).  RPM_FAST_RESUME causes
> __pm_runtime_resume() to avod turning interrupts on.
> 
> If necessary, there may be a flag for __pm_runtime_suspend() that will
> carry out "atomic" suspend, but I'm not sure if that's necessary.  Kevin?

This seems much more complicated than we need.  Why not require for any
particular device that all resumes and suspends are either always fast
or always normal (i.e., always done with interrupts disabled or always
done with interrupts enabled)?  That's what the original patch does.

Sure, maybe some devices don't need to have fast suspend all the time.  
But we don't lose anything by requiring them to always use it in order
to gain the benefit of fast resume.

Alan Stern

