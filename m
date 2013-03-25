From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 00/18] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle
 support
Date: Mon, 25 Mar 2013 17:16:59 +0530
Message-ID: <51503933.9060106@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45699 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025Ab3CYLrK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 07:47:10 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Hi Santosh,

On Monday 25 March 2013 03:34 PM, Santosh Shilimkar wrote:
> Kevin,
>
> Here is the refreshed version(v2) of the OMAP5 PM suspport which was posted
> earlier (March 1st 2013). Patch-set incorporates comments from Nishant
> Menon (Thanks for review NM) and his acked-by tags. I would like to get this
> queued for 3.10 merge window if you are ok with the series.
>
> Series is built on top of my pull requests [1] [2] [3] sent to Tony and your
> 'for_3.10/pm/cleanup' branch. For testing, I have created a branch [4]
> which put together all the needed dependencies, fixes which should make it
> to 3.10 merge window.
>
> Series adds OMAP5 MPUSS power management support for system wide suspend
> and CPUidle. Its heavy re-use from OMAP4 and hence only ~400 odd lines are
> needed to add OMAP5 PM support on top of existing OMAP4 PM support.
>
> OMAP5 adds a mercury retention feature which is an enhancement of
> existing retention feature to reduce the leakage. No change in
> programming model except one time enabling of mercury retention
> during init.
>
> One more notable change in OMAP5 vs OMAP4 devices, CPUx power domains
> support retention state which lets you hit MPUSS and Core retention with
> very low latency C-states.
>
> Tested on OMAP4430 SDP, OMAP4460 Panda, OMAP5430 SDP and OMAP5432 Panda
> devices with suspend and CPUIdle. Rootfs is mounted over ramdisk since
> the mmc and nfs based fs needs DMA engine patches. For suspend wakeup,
> I used Sourav's couple of serial wakeup wip patches from the lists.

I did the following build tests on [1]:
	-> Native omap2plus build
	-> Omap2 only build
	-> Omap3 only build
	-> Omap4 only build
	-> Omap5 only build
	-> AM33XX only build.
	-> omap1_defconfig

And also did functional testing on [2] where omap5_pm branch[1] is merged.
	On OMAP5430 EVM: 	Suspend to RAM (UART wakeup)
			 			CPU_IDLE
	On OMAP4430 SDP: 	Suspend to RAM (UART wakeup)
			 			CPU_IDLE
Note:
1) Disabled SMP for doing build test on Omap2/3 only builds.
2) If we enable CPU_IDLE on OMAP4430, debug message flood from 
reset_ctrl_regs() will appear.
	As this is already disussed and a patch is already sent on Mainline
	Will get more info on this here[3]

Tested-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and Regards,
Lokesh

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux 
for_3.10/omap5_pm
[2] git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git 
testing/3.10/omap5_int
[3] https://lkml.org/lkml/2013/3/13/50

>
> The following changes since commit 9981cde24de52e5bb9a7cd918d1e54de241f85c9:
>
>    Merge branch 'for_3.10/omap5_data_files' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into for_3.10/omap5_pm (2013-03-25 12:29:34 +0530)
>
> are available in the git repository at:
>
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap5_pm
>
> for you to fetch changes up to 75bd846d3103da858a208fe07127151903d1f608:
>
>    ARM: OMAP5: PM: handle device instance for warm reset (2013-03-25 12:37:44 +0530)
>
> ----------------------------------------------------------------
> Nishanth Menon (1):
>    ARM: OMAP5: PM: handle device instance for warm reset
>
> Santosh Shilimkar (17):
>    ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
>    ARM: OMAP5: PM: Update CPU context register offset
>    ARM: OMAP4+: PM: Consolidate and use OMAP4 PM code for OMAP5
>    ARM: OMAP5: PM: Set MPUSS-EMIF clock-domain static dependency
>    ARM: OMAP5: PM: Enables ES2 PM mode by default
>    ARM: OMAP5: PM: Enable Mercury retention mode on CPUx powerdomains
>    ARM: OMAP5: Add init_late() hook to enable pm initialization
>    ARM: OMAP5: PM: Add CPU power off in hotplug path
>    ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force
>      wakeup method
>    ARM: OMAP5: PM: Add MPU Open Switch Retention support
>    ARM: OMAP5: PM: Add L2 memory power down support
>    ARM: OMAP4: CPUidle: Avoid double idle driver registration
>    ARM: OMAP: CPUidle: Unregister drivere on device registration failure
>    ARM: OMAP4: CPUidle: Make C-state description field more precise
>    ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support
>    ARM: OMAP4+: CPUidle: Deprecate use of
>      omap4_mpuss_read_prev_context_state()
>    ARM: OMAP4+: CPUidle: Add OMAP5 idle driver support
>
>   arch/arm/mach-omap2/Kconfig                        |    1 +
>   arch/arm/mach-omap2/Makefile                       |   12 +-
>   arch/arm/mach-omap2/board-generic.c                |    1 +
>   arch/arm/mach-omap2/common.h                       |    8 +-
>   arch/arm/mach-omap2/cpuidle34xx.c                  |    6 +-
>   .../{cpuidle44xx.c => cpuidle_omap4plus.c}         |  151 ++++++++++++++++---
>   arch/arm/mach-omap2/io.c                           |    8 +
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  155 +++++++++++++++-----
>   arch/arm/mach-omap2/omap-secure.h                  |    9 ++
>   arch/arm/mach-omap2/omap-smp.c                     |   12 +-
>   arch/arm/mach-omap2/omap-wakeupgen.c               |   30 +++-
>   arch/arm/mach-omap2/omap-wakeupgen.h               |    1 +
>   arch/arm/mach-omap2/omap4-sar-layout.h             |    2 +
>   arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   90 ++++++++++--
>   arch/arm/mach-omap2/prminst44xx.c                  |   10 +-
>   .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |  106 +++++++++++++
>   16 files changed, 512 insertions(+), 90 deletions(-)
>   rename arch/arm/mach-omap2/{cpuidle44xx.c => cpuidle_omap4plus.c} (58%)
>   rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (74%)
>   rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (77%)
>

