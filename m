From: Tero Kristo <t-kristo@ti.com>
Subject: Re: bisected regression: arm: omap3: voltage: fix channel
 configuration
Date: Tue, 24 Jul 2012 09:28:24 +0300
Message-ID: <1343111304.30247.43.camel@sokoban>
References: <20120723210635.25e0a0d8@notabene.brown>
	 <1343053494.30247.22.camel@sokoban>
	 <20120724113057.5f38806e@notabene.brown>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60608 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab2GXG2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 02:28:31 -0400
In-Reply-To: <20120724113057.5f38806e@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Tue, 2012-07-24 at 11:30 +1000, NeilBrown wrote:
> On Mon, 23 Jul 2012 17:24:54 +0300 Tero Kristo <t-kristo@ti.com> wrote:
> 
> > Hi Neil,
> > 
> > On Mon, 2012-07-23 at 21:06 +1000, NeilBrown wrote:
> > > My GTA04 (mobile phone using OMAP3 and TWL4030 PMIC) has difficulty rebooting
> > > with 3.5.
> > > The first boot (after power on) works fine.  But when I reboot it hangs just
> > > before
> > > 
> > >   Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/800 MHz
> > > 
> > > is printed.  If I remove "mpurate=800" from the kernel command line the
> > > problem goes away.
> > > 
> > > If I boot into 3.5, which works, and then reboot into an older working kernel
> > > it freezes too.  So the 3.5 kernel leaves the device in a state which causes
> > > any kernel to hang.
> > 
> > TWL chip retains its settings over warm boot which most likely explains
> > this.
> > 
> > > 
> > > I spent a while bisecting and narrowed it down to 
> > > 
> > > commit f9d29f1617eb1b2f1fd41622bd1a0fc51658d2f0
> > > Author: Tero Kristo <t-kristo@ti.com>
> > > Date:   Mon Feb 20 12:26:06 2012 +0200
> > > 
> > >     arm: omap3: voltage: fix channel configuration
> > > 
> > > 
> > > If I revert this patch then the problem goes away.  So that is the fix I'll
> > > go with for now, but if anyone wants me to try something else to help find
> > > out what the real problem is and to find a proper fix, I'm happy to help.
> > 
> > Do you have cpufreq enabled in your build? If yes, then most likely the
> > crash occurs because cpufreq scales the used OPP to minimum after boot
> > and the warm reset doesn't switch the voltages properly and crashes as
> > it attempts to raise CPU frequency.
> 
> Yes, I have cpufreq enabled.
> CONFIG_ARCH_HAS_CPUFREQ=y
> CONFIG_ARM_OMAP2PLUS_CPUFREQ=y
> 
> Interestingly cpufreq thinks the range is 300MHz to 600MHz:
> 
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:300000 600000 

Yeah, this is the default setup for omap36xx. You can see current cpu
frequency by checking the contents of scaling_cur_freq, it is most
likely 300MHz.

> 
> where 600 is that the freq is at boot:
> 
> # dmesg | grep Cryst
> [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
> [    0.056365] Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/800 MHz
> 
> Does that mean the mpurate=800 isn't doing anything at all?

It switches it temporarily to 800MHz, maybe for a few seconds or so.

> 
> > 
> > Also, if cpufreq is enabled, mpurate command line option doesn't really
> > do much... it will just switch the frequency to the desired target
> > during beginning of boot until cpufreq kicks in and switches the OPP to
> > its own understanding of desired cpu rate. I think the handling of
> > mpurate command line option should probably be ignored in cpufreq
> > builds, or moved within the cpufreq driver.
> 
> So it looks like you are suggesting that I simply remove the "mpurate=800"
> as it isn't doing anything useful anyway.  Is that right?
> 
> Might there be some way to get it to scale higher than 600MHz?
> The first message from U-boot says:
> 
> OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> 
> and the board manufacturer thinks it should be capable of 800MHz.

You need to enable 800MHz OPP similarly to what is done in 
beagle_opp_init() in board-omap3beagle.c. I am not sure what your board
is detected as, depends on your boot loader (check /proc/cpuinfo.)

-Tero

> 
> Thanks,
> NeilBrown
> 
> 
> > 
> > I tried to craft a quick boot time fix for this problem, but it seems
> > the voltage layer is not properly initialized yet when the mpurate
> > setting kicks in and it is not very straightforward to scale voltage
> > during this time without writing a serious hack.
> > 
> > If you don't have cpufreq enabled, then the vdd routing on your board
> > might be interesting (I don't think this is the case as the kernel works
> > okay after 1st boot.)
> > 
> > -Tero
> > 
> 


