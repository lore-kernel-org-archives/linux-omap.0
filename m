From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] - race-free suspend.  Was: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 22:41:14 +0200
Message-ID: <201006022241.14152.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org> <alpine.LFD.2.00.1006011243350.2933@localhost.localdomain> <20100602153235.340a7852@notabene.brown>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100602153235.340a7852@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-omap@vger.kernel.org

On Wednesday 02 June 2010, Neil Brown wrote:
> On Tue, 1 Jun 2010 12:50:01 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Tue, 1 Jun 2010, Neil Brown wrote:
> > > 
> > > I think you have acknowledged that there is a race with suspend - thanks.
> > > Next step was "can it be closed".
> > > You seem to suggest that it can, but you describe it as a "work around"
> > > rather than a "bug fix"...
> > > 
> > > Do you agree that the race is a "bug", and therefore it is appropriate to
> > > "fix" it assuming an acceptable fix can be found (which I think it can)?
> > 
> > If we can fix it, yes we definitely should do and not work around it.
> >  
> > Thanks,
> > 
> > 	tglx
> 
> OK.
> Here is my suggestion.
> 
> While I think this patch would actually work, and hope the ugly aspects are
> reasonably balanced by the simplicity, I present it primarily as a base for
> improvement.
> The important part is to present how drivers and user-space can co-operate 
> to avoid losing wake-events.  The details of what happens in the kernel are
> certainly up for discussion (as is everything else really of course).
> 
> The user-space suspend daemon avoids losing wake-events by using
> fcntl(F_OWNER) to ensure it gets a signal whenever any important wake-event
> is ready to be read by user-space.  This may involve:
>   - the one daemon processing all wake events
>   - Both the suspend daemon and the main event handling daemon opening any
>     given device that delivers wake events (this should work with input
>     events ... unless grabbing is needed)
>   - The event handling daemon giving the suspend-daemon's pid as F_OWNER, and
>     using poll/select to get the events itself.
> 
> When 'mem' is written to /sys/power/state, suspend_prepare waits in an
> interruptible wait until any wake-event that might have been initiated before
> the suspend was request, has had a chance to be queued for user-space and
> trigger kill_fasync.
> Currently this wait is a configurable time after the last wake-event was
> initiated.  This is hackish, but simple and probably adequate.
> If more precise timing is needed and achievable, that can be added later.  It
> would be an entirely internal change and would not affect the API further.
> Some of the code developed for suspend-blockers might be a starting point for
> this.
> 
> Drivers should call pm_suspend_delay() whenever a wake-event occurs.  This
> simply records the time so that the suspend process knows if there is in fact
> any need to wait at all.
> 
> The delay to wait after the last pm_suspend_delay() is limited to 10 seconds
> and can be set by kernel parameter suspend_block_delay=number-of-milliseconds
> It defaults to 2 jiffies (which is possibly too short).
> 
> - Would this fix the "bug"??
> - and address the issues that suspend-blockers was created to address?
> - or are the requirements on user-space too onerous?

In theory wakeup events can also happen after  wait_for_blockers() has returned
0 and I guess we should rollback the suspend in such cases.

Rafael
