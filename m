From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] PM: Allow pm_runtime_suspend() to succeed during system suspend
Date: Sat, 12 Feb 2011 01:00:49 +0100
Message-ID: <201102120100.49255.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org> <201102112225.54140.rjw@sisk.pl> <87aai26sq4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87aai26sq4.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday, February 12, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> writes:
> 
> > On Friday, February 11, 2011, Kevin Hilman wrote:
> >> "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> writes:
> >> 
> >> > On Monday, January 31, 2011, Rafael J. Wysocki wrote:
> >> >> On Monday, January 31, 2011, Alan Stern wrote:
> >> >> > On Mon, 31 Jan 2011, Kevin Hilman wrote:
> >> >> > 
> >> >> > > I understand how this works, but frankly I'm still a bit fuzzy on why.
> >> >> > > 
> >> >> > > I guess I'm still missing a good understanding of what "interfering with a
> >> >> > > system power transition" means, and why a runtime suspend qualifies as
> >> >> > > interfering but not a runtime resume.
> >> >> > 
> >> >> > These are good questions.  Rafael implemented this design originally; 
> >> >> > my contribution was only to warn him of the potential for problems.  
> >> >> > Therefore he should explain the rationale for the design.
> >> >> 
> >> >> The reason why runtime resume is allowed during system power transitions is
> >> >> because in some cases during system suspend we simply have to resume devices
> >> >> that were previously runtime-suspended (for example, the PCI bus type does
> >> >> that).
> >> >> 
> >> >> The reason why runtime suspend is not allowed during system power transitions
> >> >> if the following race:
> >> >> 
> >> >> - A device has been suspended via a system suspend callback.
> >> >> - The runtime PM framework executes a (scheduled) suspend on that device,
> >> >>   not knowing that it's already been suspended, which potentially results in
> >> >>   accessing the device's registers in a low-power state.
> >> >> 
> >> >> Now, it can be avoided if every driver does the right thing and checks whether
> >> >> the device is already suspended in its runtime suspend callback, but that would
> >> >> kind of defeat the purpose of the runtime PM framework, at least partially.
> >> >
> >> > In fact, I've just realized that the above race cannot really occur, because
> >> > pm_wq is freezable, so I'm proposing the following change.
> >> >
> >> > Of course, it still doesn't prevent user space from disabling the runtime PM
> >> > framework's helpers via /sys/devices/.../power/control.
> >> >
> >> > Thanks,
> >> > Rafael
> >> >
> >> >
> >> > ---
> >> > From: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> >> > Subject: PM: Allow pm_runtime_suspend() to succeed during system suspend
> >> >
> >> > The dpm_prepare() function increments the runtime PM reference
> >> > counters of all devices to prevent pm_runtime_suspend() from
> >> > executing subsystem-level callbacks.  However, this was supposed to
> >> > guard against a specific race condition that cannot happen, because
> >> > the power management workqueue is freezable, so pm_runtime_suspend()
> >> > can only be called synchronously during system suspend and we can
> >> > rely on subsystems and device drivers to avoid doing that
> >> > unnecessarily.
> >> >
> >> > Make dpm_prepare() drop the runtime PM reference to each device
> >> > after making sure that runtime resume is not pending for it.
> >> >
> >> > Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> >> > ---
> >> 
> >> Yes!
> >> 
> >> Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> >
> > Well, I hope you realize that it doesn't help you a lot?
> >
> 
> If you mean that because we still have to implement system PM methods
> because of /sys/devices/.../power/control, I agree.

Yes, I meant that.
 
> If something else, please explain.
>
> But to me it is still very helpful in terms of consistency and what
> driver writers would expect to happen if they used pm_runtime_suspend()
> in their system suspend method.

OK

Thanks,
Rafael
