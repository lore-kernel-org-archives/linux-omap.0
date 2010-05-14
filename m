From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 14:02:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141154330.3348@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005032318.35383.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org


Hi,

On Mon, 3 May 2010, Rafael J. Wysocki wrote:

> However, the real question is whether or not the opportunistic suspend 
> feature is worth adding to the kernel as such and I think it is.
> 
> To me, it doesn't duplicate the runtime PM framework which is aimed at 
> the power management of individual devices rather than the system as a 
> whole.

Runtime PM is also aimed at system power management as a whole. The 
difference is that it approaches the problem from the bottom up (i.e., the 
activity level of the actual hardware devices) rather than from the top 
down (i.e., "echo mem > /sys/power/state").

In bottom-up approaches, like runtime PM, system-level power management 
becomes a very small fraction of the total power management problem.  It 
is only possible to power down that small fraction once all devices, and 
the clock and power domains/islands that contain those devices, become 
idle.  ("Devices" here is used in a hardware sense, and thus includes the 
CPU.)

A bottom-up approach like runtime PM allows parts of the system can be 
powered off when they are not in use.  This is important on systems that 
have more levels of power management hierarchy than just "device" and 
"system," as is the case on modern SoCs like Renesas SH-Mobile, Intel 
Moorestown[1], and TI OMAP[2].  These chips group devices into sets of 
multiple power domains/islands, which can be controlled independently.

Once the devices, including the CPU, are idle, the system idle loop can be 
entered to determine what power level the system should be programmed to 
enter.  At this point, system-level power management only controls a small 
fraction, maybe 1% or 2%, of the chipset that is not associated with any 
devices; along with any board-level resources that the chipset depends on 
to function that are power-controllable, such as the system high-frequency 
clock oscillator[3].

No heavyweight process of iterating through the device tree to suspend 
them is needed at this point, as with a top-down power management approach 
like Android opportunistic suspend, since the system already knows that 
the devices are idle.

Of course, to determine what system-level power state to enter, there 
needs to be some sort of governor to handle these system-level power 
decisions.  On mainline Linux OMAP, we use the CPUIdle governor to do 
this[4].  This is not the cleanest possible choice[5], but works pretty 
well in the absence of a system-level governor.

The Linux OMAP CPUIdle code considers the next timer expiration and any PM 
constraints[6].  Based on the required wakeup latency and constraints, the 
PM code[7][8] programs the power-controllable parts of the system to enter 
one of several power states.  The CPU then enters WFI (wait-for-interrupt, 
like x86 HLT), and the SoC power management controller implements the 
system power transition, now that all on-chip devices are idle.

All of this is already implemented in mainline Linux code[9].  Devices 
based on this code have already shipped from multiple 
vendors[10][11][12][13]. These devices have small batteries and long 
use-times, which attests to the performance of this approach.

Since this approach does not "echo mem > /sys/power/state", it honors the 
existing Linux timer and scheduler subsystems, and so this is all possible 
without systemic modification of the kernel code tree or device drivers, 
in contrast to the current Android proposal under consideration.



- Paul


1. Jacob Pan's presentation at ELC 2010, "Porting the Linux Kernel to x86 
   MID Platforms": 
   http://elinux.org/images/e/ee/Jacob-Pan-x86MID-elc2010.pdf

2. OMAP35x Technical Reference Manual Rev. F, Figure 4-16 "Device Power 
   Domains": http://www.ti.com/litv/pdf/spruf98f

3. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu, 13
   May 2010 13:01:33 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18592

4. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/cpuidle34xx.c;h=3d3d035db9aff62ce522e0080e570cfdbf8e70cc;hb=4462dc02842698f173f518c1f5ce79c0fb89395a#l292

5. Paul Walmsley E-mail to the linux-pm mailing list, dated Thu, 13
   May 2010 13:01:33 -0600:
   http://permalink.gmane.org/gmane.linux.power-management.general/18592

6. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/omap-pm.h;h=3ee41d7114929d771cadbb9f02191fd16c5b5abe;hb=4fc4c3ce0dc1096cbd0daa3fe8f6905cbec2b87e

7. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/pm24xx.c;h=374299ea7aded92999b5e54439e43f017806ce4d;hb=4fc4c3ce0dc1096cbd0daa3fe8f6905cbec2b87e

8. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/pm34xx.c;h=ea0000bc5358e196df58e88da3f54dd71f0a4706;hb=4fc4c3ce0dc1096cbd0daa3fe8f6905cbec2b87e

9. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/arm/mach-omap2;hb=4fc4c3ce0dc1096cbd0daa3fe8f6905cbec2b87e

10. http://en.wikipedia.org/wiki/Palm_Pre

11. http://en.wikipedia.org/wiki/N800

12. http://en.wikipedia.org/wiki/N810

13. http://en.wikipedia.org/wiki/N900
