From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Thu, 10 Mar 2011 17:42:38 -0800
Message-ID: <87d3lycu0h.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51871 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753372Ab1CKBmn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 20:42:43 -0500
Received: by mail-yi0-f41.google.com with SMTP id 2so1031754yib.28
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 17:42:42 -0800 (PST)
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Thu, 10 Mar 2011 19:37:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> V2 updates:
> Rebased on latest pm-core branch and fixes below comments
> from Kevin Hilman <khilman@ti.com>. 
> - All acronym fixes
> - Use WARN_ON() instead of BUG_ON() with graceful exit.
> - Export omap4_get_base*() rather than global address pointers
> - CPUidle prepare() hook + hotplug notifier to manage C-state dynamically.
> - Dropped debugfs way of changing C-state valid flags in favor of above.
>
> Full series with cherry-picked dependencies are available on below
> git branch. 

Ignore my previous comment about these dependencies, I didn't read far
enough to see you mentioned them below, and I also found them in RMK's
devel branch.

> git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
> omap4_pm_for-next_v2
>
> This series adds OMAP4 suspend and cpuidle support till MPU subsystem
> (MPUSS) off-mode. The suspend on SMP machines uses cpu-hotplug 
> infrastructure to take down the non-boot CPUs. We put secondary
> CPU(CPU1 in OMAP4) to OFF state via cpu-hotplug.
> In cpuidle too, low power states are attempted only when the
> CPU1 is put to OFF state via cpu-hotplug because of hardware
> constraints.
>
> Timer wakeup from suspend, debug pm counters and enable_off_mode
> provisions are supported as well.
>
> Special thanks to Kevin Hilman <khilman@ti.com> for doing detail
> off-the list reviews.
>
> The patches are generated against mainline 2.6.38-rc5 and tested with
> OMAP4430 SDP and OMAP4 PANDA board. Any OMAP4 board with ES2.X silicon,
> below features should work with this series. On ES1.0, these PM 
> features are not supported.
>
> 	1. CPU hotplug (CPU is put into off-mode)
> 	2. Suspend (Both CPUs put to off-mode and MPUSS to OFF/RET)
> 	3. CPUILDE with below C-states.
> 		C1 - CPU0 ON + CPU1 ON/OFF + MPU ON + CORE ON
> 		C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON
> 		C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON
> 		C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON

This series doesn't boot on ES1 (boot log below.)  Do we need to totally
prevent WFI on ES1?  

Also, if we want a CPUidle enabled kernel to boot on all silicon, it
will need a omap_rev() check during init to ensure it doesn't override
the default idle path.


[    2.973999] VFP support v0.3: implementor 41 architecture 3 part 30 variant 0
[    2.986083] ThumbEE CPU extension supported.                                 
[    3.000183] omap2_set_init_voltage: Invalid parameters!                      
[    3.005676] omap2_set_init_voltage: Unable to put vdd_iva to its init voltage
[    3.005676]                                                                  
[    3.014831] Power Management for TI OMAP4.                                   
[    3.019256] ------------[ cut here ]------------                             
[    3.069824] WARNING: at /work/kernel/omap/pm/arch/arm/mach-omap2/omap4-mpuss)
[    3.171417] Power Management not supported on OMAP4430 ES1.0                 
[    3.179290] Modules linked in:                                               
[    3.210571] [<c0062004>] (unwind_backtrace+0x0/0xe0) from [<c0094f34>] (warn)
[    3.233947] [<c0094f34>] (warn_slowpath_common+0x4c/0x64) from [<c0094fcc>] )
[    3.257415] [<c0094fcc>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0012cc0>] (om)
[    3.343261] [<c0012cc0>] (omap4_mpuss_init+0x38/0x1a4) from [<c0012b4c>] (om)
[    3.366790] [<c0012b4c>] (omap4_pm_init+0x48/0x88) from [<c005168c>] (do_one)
[    3.444885] [<c005168c>] (do_one_initcall+0xb4/0x18c) from [<c0008b2c>] (ker)
[    3.468353] [<c0008b2c>] (kernel_init+0x150/0x218) from [<c005c1d8>] (kernel)
[    3.507385] ---[ end trace 1b75b31a2719ed1e ]---                             
[    3.546447] Failed to initialise OMAP4 MPUSS                                 
[    6.187103] clock: disabling unused clocks to save power                     
[   23.187072] BUG: spinlock lockup on CPU#0, swapper/1, c0f698e0               
[   23.193237] [<c0062004>] (unwind_backtrace+0x0/0xe0) from [<c0246e18>] (do_r)
[   23.202941] [<c0246e18>] (do_raw_spin_lock+0x130/0x14c) from [<c0086af0>] (t)
[   23.212341] [<c0086af0>] (task_rq_lock+0x40/0x78) from [<c008e390>] (try_to_)
[   23.221496] [<c008e390>] (try_to_wake_up+0x38/0x438) from [<c00ac370>] (__qu)
[   23.230804] [<c00ac370>] (__queue_work+0x34c/0x374) from [<c00ac3fc>] (queue)
[   23.239959] [<c00ac3fc>] (queue_work_on+0x34/0x44) from [<c00a9828>] (call_u)
[   23.250091] [<c00a9828>] (call_usermodehelper_exec+0xb8/0x13c) from [<c023d7)
[   23.260864] [<c023d77c>] (kobject_uevent_env+0x3b8/0x428) from [<c028bce4>] )
[   23.270446] [<c028bce4>] (device_add+0x36c/0x4fc) from [<c028bf04>] (device_)
[   23.279937] [<c028bf04>] (device_create_vargs+0x78/0xc0) from [<c028bf68>] ()
[   23.289550] [<c028bf68>] (device_create+0x1c/0x24) from [<c02891a8>] (misc_r)
[   23.298706] [<c02891a8>] (misc_register+0xc4/0x134) from [<c001c580>] (pm_qo)
[   23.308135] [<c001c580>] (pm_qos_power_init+0xc/0x64) from [<c005168c>] (do_)
[   23.317718] [<c005168c>] (do_one_initcall+0xb4/0x18c) from [<c0008b2c>] (ker)
[   23.327056] [<c0008b2c>] (kernel_init+0x150/0x218) from [<c005c1d8>] (kernel)



>
> In OMAP4 mpuss consist of dual Cortex-A9 with per-cpu local timers
> GIC(Generic Interrupt Controller), SCU(Snoop Control Unit) and PL310
> L2 cache controller and  CPU0/CPU1 LPRM modules.
> CPU0, CPU1 and MPUSS have there own power domain and hence multiple
> low power state combinations are possible. The CPU10 and CPU1
> Close switch Retention(CSWR) isn't supported by hardware.
> Based on various studies, measurements, hardware constraints
> and recommendations from hardware team, only below low power
> modes are supported on OMAP4.
> ----------------------------------------
> CPU0		CPU1		MPUSS
> ----------------------------------------
> ON		ON		ON
> OFF		OFF		CSWR
> OFF		OFF		OSWR 
> OFF		OFF		OFF
> -----------------------------------------
> Note: CPU0 is the master core and it is the last CPU to go down
> and first to wake-up when MPUSS low power states are attempted
>
> OSWR(Open Switch Retention) is not added as part of this series
> because it needs some power domain level support which isn't ready
> yet.
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38667.html
>
> Powerdomain INACTIVE support is also dropped because of its 
> inconsistency between OMAP4 and OMAP3.
> More information  on this thread -
> 	http://www.spinics.net/lists/linux-omap/msg45370.html
>
> This series has a dependency on few patches from below series.
> 	- GIC and SCU patches from [1] (queued up in RMK's for-next)
> 	- Local Timer patches from [2] (queued up in RMK's for-next)
> 	- Not clearing the static deps hack which is getting sorted out.
>
> The cpu-hotplug and suspend works with omap2plus_defconfig. Not to damage
> your file system with current omap2plus_defconfig, disable ARCH_OMAP2 so
> that V6 and V7 support is not built together with SMP.
> To tryout cpuidle, CONFIG_CPU_IDLE needs to be enabled in the build.
>
> CPU-HOTPLUG commands :
> 	offline : $echo 0 > /sys/devices/system/cpu/cpu1/online
> 	online : $echo 1 > /sys/devices/system/cpu/cpu1/online
>
> Suspend :$echo mem > /sys/power/state
>
> cpuilde : To trigger cpuidle deeper C-states on OMAP4, CPU1 needs
> 	to be offlied
> 	$echo 0 > /sys/devices/system/cpu/cpu1/online

> To see PM debug counters,
> 	$mount -t debugfs debugfs /proc/sys/debug/
> 	$cat /proc/sys/debug/pm_debug/count
> off-mode debugfs control:
> 	enable: $echo 1 > /proc/sys/debug/pm_debug/enable_off_mode
> 	disable: $echo 0 > /proc/sys/debug/pm_debug/enable_off_mode

Without enabling off-mode, I took CPU1 offline and see that it
immediatly goes off.  This makes sense based on the HW, but not in light
of the enable_off_mode flag.  For OMAP4, maybe it makes sense to not
have the enable_off_mode flag at all?   We'll be getting rid of it on
OMAP3 as soon as the constraints framework is ready, so maybe it makes
sense to just go without it for OMAP4?

More confusion: another test (also with CPUidle enabled), I see that the
MPU and DSS are also hitting off-mode:

# echo 0 > /sys/devices/system/cpu/cpu1/online
# cat /debug/pm_debug/count                                                   
cefuse_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0                       
always_on_core_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0               
l4per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0                                                                   
l3init_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0     
cam_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0       
ivahd_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0                             
mpu_pwrdm (ON),OFF:90,RET:230,INA:0,ON:321,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0                                             
cpu1_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0      
cpu0_pwrdm (ON),OFF:320,RET:0,INA:0,ON:321,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0   
tesla_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0                                                
dss_pwrdm (OFF),OFF:30,RET:0,INA:0,ON:29,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0     
abe_pwrdm (OFF),OFF:2,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0                                                                    
gfx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0       
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0,RET-MEMBANK5-OFF:0   

Kevin

