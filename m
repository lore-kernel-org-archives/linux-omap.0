From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 01:24:25 +0200
Message-ID: <201005280124.25347.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271526130.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271526130.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 27 May 2010, Alan Stern wrote:
> On Thu, 27 May 2010, Alan Cox wrote:
> 
> > > Rather than continue going around in circles, let's agree that what the 
> > > Android people want is a new version of forced suspend -- not a 
> > 
> > I don't think this is true. I think that is the root of the problem.
> 
> Of course it's true.  Just ask Arve -- he wants opportunistic suspend 
> and it _is_ a variant of forced suspend.  Ergo he wants a new type of 
> forced suspend.

Well, as I just wrote in a different message, what he _really_ wants is to
get maximum possible battery life and he found experimentally that this is
achieved by suspending the whole system as often as reasonably possible.

Of course, the "reasonably possible" part needs clarification.

> Maybe that's not what he _ought_ to want.  Nevertheless, there are 
> valid reasons for wanting it.
> 
> > I don't disagree with the user experience they are trying to create or
> > the fact something is needed to make it possible (if it turns out we
> > can't already do it).
> > 
> > Forced suspend is sticking stuff in running state into suspend
> > 
> > Power management models (such as Thomas ARM box) which we know work are
> > 'when nothing is running' into suspend.
> > 
> > So for me the real question on that side of this specific case is 'how
> > do you make sure those tasks are idle when you need them to be'
> > 
> > QoS ?
> > Spanking them from user space ?
> > Drivers enforcing policy elements by blocking tasks ?
> 
> Currently we use the freezer.  But it is a blunt tool -- it freezes 
> every user process.  Also, it doesn't actually make processes 
> unrunnable; it just arranges things so that when they do run, they 
> immediately put themselves back to sleep.
> 
> And the forced-suspend design relies on the fact that processes remain 
> frozen throughout.  If we leave some processes unfrozen and one of them 
> somehow becomes runnable, that means we have to abort the forced 
> suspend before the process is allowed to run.

We could avoid that if drivers could block tasks, but there are questions to
answer.  First off, how a driver is supposed to know when to block the task
using it and when to do its power management transparently for the task?
Second, how to intercept and block all possible interfaces that user space
can use to talk to drivers (how to intercept a task using mmapped device, for
example)?

Rafael
