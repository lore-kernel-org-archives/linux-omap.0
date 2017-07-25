From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] USB: musb: fix external abort on suspend
Date: Tue, 25 Jul 2017 10:38:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1707251030280.2256-100000@iolanthe.rowland.org>
References: <20170725070929.GK2729@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170725070929.GK2729@localhost>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Daniel Mack <zonque@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 25 Jul 2017, Johan Hovold wrote:

> On Mon, Jul 24, 2017 at 01:13:22PM -0400, Alan Stern wrote:
> > On Mon, 24 Jul 2017, Johan Hovold wrote:
> > 
> > > On Mon, Jul 24, 2017 at 10:38:41AM -0400, Alan Stern wrote:
> > > > On Mon, 24 Jul 2017, Johan Hovold wrote:
> > > > 
> > > > > Make sure that the controller is runtime resumed when system suspending
> > > > > to avoid an external abort when accessing the interrupt registers:
> > > > > 
> > > > >   Unhandled fault: external abort on non-linefetch (0x1008) at 0xd025840a
> > > > >   ...
> > > > >   [<c05481a4>] (musb_default_readb) from [<c0545abc>] (musb_disable_interrupts+0x84/0xa8)
> > > > >   [<c0545abc>] (musb_disable_interrupts) from [<c0546b08>] (musb_suspend+0x38/0xb8)
> > > > >   [<c0546b08>] (musb_suspend) from [<c04a57f8>] (platform_pm_suspend+0x3c/0x64)
> > > > > 
> > > > > This is easily reproduced on a BBB by enabling the peripheral port only
> > > > > (as the host port may enable the shared clock) and keeping it
> > > > > disconnected so that the controller is runtime suspended. (Well, you
> > > > > would also need to the not-yet-merged am33xx-suspend patches by Dave
> > > > > Gerlach to be able to suspend the BBB.)
> > > > > 
> > > > > This is a regression that was introduced by commit 1c4d0b4e1806 ("usb:
> > > > > musb: Remove pm_runtime_set_irq_safe") which allowed the parent glue
> > > > > device to runtime suspend and thereby exposed a couple of older issues:
> > > > > 
> > > > > Register accesses without explicitly making sure the controller is
> > > > > runtime resumed during suspend was first introduced by commit
> > > > > c338412b5ded ("usb: musb: unconditionally save and restore the context
> > > > > on suspend") in 3.14.
> > > > > 
> > > > > Commit a1fc1920aaaa ("usb: musb: core: make sure musb is in RPM_ACTIVE on
> > > > > resume") later started setting the RPM status to active during resume
> > > > > without first making sure that the parent was runtime resumed. This was
> > > > > also implicitly relying on the parent always being active. Since commit
> > > > > 71723f95463d ("PM / runtime: print error when activating a child to
> > > > > unactive parent") this now also results in following warning:
> > > > > 
> > > > >   musb-hdrc musb-hdrc.0: runtime PM trying to activate child device
> > > > >     musb-hdrc.0 but parent (47401400.usb) is not active
> > > > 
> > > > I don't understand this.  Why wouldn't the parent be in RPM_ACTIVE at
> > > > this time?  After all, how could the system be expected to resume a
> > > > child device if its parent wasn't fully active?
> > > 
> > > The parent for a musb controller is a "glue" device (e.g. musb_dsps)
> > > which previously was always kept active, but that's no longer the case
> > > as mentioned above.
> > 
> > Even if the parent is not always kept active, it should still be active
> > during a system resume.  Starting from the time its resume routine
> > runs, it should remain at full power until the system resume is 
> > finished.
> 
> It is powered, but its runtime PM status does not reflect that, and that
> is the problem. This patch makes sure that the child, and thereby
> parent, are both runtime resumed throughout system suspend, but perhaps
> that should be done explicitly in the parent driver as well (more
> below).
> 
> > > In a system with two controllers (e.g. a Beagle Bone Black),
> > 
> > Do you mean a host controller and a peripheral controller?
> 
> Yes, in this example (the BBB has two OTG controllers), but it could
> just as well be two controllers in peripheral mode where one is active.
> 
> > > the host
> > > port may be active and keep the shared clock enabled (managed by the
> > > grandparent device). Thereby the external-abort crash can be avoided
> > > when suspending a disconnected (and runtime suspended) peripheral port.
> > 
> > So what?  There are lots of ways of avoiding such crashes.  (Disabling
> > the driver entirely, for example.)  They aren't relevant for this
> > discussion.
> 
> Perhaps I read your question too literally above; I'm trying to explain
> how you can end up with a runtime suspended parent during resume, without
> hitting the external abort during suspend, with the current kernel.
> 
> This can be done by keeping the sibling/cousin controller enabled, but
> could of course also have been achieved by preventing the grandparent
> (omap) device (which controls the clock) from suspending by other means.
> 
> I'm just describing how this could happen with the current
> implementation; I'm not claiming that the implementation is correct.
> 
> > > When the system is later resumed, you would hit that broken activation
> > > code of the runtime suspended device, with a likewise runtime suspended
> > > parent, and the warning would be printed.
> > 
> > Why would the parent be runtime suspended?  Why wouldn't it still be in
> > the full-power state, the way its own resume routine should have left
> > it?
> > 
> > Maybe I'm being slow and dumb here, but I don't see how any of this 
> > answers the question I raised earlier.
> 
> I think understand what you're getting at and yes, the parent *should*
> be RPM_ACTIVE, while I'm saying that it *currently* is not guaranteed.
> 
> As mentioned above, this patch does make sure that child and parent are
> both runtime resume when suspending and therefore remain RPM_ACTIVE
> throughout suspend. This specifically means that the explicit activation
> code on resume can now be removed.
> 
> But I should fix that paragraph and not blame the explicit activation
> code for not "making sure that the parent was runtime resumed".
> 
> In fact, some of the parent glue drivers also do register accesses in
> their suspend/resume callbacks which ought to have been preceded by an
> explicit runtime resume. These glue drivers are a bit special however
> and does check for a registered child in their pm callbacks so it's not
> a problem in practise. I think I'll add them anyway for clarity in a
> follow up patch.

I see.  Thanks for the explanation.

Alan Stern
