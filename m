From: Tero Kristo <t-kristo@ti.com>
Subject: Re: bisected regression: arm: omap3: voltage: fix channel
 configuration
Date: Wed, 25 Jul 2012 10:52:49 +0300
Message-ID: <1343202769.30247.73.camel@sokoban>
References: <20120723210635.25e0a0d8@notabene.brown>
	 <1343053494.30247.22.camel@sokoban>
	 <20120724113057.5f38806e@notabene.brown>
	 <1343111304.30247.43.camel@sokoban>
	 <20120724173453.01078466@notabene.brown>
	 <1343119876.30247.49.camel@sokoban>
	 <20120725114742.30e25e31@notabene.brown>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49867 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656Ab2GYHw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 03:52:57 -0400
In-Reply-To: <20120725114742.30e25e31@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Wed, 2012-07-25 at 11:47 +1000, NeilBrown wrote:
> On Tue, 24 Jul 2012 11:51:16 +0300 Tero Kristo <t-kristo@ti.com> wrote:
> 
> > On Tue, 2012-07-24 at 17:34 +1000, NeilBrown wrote:
> > > On Tue, 24 Jul 2012 09:28:24 +0300 Tero Kristo <t-kristo@ti.com> wrote:
> > > 
> > > > On Tue, 2012-07-24 at 11:30 +1000, NeilBrown wrote:
> > > 
> > > > > Might there be some way to get it to scale higher than 600MHz?
> > > > > The first message from U-boot says:
> > > > > 
> > > > > OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> > > > > 
> > > > > and the board manufacturer thinks it should be capable of 800MHz.
> > > > 
> > > > You need to enable 800MHz OPP similarly to what is done in 
> > > > beagle_opp_init() in board-omap3beagle.c. I am not sure what your board
> > > > is detected as, depends on your boot loader (check /proc/cpuinfo.)
> > > 
> > > Thanks!
> > > Yes, my board identifies as cpu_is_omap3630() so that code looks relevant.
> > > I copied the opp_init across to my board file, it runs without complaining
> > > but it now gets to
> > > 
> > > [ ok ] Loading cpufreq kernel modules...done (none).
> > > [....] CPUFreq Utilities: Setting ondemand CPUFreq governor...CPU0...
> > > 
> > > 
> > > and hangs.  magic SYSRQ doesn't respond.
> > > 
> > > Any hints?
> > 
> > You only enabled opp for 800MHz right? I am just wondering if the
> > voltage levels for mpu / core opps are correct for your board... You may
> > want to check the opp tables against the information provided by your
> > board manufacturer. The trace about cpufreq enabling ondemand governor
> > indicates it is switching to frequency throttling mode at that point, so
> > it most likely tries to raise MPU frequency to 800MHz (CPU load is
> > pretty high during boot.) You can try adding some trace to cpufreq
> > driver itself to see what is happening.
> 
> Yes, just 800MHz.  I just copied the code from board-omap3beagle.c, so
> it is actually 800MHz for MPU and 660MHz for IVA.
> 
> I tried running with that and with your patch reverted and it works
> perfectly.  I even get 33% better speed on CPU-intensive workloads, so it
> really is running at 800MHz.

Okay, so it just points to voltage control somehow. Are you using IVA
btw? I think current kernel doesn't work too well with the combination
of IVA + cpufreq, as I don't think we have devfreq support in place for
IVA, and the voltages used by these two is shared. If cpufreq decides
that it wants to go to a low OPP, it will also drop the voltages for
both and this might cause an issue.

> 
> > 
> > Another thing to verify would be to check the voltage rails on your
> > board schematics to see how the supply voltages are delivered.
> 
> I have a basic understanding of the schematics, but I don't really know what
> to look for when it comes to power routing.
> If you happen to have time and interest, the schematics are in the manual
> that can be downloaded from 
> 
>     http://projects.goldelico.com/p/gta04-main/downloads/
> 
> I've got the GTA04A3, so GTA04A3-1-complete.pdf is the one you want.

It seems the power routing should be okay, so don't really know whats
the problem here. There seems to be test pads for VDD1 and VDD2 voltages
in the device, so it would be good if you have possibility to measure
these in a working / non-working case and see what kind of voltage
levels you see there. Just be careful not to connect anything strange on
these test points as they are going directly to omap power supplies.

The situations to measure would be:

- working case with old kernel after boot (idle)
- working case with new kernel after boot (idle)
- hanged case with new kernel

You should see voltages between 1v...1.4v for vdd1 (mpu), and
0.9v...1.2v for vdd2 (core). You can also measure the voltage levels
with different cpufreq OPPs to see what it does (set the
scaling_min_freq for the cpufreq under sysfs, or use userspace governor
and just force a specific OPP.) If you are uncomfortable measuring the
voltages, just try the different OPPs with SW and see if you can figure
out which one is causing problems... or whether it is just a single
transition that kills it.

-Tero


