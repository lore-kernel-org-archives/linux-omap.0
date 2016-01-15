From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Fri, 15 Jan 2016 14:12:17 +0000
Message-ID: <20160115141217.GF5783@n2100.arm.linux.org.uk>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com>
 <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com>
 <56977BA7.702@ti.com>
 <20160114112354.GA17869@gmail.com>
 <20160114132527.575e0f20@lxorguk.ukuu.org.uk>
 <20160115101459.GB23349@gmail.com>
 <5698F420.2010500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5698F420.2010500@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, nm@ti.com, Keerthy <a0393675@ti.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org, peterz@infradead.org, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, josh@joshtriplett.org, edubezval@gmail.com, joel@jms.id.au, mpe@ellerman.id.au, akpm@linux-foundation.org, linux-omap@vger.kernel.org, dyoung@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 15, 2016 at 03:29:04PM +0200, Grygorii Strashko wrote:
> Seems ARM doesn't have endless loop implemented in machine_power_off() - so,
> not too much chances for Watchdog to fire.
> void machine_power_off(void)
> {
> 	local_irq_disable();
> 	smp_send_stop();
> 
> 	if (pm_power_off)
> 		pm_power_off();
> 
> 	--- endless loop ?
> 	--- or restart ?
> }
> [and even if it will be there - 20-30sec is usual timeout for Watchdog
> and this enough time to burn the system in case of thermal emergency
> poweroff :(]

I covered this in my reply to Ingo yesterday.  The result is that a
failed or unimplemented call drops through to do_exit(0) on behalf of
the calling process, terminating that process.  However, as I said
in that same email, I don't think you're getting anywhere near this
code.

> That's true - original log [1] has 
> Nov 30 11:19:22 [    5.942769] thermal thermal_zone3: critical temperature reached(108 C),shutting down
> [...]
> Nov 30 11:19:24 [    7.387900] ahci 4a140000.sata: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part ccc apst 
> Nov 30 11:19:24 INIT: Switching to runlevel: 0
> Nov 30 11:19:24 INIT: Sending processes the TERM signal
> 
> and there are no
> [  220.004522] reboot: Power down

Right, so things are stuck in userspace, which means the system is still
in an active runnable state.

As I mentioned (again) in my email, the issue appears to be that the 'rc'
script is stuck waiting on a FIFO.

The init daemon is trying to do an orderly shutdown.  As part of that,
it's executing the 'rc' script, which in systems I've seen, runs through
a set of scripts in the /etc/rc?.d directory in order, which normally
bring up or take down services and perform other sequenced actions.

If this script hangs (as it seems to be doing) it won't get to running
/sbin/poweroff or similar, and that means machine_power_off() won't be
called.

> In general, this kind of use case can be simulated using SysRq on any arch
> - [3.290034] Freeing unused kernel memory: 492K (c0a67000 - c0ae2000)
>   INIT: version 2.88 booting
>   Starting udev
> ^^ The issue most probably might happens when system in the process of
> loading modules
> So, once modules loading process is started - fire Sysrq "poweroff(o)"

This suggests it could be a udev issue - but without knowing what's
happening inside sysvinit's scripts, it's hard to know for certain.
Adding some debug to the 'rc' script (make sure it works without
rebooting or changing the run level, or have a way of restoring the
file if it fails to boot) so that it's possible to see what it's doing
may be a good idea - the simplest approach may be to just add

set -x

towards the top of the file - which will make it very noisy.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
