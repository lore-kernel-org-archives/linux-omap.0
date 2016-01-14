From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Thu, 14 Jan 2016 14:22:27 +0000
Message-ID: <20160114142227.GB5783@n2100.arm.linux.org.uk>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com>
 <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com>
 <56977BA7.702@ti.com>
 <20160114112354.GA17869@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160114112354.GA17869@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Keerthy <a0393675@ti.com>, nm@ti.com, grygorii.strashko@ti.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, peterz@infradead.org, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, josh@joshtriplett.org, edubezval@gmail.com, joel@jms.id.au, mpe@ellerman.id.au, akpm@linux-foundation.org, linux-omap@vger.kernel.org, dyoung@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 14, 2016 at 12:23:54PM +0100, Ingo Molnar wrote:
> * Keerthy <a0393675@ti.com> wrote:
> > I tried to simulate the issue.
> > 
> > In the probe function of drivers/thermal/ti-soc-thermal/ti-bandgap.c
> > ti_bandgap_probe i call
> > 
> > orderly_poweroff(true);
> > 
> > This is while driver probes are still on going. I observe that
> > ret = run_cmd(poweroff_cmd);
> > 
> > ret is a non-zero value and we enter the if condition:
> > 
> > Even after the
> > 
> > emergency_sync();
> > kernel_power_off();
> > 
> > calls
> > 
> > the console remained active in weird state.
> 
> Now _that_ is clearly an architecture bug that should not be papered over ...

No, it's not an architecture bug - it's a platform bug.  The ARM
architecture has no standard way to control CPU reset or system
power, all that is up to the platform.

> If kernel_power_off() is called then the system should power off. No
> ifs and whens.

There definitely are ifs and whens.  Only if the platform has support,
and when that support works.

If the platform does not provide such support, or that support is
broken, there's nothing that can be done at the architecture level.

Looking at the log given via the message that was referred to in a
previous message in this thread, it looks like userspace fails to get
to the point of calling into the kernel:

159.636627] rc              S c0756104     0   527      1 0x00000000
159.643027] [<c0756104>] (__schedule) from [<c0756778>] (schedule+0x40/0x98)
159.650108] [<c0756778>] (schedule) from [<c0193c50>] (pipe_wait+0x60/0x9c)
159.657102] [<c0193c50>] (pipe_wait) from [<c0193cc0>] (wait_for_partner+0x34/0x
159.664792] [<c0193cc0>] (wait_for_partner) from [<c01947fc>] (fifo_open+0x1a4/0
159.672658] [<c01947fc>] (fifo_open) from [<c018a5c0>] (do_dentry_open+0x1c8/0x3
159.680351] [<c018a5c0>] (do_dentry_open) from [<c019855c>] (do_last+0x64c/0xce0
159.687867] [<c019855c>] (do_last) from [<c019adf8>] (path_openat+0x80/0x608)
159.695036] [<c019adf8>] (path_openat) from [<c019be34>] (do_filp_open+0x2c/0x88
159.702555] [<c019be34>] (do_filp_open) from [<c018b94c>] (do_sys_open+0xfc/0x1c
159.710158] [<c018b94c>] (do_sys_open) from [<c00102a0>] (ret_fast_syscall+0x0/0

and later on, it's still there:

219.253041] rc              S c0756104     0   527      1 0x00000000
219.259443] [<c0756104>] (__schedule) from [<c0756778>] (schedule+0x40/0x98)
219.266524] [<c0756778>] (schedule) from [<c0193c50>] (pipe_wait+0x60/0x9c)
219.273516] [<c0193c50>] (pipe_wait) from [<c0193cc0>] (wait_for_partner+0x34/0x
219.281206] [<c0193cc0>] (wait_for_partner) from [<c01947fc>] (fifo_open+0x1a4/0
219.289071] [<c01947fc>] (fifo_open) from [<c018a5c0>] (do_dentry_open+0x1c8/0x3
219.296762] [<c018a5c0>] (do_dentry_open) from [<c019855c>] (do_last+0x64c/0xce0

The 'rc' script in sysvinit/upstart is normally responsible for walking
through /etc/rc?.d/* running the scripts in order.  It looks like this
has wedged, and so it's not getting anywhere near to asking the kernel
to shut down.

That's even more confirmed by there being no "Power down" message in
the log, which is printed by kernel_power_off().  So I'm not convinced
that the pointed to log is actually an illustration of the problem
that its being discussed here: it looks to me like some other failure,
and it looks like 'rc' is stuck trying to open a fifo.

It would be nice to see an example of a log where we have proof that
kernel_power_off() was called (via the "Power down" message being in
the log.)

In any case, at the architecture level, if a platform code fails to
reboot, we print "Reboot failed -- System halted", disable IRQs and
spin.

We don't print anything if a platform hasn't provided a "pm_power_off()"
hook, or that hook fails though - we just fall back to the generic
code which does a do_exit(0) for the caller.

I think some people have their power off/reboot stuff as part of their
watchdog driver, which can be a loadable module - if the module isn't
loaded, then these facilities are not available.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
