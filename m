From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Fri, 16 Jan 2009 11:03:27 -0800
Message-ID: <87fxjj845c.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EA9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:60362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491AbZAPTDk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 14:03:40 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1693985rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 11:03:39 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EA9@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 16 Jan 2009 19\:19\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> I did some testing today on my 3.0GP 3430SDP. This is with the omap_3430sdp_min_defconfig.
>
> 1) Idle.
> echo -n 1 > /sys/power/clocks_off_while_idle
> echo -n 1 > /sys/power/enable_off
> Could not hit RET. something seems to be still active. Not sure if it could be something
> to do with this error that's thrown while bootup
>
> <6>Disabling unused clock "dpll5_ck"
> Disabling unused clock "dpll5_ck"
> <3>clock: dpll5_ck failed transition to 'locked'
> clock: dpll5_ck failed transition to 'locked'

This is the same results I see on my SDP.

Looking at the registers, I am pretty sure it is the D2D clockdomain
that still has activity, but due to very poor Stacked-mode docs and no
responses to the D2D questions asked to TI I have not been able to
figure this one out.

Help debugging this would be greatly appreciated.

> Further doing a 
> echo -n 1 > /sys/power/sleep_while_idle causes a hang after the 5 odd secs
> of UART inactivity.
> Is'nt this option supposed to affect only the suspend path behavior?

No, this affects the common idle loop, with and without CPUidle.

> Is CPUidle disabled in the default defconfig now?
>
> 2) Suspend
> echo -n 1 > /sys/power/clocks_off_while_idle
> Hangs on a echo mem > /sys/power/state
> Goes into suspend, but cannot recover

I'm pretty sure all the hangs going into RET are related.

Kevin

> 3) DVFS
> Both VDD1 and VDD2 DVFS seem to function fine.
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Wednesday, January 14, 2009 3:22 AM
>> To: linux-omap@vger.kernel.org
>> Subject: new PM branch available
>> 
>> Hello,
>> 
>> The latest PM branch is now available[1].
>> 
>> I've done basic testing of retention and off-mode (suspend and dynamic
>> idle) on Beagle and custom HW.  My SDP has something still keeping
>> CORE active that others have not seen, but I have yet to debug.  Any
>> other reports from SDP testing would be appreciated.
>> 
>> Notable changes/updates
>> - rebased on latest clock updates and fixes from Paul
>> - clockfw pre- and post- notifiers
>> - DVFS for VDD2
>> 
>> Full git shortlog below[2]
>> 
>> Enjoy,
>> 
>> Kevin
>> 
>> [1] See branch 'pm' in my git repo:
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-om
>> ap-pm.git
>> which is also mirrored as the branch 'pm' of the normal linux-omap
>> repo (but will not sync until 03:30 GMT)
>> 
>> 
>> [2] git shortlog:
>> 
>> Carlos Chinea (1):
>>       OMAP3:PM: Update SSI omapdev record
>> 
>> Jouni Hogander (5):
>>       OMAP3: PM: Use pwrdm_set_next_pwrst instead of 
>> set_pwrdm_state in idle loop
>>       OMAP3: PM: Fix wrong sequence in suspend.
>>       OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
>>       OMAP: PM: Build fails if PM is not enabled
>>       OMAP2: PM: Fix omap2 build
>> 
>> Kalle Jokiniemi (3):
>>       OMAP: PM: sysfs interface for enabling voltage off in idle
>>       OMAP3: PM: Fix cpu idle init sequencing
>>       OMAP: SRF: Fixes to shared resource framework (Ver.3)
>> 
>> Kevin Hilman (4):
>>       OMAP3: PM: CPUidle: obey enable_off_mode flag
>>       OMAP3: PM: CPUidle: restrict C-states on UART activity
>>       OMAP3: PM: decouple PER and CORE context save and restore
>>       OMAP2/3: PM: system_rev -> omap_rev()
>> 
>> Paul Walmsley (29):
>>       OMAP2/3 clock: implement clock notifier infrastructure
>>       OMAP clock: add notifier infrastructure
>>       OMAP2/3 clock: store planned clock rates into temporary 
>> rate storage
>>       OMAP2/3 clock: add clk post-rate-change notifiers
>>       OMAP2/3 clock: add clock pre-rate-change notification
>>       OMAP2/3 clock: add clock prepare-rate-change notifications
>>       OMAP2/3 clock: add clock abort-rate-change notifications
>>       OMAP2/3 PM: create the OMAP PM interface and add a 
>> default OMAP PM no-op layer.
>>       OMAP2/3 omapdev: add basic omapdev structure
>>       OMAP242x omapdev: add OMAP242x omapdev records
>>       OMAP243x omapdev: add OMAP243x omapdev records
>>       OMAP3xxx omapdev: add OMAP3xxx omapdev records
>>       OMAP2/3 omapdev: add code to walk the omapdev records
>>       ARM: MMU: add a Non-cacheable Normal executable memory type
>>       OMAP3 SRAM: mark OCM RAM as Non-cacheable Normal memory
>>       OMAP3 SRAM: add ARM barriers to omap3_sram_configure_core_dpll
>>       OMAP3 clock: add interconnect barriers to CORE DPLL M2 change
>>       OMAP3 SRAM: clear the SDRC PWRENA bit during SDRC 
>> frequency change
>>       OMAP3 SDRC: Add 166MHz, 83MHz SDRC settings for the BeagleBoard
>>       OMAP3 SDRC: initialize SDRC_POWER at boot
>>       OMAP3 SRAM: renumber registers to make space for 
>> argument passing
>>       OMAP3 clock: only unlock SDRC DLL if SDRC clk < 83MHz
>>       OMAP3 clock: use pr_debug() rather than pr_info() in 
>> some clock change code
>>       OMAP3 clock: remove wait for DPLL3 M2 clock to stabilize
>>       OMAP3 clock: initialize SDRC timings at kernel start
>>       OMAP3 clock: add a short delay when lowering CORE clk rate
>>       OMAP3 clock/SDRC: program SDRC_MR register during SDRC 
>> clock change
>>       OMAP3 SRAM: add more comments on the SRAM code
>>       OMAP3 SRAM: convert SRAM code to use macros rather than 
>> magic numbers
>> 
>> Peter 'p2' De Schrijver (12):
>>       OMAP: PM counter infrastructure.
>>       OMAP: PM: Hook into PM counters
>>       OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
>>       OMAP: PM: Add pm-debug counters
>>       OMAP: PM debug: make powerdomains use PM-debug counters
>>       OMAP: PM: Add definitions for ETK pads and 
>> observability registers
>>       OMAP: Debug observability and ETK padconf implementation
>>       OMAP: Add debug observablity (debobs) Kconfig item
>>       OMAP: PM: Implement get_last_off_on_transaction_id()
>>       Save sram context after changing MPU, DSP or core clocks
>>       Fix omap_getspeed.
>>       Make sure omap cpufreq driver initializes after cpufreq 
>> framework and governors
>> 
>> Rajendra Nayak (35):
>>       OMAP3: PM: GPMC context save/restore
>>       OMAP3: PM: GPIO context save/restore
>>       OMAP3: PM: I2C context save/restore
>>       OMAP3: PM: INTC context save/restore
>>       OMAP3: PM: PRCM context save/restore
>>       OMAP3: PM: Populate scratchpad contents
>>       OMAP3: PM: SCM context save/restore
>>       OMAP3: PM: SRAM restore function
>>       OMAP3: PM: handle PER/NEON/CORE in idle
>>       OMAP3: PM: Restore MMU table entry
>>       OMAP3: PM: MPU off-mode support
>>       OMAP3: PM: CORE domain off-mode support
>>       OMAP3: PM: allow runtime enable/disable of OFF mode
>>       OMAP3: 3430SDP minimal kernel defconfig
>>       OMAP3: PM: CPUidle: Basic support for C1-C2
>>       OMAP3: PM: CPUidle: Enables state C4
>>       OMAP3: PM: CPUidle: Enables C3 and C5
>>       OMAP3: PM: CPUidle: Safe-state on bm-activity
>>       OMAP3 SRF: Generic shared resource f/w
>>       OMAP3 SRF: MPU/CORE/PD latency modeling
>>       OMAP3 SRF: omap3 srf driver
>>       OMAP3 SRF: OMAP PM srf implementation
>>       OMAP3 SRF: Add CORE rate table param in OMAP-PM
>>       OMAP3 SRF: Add VDD1/VDD2 rate tables for 3430SDP
>>       OMAP3 SRF: Add virt clk nodes for VDD1/VDD2
>>       OMAP3 SRF: Adds OPP/Freq res's in SRF
>>       OMAP3 SRF: Update OMAP-PM layer
>>       OMAP3 SRF: Voltage scaling support
>>       OMAP3 SRF: VDD2 scaling support
>>       OMAP3 SRF: Adds sysfs control for VDD1/VDD2 OPP's
>>       OMAP3 PM: Replace spinlocks with mutex in SRF
>>       OMAP3 PM: CPUFreq driver for OMAP3
>>       OMAP3 PM: Update the min defconfig for 3430sdp
>>       OMAP3 SRF: Fix crash on non-3430SDP platforms with DVFS/CPUFreq
>>       OMAP3: PM: Scale VDD2 OPP for VDD1 OPP3 and higher
>> 
>> Tero Kristo (26):
>>       OMAP: PM debug: do not print out status for meta 
>> powerdomains (dpll*)
>>       OMAP: PM debug: Add PRCM register dump support
>>       OMAP: PM: DMA context save / restore
>>       OMAP: PM: off-mode support for DMA on EMU/HS devices
>>       OMAP3: SRAM size fix for HS/EMU devices
>>       OMAP3 PM: off-mode support for HS/EMU devices
>>       OMAP3: PM: Enable SDRAM auto-refresh during sleep
>>       OMAP: SDRC: Add new register definitions for SDRAM controller
>>       OMAP3: PM: SDRC auto-refresh workaround for off-mode
>>       PM: Added three PLL registers to the PRCM context save
>>       PM: Changed secure RAM storage size from 0x8000 to 0x803F
>>       PM: Added suspend target state control to debugfs for OMAP3
>>       OMAP3: PM: Prevent PER from going OFF when CORE is going INA
>>       PM OMAP3: Change omap3_save_secure_ram to be called 
>> only during init
>>       OMAP3: PM: MPU and CORE should stay awake if there is 
>> CAM domain ACTIVE
>>       OMAP3: GPIO fixes for off-mode
>>       PM: OMAP3: Refreshed DVFS VDD1 control against latest clock fw
>>       OMAP3: Add support for DPLL3 divisor values higher than 2
>>       OMAP3: PM: Fixed VDD2 control to work from both sysfs 
>> and SRF API
>>       OMAP3: PM: Added DVFS OPP locking interface for VDD1 and VDD2
>>       OMAP3: Fix rate calculation bug in omap3_select_table_rate
>>       OMAP3: PM: Prevented DVFS state switches when enabling off-mode
>>       OMAP3: PM: Enable VDD2 OPP1
>>       OMAP3: PM: Fix linker error without CONFIG_PM option
>>       PM: OMAP3: Removed a couple of unused variables from DVFS code
>>       PM: OMAP3: Added support for possibly failing 
>> clk_set_rate to DVFS
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
