From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Thu, 23 Jun 2011 22:34:21 +0200
Message-ID: <201106232234.21930.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54213 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932973Ab1FWUdl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 16:33:41 -0400
In-Reply-To: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Paul Walmsley <paul@pwsan.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Hi,

On Thursday, June 23, 2011, Alan Stern wrote:
> On Thu, 23 Jun 2011, Paul Walmsley wrote:
> 
> > Hi
> > 
> > a few thoughts here:
> > 
> > On Wed, 15 Jun 2011, Rafael J. Wysocki wrote:
> > 
> > > On Tuesday, June 14, 2011, Magnus Damm wrote:
> > >
> > > > As for freezing user space, yes, I agree. The other feature including
> > > > a different set of wakeup sources, not so sure why you would want to
> > > > have that. I can't think of any good use case for that, from my point
> > > > of view system-wide suspend is more like the limping cousin of the
> > > > full-blown kernel.
> > > 
> > > Well, the freezing of user space by itself doesn't buy you anything
> > > power management-wise, you pretty much need to do the other things too to
> > > really save energy this way. 
> > 
> > Freezing user space stops CPU-hogging processes from running.  When the 
> > runqueue is empty, the scheduler can go idle.  This in turn allows the 
> > CPU(s) to enter low power sleep states via CPUIdle.

But you don't have to freeze user space for this purpose, do you?
You may simply send a SIGSTOP to those processes.

> Very true.  At the moment, isn't it possible for the userspace 
> ioctl PM interface to freeze processes without going all the way 
> through to a system sleep?

Yes, it is.

> > As I understand it, this is really the basis for the modern Android 
> > use-case for wakelocks and opportunistic suspend.  They prevent 
> > non-power-privileged userspace applications from keeping the system from 
> > entering a low-power state.  (Secondarily, suspend also prevents kernel 
> > code from running, e.g., timers set by filesystems, the networking stack, 
> > etc.; but problems here should be fixed in the offending kernel code, 
> > rather than hacked around, since some of the users of those timers could 
> > be important)
> 
> I think you have oversimplified things a little, but never mind...

Well, saying "a little" is an overstatement. :-)

This was given as one of the arguments why using the wakelocks mechanism
along with the opportunistic suspend might be regarded as a good idea, but
I think the _real_ reason why it is used by Android is that the system
suspend framework was usable already when Android was being developed and if
they wanted to get acceptable battery lives at that time, they simply had no
choice but to use it.

> > > Anyway, the value of system suspend is to allow the user to tell the system
> > > "OK, now I'm not going to use you for a while and I don't want the USB mouse
> > > to wake you up", so that the system can go into a state in which it draws
> > > minimum energy.
> > > 
> > > Of course, you can argue that the system may detect when it's not used and
> > > put itself into that state, which is somewhat correct, but the system can
> > > _never_ know two things by itself: (1) that it's not going to be used _in_
> > > _advance_
> > 
> > But suspend users don't know this either, since they can't predict when 
> > the next external wakeup can happen.

That's going backwards somewhat.  First, a suspend user is supposed to choose
what devices can wake up the system in response to external events, so he
can choose to not allow any devices to do that.  Second, if external wakeup
sigals (and such that the user doesn't control directly) are enabled, this
basically means that the user allows someone else to wake up the system.
He may not know when this happens, but that's a bit like saying
"I don't need you now, but if someone else does, so be it."

> But they do know (or should know) that they don't intend to use the 
> system in the near future.  It might be good to have a separate way to 
> express that idea to the kernel.

Starting system suspend means exactly that: "Go to a sleep state, because
I'm not going to use you now (until I will wake you up)".

Now, you can set an RTC etc. to wake up the system from sleep states, so
people thought it might mean something different, but it simply doesn't.

> > Having some kind of indication that the user is done using a device for 
> > the time being is definitely useful.  But that's separate from system 
> > suspend.  System suspend is just one of many actions that the system might 
> > choose to take when the user gives that indication.

I generally agree, but "system" should not be confused with "the kernel".

Let me rephrase what I have already said for many times: system suspend
interface in the kernel is for user space, so that it can put the system into
a sleep state at any time.  The decision to use it need not be made
directly by the user, but from the kernel's point of view it doesn't matter.
The interface is there and it works how it works.

> > Consider something like a screensaver.  Usually, the longer latency the 
> > wakeup operation is, the longer the screensaver waits before deciding to, 
> > say, power the monitor off, or put the system into suspend (as we 
> > discussed that Mac OS X does at LinuxCon Boston).  Similarly, if there is 
> > some background task that really needs to run, an intelligent system will 
> > not allow a power economization mode to prevent that from happening.
> > 
> > > and (2) that it is supposed to ignore wakeup signals from certain
> > > sources. 
> > 
> > Isn't this configurable now without system suspend with the wakeup sources 
> > code?
> 
> The wakeup code does two things: It tells the system which devices 
> should be enabled for wakeup when the system sleeps (as opposed to 
> cpuidle, when all devices should be able to generate interrupts), and 
> it tells the system when a wakeup event has just occurred so that the 
> system won't allow itself to go to sleep before the event can be 
> processed.

I think I know what Paul meant here.  Namely, whether or not subsystems (or
platforms) can use this information in the runtime PM context.  In my opinion
that might be possible, but it would requre us to distinguish between situations
in which the wakeup setting should and should not be taken into account.

> > > As I said, support for system suspend allows the user to do more with the
> > > system and you really can't implement that functionality differently.  You
> > > may choose not to implement it at all, but why should you?
> > 
> > The individual components of system suspend are definitely useful:
> > 
> > 1. preventing userspace processes from keeping the system from entering 
> >    idle
> > 2. preventing userspace processes from waking the system back up
> 
> It's not clear what this means.  How can a user process wake the system 
> up?  Are you referring to user timers?
> 
> Do we have a way (or want a way) to distinguish between user timers and
> kernel timers?
> 
> > 3. preventing kernel code from keeping the system from entering idle
> 
> Relatively few kernel threads are freezable.  The ones that are tend to 
> be involved in device management.  Did you have something specific in 
> mind?
> 
> > 4. preventing kernel code from waking the system back up
> > 5. requesting that drivers abort what they are currently doing
> 
> Not exactly "abort".  More like "stop processing their I/O queues".
> 
> > The main issues are that these:
> > 
> > 1. are all bundled up into one operation
> > 
> > 2. target the entire universe of entities that they manage, rather than 
> > selectively targeting non-power-privileged entities
> 
> That's an interesting way of thinking about it.  Thanks for bringing 
> it up.

Quite frankly, it's not entirely new to me and I seem to remember it being
mentioned during the discussion following the Android wakelocks patches
submission.

Anyway, the system suspend (and hibernation) interface is what it is and
there are good reasons why it is desigened this way.  To me, as I said already
before, the question is not if it can be replaced with something else, because
it can't (there are platforms where something else won't work), but if a
given platofrm has a reason to support it.  That, of course, depends on the
platform in question, but surely every platform wanting to support Android
pretty much has to support the system suspend interface too. :-)

I, personally, think that there are good reasons to support it too, but my
reasons need not be everyone's reasons.

Thanks,
Rafael
