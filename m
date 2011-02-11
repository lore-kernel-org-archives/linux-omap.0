From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] PM: Allow pm_runtime_suspend() to succeed during system suspend
Date: Fri, 11 Feb 2011 15:45:23 -0800
Message-ID: <87aai26sq4.fsf@ti.com>
References: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
	<201102112100.23996.rjw@sisk.pl> <87ei7e9uhy.fsf@ti.com>
	<201102112225.54140.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57462 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756856Ab1BKXp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 18:45:27 -0500
In-Reply-To: <201102112225.54140.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 11 Feb 2011 22:25:53 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, February 11, 2011, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Monday, January 31, 2011, Rafael J. Wysocki wrote:
>> >> On Monday, January 31, 2011, Alan Stern wrote:
>> >> > On Mon, 31 Jan 2011, Kevin Hilman wrote:
>> >> > 
>> >> > > I understand how this works, but frankly I'm still a bit fuzzy on why.
>> >> > > 
>> >> > > I guess I'm still missing a good understanding of what "interfering with a
>> >> > > system power transition" means, and why a runtime suspend qualifies as
>> >> > > interfering but not a runtime resume.
>> >> > 
>> >> > These are good questions.  Rafael implemented this design originally; 
>> >> > my contribution was only to warn him of the potential for problems.  
>> >> > Therefore he should explain the rationale for the design.
>> >> 
>> >> The reason why runtime resume is allowed during system power transitions is
>> >> because in some cases during system suspend we simply have to resume devices
>> >> that were previously runtime-suspended (for example, the PCI bus type does
>> >> that).
>> >> 
>> >> The reason why runtime suspend is not allowed during system power transitions
>> >> if the following race:
>> >> 
>> >> - A device has been suspended via a system suspend callback.
>> >> - The runtime PM framework executes a (scheduled) suspend on that device,
>> >>   not knowing that it's already been suspended, which potentially results in
>> >>   accessing the device's registers in a low-power state.
>> >> 
>> >> Now, it can be avoided if every driver does the right thing and checks whether
>> >> the device is already suspended in its runtime suspend callback, but that would
>> >> kind of defeat the purpose of the runtime PM framework, at least partially.
>> >
>> > In fact, I've just realized that the above race cannot really occur, because
>> > pm_wq is freezable, so I'm proposing the following change.
>> >
>> > Of course, it still doesn't prevent user space from disabling the runtime PM
>> > framework's helpers via /sys/devices/.../power/control.
>> >
>> > Thanks,
>> > Rafael
>> >
>> >
>> > ---
>> > From: Rafael J. Wysocki <rjw@sisk.pl>
>> > Subject: PM: Allow pm_runtime_suspend() to succeed during system suspend
>> >
>> > The dpm_prepare() function increments the runtime PM reference
>> > counters of all devices to prevent pm_runtime_suspend() from
>> > executing subsystem-level callbacks.  However, this was supposed to
>> > guard against a specific race condition that cannot happen, because
>> > the power management workqueue is freezable, so pm_runtime_suspend()
>> > can only be called synchronously during system suspend and we can
>> > rely on subsystems and device drivers to avoid doing that
>> > unnecessarily.
>> >
>> > Make dpm_prepare() drop the runtime PM reference to each device
>> > after making sure that runtime resume is not pending for it.
>> >
>> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> > ---
>> 
>> Yes!
>> 
>> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Well, I hope you realize that it doesn't help you a lot?
>

If you mean that because we still have to implement system PM methods
because of /sys/devices/.../power/control, I agree.

If something else, please explain.

But to me it is still very helpful in terms of consistency and what
driver writers would expect to happen if they used pm_runtime_suspend()
in their system suspend method.

Thanks,

Kevin


