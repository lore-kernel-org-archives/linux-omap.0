From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper
 functions
Date: Sun, 8 Mar 2015 11:34:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503081131510.3638-100000@netrider.rowland.org>
References: <1638656.aLmbYYvRI6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1638656.aLmbYYvRI6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 7 Mar 2015, Rafael J. Wysocki wrote:

> > > Well right now it's using threaded irq, and I'd like to get rid of
> > > I'll verify again, but I believe the issue was that without doing
> > > mark_last_busy here the device falls back asleep right away.
> > > That probably should be fixed in pm_runtime in general if that's
> > > the case.
> > 
> > It's up to the subsystem to handle this.  For example, the USB 
> > subsystem's runtime-resume routine calls pm_runtime_mark_last_busy.
> 
> I'm wondering, though, if there's any reason for us to avoid updating
> power.last_busy in rpm_resume().
> 
> If I was a driver writer, I'd expect the core to do that for me quite frankly.

In theory, you might want to wake up a device to perform some very 
limited operation (like reading an internal register) and then put it 
back into suspend very quickly, without waiting for the autosuspend 
delay to elapse.  Apart from that, I can't think of any reason not to 
update last_busy in rpm_resume.

Alan Stern
