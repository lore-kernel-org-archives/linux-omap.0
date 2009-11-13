From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/9 v2] omap3: pm: introduce support for 3630 OPPs
Date: Fri, 13 Nov 2009 00:05:13 -0600
Message-ID: <1258092322-30833-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37258 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbZKMGFT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:05:19 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAD65Pkv010558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:05:25 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

Hi,
V2 of the patch series.
What changed in V2:
* Rebased to latest pm branch as of today (with zoom3 and SDP3630
  support -thanks kevin and Vikram in getting it done) 8/9 changed
* Jon Hunter pointed me to errors in vdd2 opp2 voltage that I made
  a mistake-9/9 changed
* Lam pointed me to an error in OPP enable for 3630OPP I made-
  vdd1 opp3 was disabled by default in DSP but I missed MPU :( -
  9/9 changed
* Accepted Kevin's recommendation that I rename opp_onoff to
  opp_enable 2/9 changed
* I realized that macro paramaters usage in IS_OPP_TERMINATOR,
  so made them mess up safe (2/9 changed)
* Few of the patch subjects got renamed from "introduce opp accessor
  functions" to "use accessor function" to better reflect what was
  being done.

Finally,
This series has been tested on SDP3430 and SDP3630 :) - though
not stress tested for various drivers - basic OPP changes on VDD1 &
VDD2, and cpufreq tests only. Requesting more thorough testing from
as many folks as possible. (omap3_pm_defconfig used)
NOTE: SDP3630 needs the patch for 8250 as discussed here:
http://marc.info/?l=linux-omap&m=125795354108797&w=2

I am reposting the complete rebased set as v2 to maintain continuity
on the new baseline

 ====
This patch series is based on previous discussions:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17632.html

I have modified the initial patch From Sanjeev:
http://patchwork.kernel.org/patch/50998/

Other than these, we cannot use the old VDDx_MAX based usage
anymore as 3630 OPPs are now different and runtime handling
is a must-have, hence introducing these accessor functions is not
avoidable.

The changes are incremental and tries to avoid intrusive change
as much as possible.

The OPP accessor functions introduced in this series is hopefully
a start for us to optimize this heavily used path.

Finally, I have only done limited testing of SR, as it is still in
my TODO list to revamp SR in the form of a v5 patch next time I get
some bandwidth.

An alternate approach for detecting 3630 OPP is using FEATURES
instead of detecting the cpu_type as I have implemented in this series.

Nishanth Menon (9):
  omap3: pm: introduce enabled flag to omap_opp
  omap3: pm: introduce opp accessor functions
  omap3: pm: srf: use opp accessor function
  omap3: pm: use opp accessor functions for omap-target
  omap3: pm: sr: replace get_opp with freq_to_opp
  omap3: clk: use pm accessor functions for cpufreq table
  omap3: pm: remove VDDx_MIN/MAX macros
  omap3: pm: introduce dynamic OPP
  omap3: pm: introduce 3630 opps

 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-zoom2.c          |    7 +-
 arch/arm/mach-omap2/board-zoom3.c          |    6 +-
 arch/arm/mach-omap2/clock34xx.c            |   46 +++++---
 arch/arm/mach-omap2/omap3-opp.h            |   49 ++------
 arch/arm/mach-omap2/pm.c                   |  160 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                   |    7 +
 arch/arm/mach-omap2/pm34xx.c               |  122 +++++++++++++++++++
 arch/arm/mach-omap2/resource34xx.c         |  174 +++++++++++++++++----------
 arch/arm/mach-omap2/smartreflex.c          |   36 ++-----
 arch/arm/plat-omap/cpu-omap.c              |   12 +--
 arch/arm/plat-omap/include/plat/omap-pm.h  |  111 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    5 -
 17 files changed, 584 insertions(+), 161 deletions(-)

Regards,
Nishanth Menon

PS: Sample log from 3630SDP:
 3630SDP cpufreq results:
 # head /sys/devices/system/cpu/cpu0/cpu
 /sys/devices/system/cpu/cpu0/cpufreq/  /sys/devices/system/cpu/cpu0/cpuidle/
 /tests/pm-test-scripts # head /sys/devices/system/cpu/cpu0/cpufreq/*
 ==> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus <==
 0
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq <==
 300000
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq <==
 600000
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq <==
 300000
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency <==
 300000
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus <==
 0
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies <==
 600000 300000 
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors <==
 userspace 
 
 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq <==
 300000

 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver <==
 omap

 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor <==
 userspace

 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq <==
 600000

 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq <==
 300000

 ==> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed <==
 300000

 # head /sys/devices/system/cpu/cpu0/cpufreq/stats/*
 ==> /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state <==
 600000 9246
 300000 159753

 ==> /sys/devices/system/cpu/cpu0/cpufreq/stats/total_trans <==
 13
 [..]
 /dbg/pm_debug# cat voltage_off_while_idle 
 0
 /dbg/pm_debug # cat enable_off_mode 
 0
 /dbg/pm_debug # echo -n '1' >enable_off_mode 
 Unable to Changelevel for resource dsp_freq to 0
 Error: could not refresh resources
 /dbg/pm_debug # echo -n '1' >voltage_off_while_idle 
 /dbg/pm_debug # cat enable_off_mode 
 1
 /dbg/pm_debug # echo 'mem' >/sys/power/state 
 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.00 seconds) done.
 Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
 Suspending console(s) (use no_console_suspend to debug)
 Successfully put all powerdomains to target state
 Restarting tasks ... done.
 /dbg/pm_debug # 
 /dbg/pm_debug # echo 'mem' >/sys/power/state 
 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.00 seconds) done.
 Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
 Suspending console(s) (use no_console_suspend to debug)
 Successfully put all powerdomains to target state
 Restarting tasks ... done.
 /dbg/pm_debug # 
 /dbg/pm_debug # 
 /dbg/pm_debug # ls
 cam_pwrdm               iva2_pwrdm              sleep_while_idle
 core_pwrdm              mpu_pwrdm               time
 count                   neon_pwrdm              usbhost_pwrdm
 dss_pwrdm               per_pwrdm               voltage_off_while_idle
 emu_pwrdm               registers               wakeup_timer_seconds
 enable_off_mode         sgx_pwrdm               wkup_pwrdm
 /dbg/pm_debug # cat count time
 usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
 sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
 per_pwrdm (ON),OFF:2,RET:143,INA:0,ON:146
 dss_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
 cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
 core_pwrdm (ON),OFF:2,RET:1,INA:0,ON:4
 neon_pwrdm (ON),OFF:2,RET:1,INA:190,ON:194
 mpu_pwrdm (ON),OFF:2,RET:1,INA:190,ON:194
 iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
 per_clkdm->per_pwrdm (9)
 usbhost_clkdm->usbhost_pwrdm (0)
 cam_clkdm->cam_pwrdm (0)
 dss_clkdm->dss_pwrdm (0)
 core_l4_clkdm->core_pwrdm (5)
 core_l3_clkdm->core_pwrdm (4)
 d2d_clkdm->core_pwrdm (0)
 sgx_clkdm->sgx_pwrdm (0)
 iva2_clkdm->iva2_pwrdm (0)
 neon_clkdm->neon_pwrdm (0)
 mpu_clkdm->mpu_pwrdm (0)
 prm_clkdm->wkup_pwrdm (0)
 cm_clkdm->core_pwrdm (0)
 usbhost_pwrdm (OFF),OFF:47586242676,RET:150255279541,INA:0,ON:22111267089
 sgx_pwrdm (OFF),OFF:197841491699,RET:0,INA:0,ON:22111297607
 per_pwrdm (ON),OFF:4080291748,RET:5557220473,INA:0,ON:210315277085
 dss_pwrdm (OFF),OFF:47586303711,RET:150255249024,INA:0,ON:22111267089
 cam_pwrdm (OFF),OFF:47586303711,RET:150255249024,INA:0,ON:22111267089
 core_pwrdm (ON),OFF:4080291748,RET:2764923095,INA:0,ON:213107604981
 neon_pwrdm (ON),OFF:4080291748,RET:2764923095,INA:5508361840,ON:207599273658
 mpu_pwrdm (ON),OFF:4080291748,RET:2764923095,INA:5508972194,ON:207598663304
 iva2_pwrdm (OFF),OFF:47586364746,RET:150255187988,INA:0,ON:22111297607
 /dbg/pm_debug # 

