From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Wed, 30 Sep 2015 16:42:21 +0200
Message-ID: <3705422.OMk7ysE7Jn@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <1986790.syN3WBv9AR@wuerfel> <20150930141338.GC31865@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150930141338.GC31865-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 30 September 2015 09:13:38 Felipe Balbi wrote:
> On Wed, Sep 30, 2015 at 10:22:46AM +0200, Arnd Bergmann wrote:
> > On Tuesday 29 September 2015 15:43:55 Felipe Balbi wrote:
> > > 
> > > the following patches de-obfuscate arch/arm/mach-omap2/timer.c
> > > and start moving code to drivers/clocksource. So far only counter32k
> > > has been moved over.
> > > 
> > > Note that we can't get rid of all the code (yet) because there are
> > > still platforms relying to legacy boot and because of the strong
> > > coupling with OMAP's hwmod layer.
> > > 
> > > This is, for now, an RFC and has be written on top of [1]. Boot tested
> > > with AM335x and AM437x.
> > > 
> > > [1] http://marc.info/?l=linux-omap&m=144354336924308&w=2
> > 
> > Looks very nice!
> > 
> > > ps: if anybody has a good idea on how to get rid of
> > > register_persistent_clock(), please let me know
> > 
> > I don't think we want to get rid of that, because it is the more
> > accurate interface. IIRC systems that have an RTC will use
> > timekeeping_inject_sleeptime64() in rtc_resume(). I don't know however
> > how the two methods are coordinated, i.e. how the kernel ensures that
> > exactly one of the two is used, but never both.
> 
> however register_persistent_clock() is an ARM-only thing, the question
> was more towards that. Do we want to continue using the ARM-only
> register_persistent_clock() or is there a more generic version of it ?

Ah, got it.

I wouldn't worry about it at the moment, the read_persistent_clock64
interface is very rarely used: only arm, ia64, mips/lasat and s390
define it at all, only arm has more than one implementation (omap
and tegra) and the tegra, ia64 and mips implementations should really
use timekeeping_inject_sleeptime64() instead.

read_boot_clock64() is even rarer: only s390 defines it, apparently
because it is the only architecture that uses a single register for
wall-clock time and high-resolution time (it has a 96-bit
quarternanosecond register that is synchronized before booting Linux).	

TEGRA folks: the tegra_read_persistent_clock() implementation apparently
predates the Tegra RTC driver and I wonder if they actually do the
right thing in combination. Could it be that the wall time forwards
twice as fast as it should during resume when the RTC driver is loaded?
Could it be that we can simply remove  tegra_read_persistent_clock()
and the register_persistent_clock() infrastructure?

	Arnd
