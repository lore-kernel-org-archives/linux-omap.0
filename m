From: Tero Kristo <t-kristo@ti.com>
Subject: Re: bisected regression: arm: omap3: voltage: fix channel
 configuration
Date: Tue, 24 Jul 2012 11:51:16 +0300
Message-ID: <1343119876.30247.49.camel@sokoban>
References: <20120723210635.25e0a0d8@notabene.brown>
	 <1343053494.30247.22.camel@sokoban>
	 <20120724113057.5f38806e@notabene.brown>
	 <1343111304.30247.43.camel@sokoban>
	 <20120724173453.01078466@notabene.brown>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42025 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab2GXIvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 04:51:21 -0400
In-Reply-To: <20120724173453.01078466@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, 2012-07-24 at 17:34 +1000, NeilBrown wrote:
> On Tue, 24 Jul 2012 09:28:24 +0300 Tero Kristo <t-kristo@ti.com> wrote:
> 
> > On Tue, 2012-07-24 at 11:30 +1000, NeilBrown wrote:
> 
> > > Might there be some way to get it to scale higher than 600MHz?
> > > The first message from U-boot says:
> > > 
> > > OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> > > 
> > > and the board manufacturer thinks it should be capable of 800MHz.
> > 
> > You need to enable 800MHz OPP similarly to what is done in 
> > beagle_opp_init() in board-omap3beagle.c. I am not sure what your board
> > is detected as, depends on your boot loader (check /proc/cpuinfo.)
> 
> Thanks!
> Yes, my board identifies as cpu_is_omap3630() so that code looks relevant.
> I copied the opp_init across to my board file, it runs without complaining
> but it now gets to
> 
> [ ok ] Loading cpufreq kernel modules...done (none).
> [....] CPUFreq Utilities: Setting ondemand CPUFreq governor...CPU0...
> 
> 
> and hangs.  magic SYSRQ doesn't respond.
> 
> Any hints?

You only enabled opp for 800MHz right? I am just wondering if the
voltage levels for mpu / core opps are correct for your board... You may
want to check the opp tables against the information provided by your
board manufacturer. The trace about cpufreq enabling ondemand governor
indicates it is switching to frequency throttling mode at that point, so
it most likely tries to raise MPU frequency to 800MHz (CPU load is
pretty high during boot.) You can try adding some trace to cpufreq
driver itself to see what is happening.

Another thing to verify would be to check the voltage rails on your
board schematics to see how the supply voltages are delivered.

-Tero

> 
> Thanks,
> NeilBrown
> 
> 
> #
> # CPU Power Management
> #
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_STAT_DETAILS=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> 
> #
> # ARM CPU frequency scaling drivers
> #
> CONFIG_ARM_OMAP2PLUS_CPUFREQ=y
> # CONFIG_ARM_EXYNOS4210_CPUFREQ is not set
> # CONFIG_ARM_EXYNOS4X12_CPUFREQ is not set
> # CONFIG_ARM_EXYNOS5250_CPUFREQ is not set
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y


