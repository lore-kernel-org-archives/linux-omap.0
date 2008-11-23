From: "Sriram V" <vshrirama@gmail.com>
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Sun, 23 Nov 2008 13:27:42 +0530
Message-ID: <8bf247760811222357t45c25113ncfe6874b149651d5@mail.gmail.com>
References: <87d4grdxqh.fsf@deeprootsystems.com>
	 <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
	 <87r656b8js.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B6D59577@dbde02.ent.ti.com>
	 <87ljvd6p3u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:44387 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbYKWH5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Nov 2008 02:57:46 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1788901fkq.5
        for <linux-omap@vger.kernel.org>; Sat, 22 Nov 2008 23:57:42 -0800 (PST)
In-Reply-To: <87ljvd6p3u.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Reid <ppeter.reid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

On Fri, Nov 21, 2008 at 9:35 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Premi, Sanjeev" <premi@ti.com> writes:
>
>>> -----Original Message-----
>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>> Sent: Thursday, November 20, 2008 11:10 PM
>>> To: Premi, Sanjeev
>>> Cc: Peter Reid; linux-omap@vger.kernel.org
>>> Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
>>>
>>> "Premi, Sanjeev" <premi@ti.com> writes:
>>>
>>> > These are my observations on OMAP3EVM:
>>> >
>>> > 1) Very frequently I see these messages:
>>> >
>>> > <4>__ratelimit: 6736 callbacks suppressed
>>> > __ratelimit: 6736 callbacks suppressed <3>omapfb omapfb: irq error
>>> > status 00c2 omapfb omapfb: irq error status 00c2 <3>omapfb
>>> omapfb: irq
>>> > error status 0060 omapfb omapfb: irq error status 0060 <3>omapfb
>>> > omapfb: irq error status 00c2 omapfb omapfb: irq error status 00c2
>>> > <3>omapfb omapfb: irq error status 0060 omapfb omapfb: irq error
>>> > status 0060 <3>omapfb omapfb: irq error status 00e2 omapfb
>>> omapfb: irq
>>> > error status 00e2 <3>omapfb omapfb: irq error status 00c2 omapfb
>>> > omapfb: irq error status 00c2 <3>omapfb omapfb: irq error
>>> status 0060
>>> > omapfb omapfb: irq error status 0060 <3>omapfb omapfb: irq error
>>> > status 00e2 omapfb omapfb: irq error status 00e2 <3>omapfb
>>> omapfb: irq
>>> > error status 00c2 omapfb omapfb: irq error status 00c2 <3>omapfb
>>> > omapfb: irq error status 0060 omapfb omapfb: irq error status 0060
>>>
>>> Sanjeev,
>>>
>>> For starters can you try with a minimal kernel (no drivers,
>>> no framebuffer, etc.)
>>>
>>> The first goal is to hit retention and off with no drivers
>>> than start moving out to address driver issues from there.
>>>
>>> Kevin
>>>
>>
>> Here is what I was able to see with the minimal config (attached).
>>
>> [root@OMAP3EVM /]# echo mem > /sys/power/state
>> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
>> done.
>> Freezing user space processes ... Freezing user space processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>> done.
>> Freezing remaining freezable tasks ... Freezing remaining freezable tasks ... (elapsed 0.01 seconds) (elapsed 0.01 seconds) done.done.
>>
>> Suspending console(s) (use no_console_suspend to debug)
>> Suspending console(s) (use no_console_suspend to debug)
>>
>> <snip>un-printable characters<snip>
>>
>> Powerdomain (per_pwrdm) didn't enter target state 1
>> Could not enter target state in pm_suspend
>> Restarting tasks ... Restarting tasks ... done.
>> done.
>
> This is what I see on Beagle as well (PER is not entering retention.)
>

> At this point, the current PM debug code doesn't help further in
> determining exactly why a powerdomain did not hit its target state.
> Some device in the domain may still have its clocks enabled, or its
> idle state not set correctly.  Or, a given module may have been
> initialized by the bootloader in a way which prevents it from going
> idle.
>

  True. I have observed on omap3evm with minimum configuration, and
booting out of ramdisk:
          with nand booting:  only per powerdomain does not enter retention
          with mmc boot:  core and per dont enter retention

   it could do with clocks set the bootloaders that is preventing it from
   entering ret/off.
   what do you mean by idle state not set correctly? are you referring
to auto-idle bit?


> We need some improved PM debug capabilities in the kernel to pinpoint
> exactly the module that is causing the problem.
>

   Apart from PM debug, are you using any other module/methods to debug?


Regards,
sriram


> Kevin
>
>> Haven't had chance to debug further. Any additional driver added repeats the same behavior. I am not yet certain if the PM_DEBUG has any role. Haven't been able to try few combinations that I wanted to.
>>
>> Best regards,
>> Sanjeev
>>
>>> > 2) Also:
>>> > # echo mem > /sys/power/state
>>> > <6>PM: Syncing filesystems ...
>>> > PM: Syncing filesystems ...
>>> > done.
>>> > done.
>>> > Freezing user space processes ... Freezing user space
>>> processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
>>> > done.
>>> > Freezing remaining freezable tasks ... Freezing remaining
>>> freezable tasks ... (elapsed 0.00 seconds) (elapsed 0.00
>>> seconds) done.
>>> > done.
>>> >
>>> > Suspending console(s) (use no_console_suspend to debug) Suspending
>>> > console(s) (use no_console_suspend to debug) <3>omapfb
>>> omapfb: timeout
>>> > waiting for FRAME DONE
>>> >
>>> > However, I the "resume" doesn't happen.
>>> > Trying to debug further.
>>> >
>>> > Best regards,
>>> > Sanjeev
>>> >
>>> >> On Thu, Nov 20, 2008 at 6:23 AM, Kevin Hilman
>>> >> <khilman@deeprootsystems.com> wrote:
>>> >> > Hello,
>>> >> >
>>> >> > A new PM branch is available named pm-20081119.
>>> >> >
>>> >> > This is mostly a new set of patches on top of the previous
>>> >> PM branch,
>>> >> > rather than a rebase.  We finally found the root cause
>>> of some DPLL
>>> >> > relocking bugs.  Special thanks to Paul Walmsley and Tero
>>> >> Kristo for
>>> >> > debugging and fixing this problem.  Now the DPLL fix that
>>> >> was reverted
>>> >> > in the previous PM branch is re-applied as well as some
>>> >> fixes on top
>>> >> > of it.  It also has some additional UART fixes, so I
>>> think the UART
>>> >> > idle work is ready to go to Tony.  Special thanks to
>>> Jouni Hogander
>>> >> > for the extra testing and fixes here.
>>> >> >
>>> >> > The shortlog is below[1] and the root of the tree is still
>>> >> > v2.6.27-omap1 + T2 power patches from Peter.
>>> >> >
>>> >> > This has primarily been tested on custom HW since I'm
>>> >> _still_ waiting
>>> >> > for my SDP to arrive.  I have boot tested on Beagle, but I
>>> >> think there
>>> >> > are still some problems with ES2 silicon.  On my ES2
>>> >> Beagle, neither
>>> >> > DSS or IVA will leave the ON state, even when all clocks
>>> in their
>>> >> > powerdomains are off.  I have not debugged this further yet.
>>> >> >
>>> >> > Functionally, this tree is in pretty good shape, so I
>>> will do some
>>> >> > bugfixes here when necessary, but will now spent some time
>>> >> focusing on
>>> >> > getting the patches in this branch merged into linux-omap.
>>> >> >
>>> >> > Kevin
>>> >> >
>>> >> >
>>> >> > [1] git shortlog:
>>> >> >
>>> >> > Amit Kucheria (2):
>>> >> >      OMAP: PM: Typo fix for clock_allow_idle
>>> >> >      HSMMC: Make driver support dynamic idle
>>> >> >
>>> >> > Jouni Hogander (11):
>>> >> >      OMAP3: PM: Use pwrdm_set_next_pwrst instead of
>>> >> set_pwrdm_state in idle loop
>>> >> >      OMAP3: Do not set mpu, core, neon states if cpuidle is used
>>> >> >      OMAP3: PM: Do not set next states sw to control those
>>> >> is available
>>> >> >      OMAP3: PM: Always return value in pwrdms_setup
>>> >> >      OMAP3: PM: Fix wrong sequence in suspend.
>>> >> >      OMAP3: UART: Make sure that uart clocks are enabled
>>> when needed
>>> >> >      OMAP3: PM: Check in set_pwrdm_state that target state
>>> >> is supported by pwrdm v2
>>> >> >      OMAP3: PM: Do not build suspend code if SUSPEND is
>>> not enabled
>>> >> >      OMAP: PM: Build fails if PM is not enabled
>>> >> >      OMAP2: PM: Fix omap2 build
>>> >> >      OMAP: MCSPI: Enable mcspi wake-up
>>> >> >
>>> >> > Kalle Jokiniemi (4):
>>> >> >      OMAP: PM: sysfs interface for enabling voltage off in idle
>>> >> >      OMAP3: PM: Fix cpu idle init sequencing
>>> >> >      OMAP: SRF: Fixes to shared resource framework (Ver.3)
>>> >> >      OMAP3: I2C: Enable I2C wakeups
>>> >> >
>>> >> > Kevin Hilman (16):
>>> >> >      OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
>>> >> >      OMAP3: PM: Allow UARTs to be unclocked when inactive
>>> >> >      8250: Allow platform to register PM hook
>>> >> >      8250: when waking, PM hook should be called before
>>> >> accessing port
>>> >> >      OMAP3: PM: UART: Add 8250 UART PM hook for suspend/resume
>>> >> >      OMAP3: PM: UART save/restore support for OFF-mode
>>> >> >      OMAP2/3: HSMMC: Ensure HSMMC is fully reset on boot
>>> >> >      OMAP3: PM: CPUidle: obey enable_off_mode flag
>>> >> >      OMAP3: PM: CPUidle: restrict C-states on UART activity
>>> >> >      OMAP3: PM: decouple PER and CORE context save and restore
>>> >> >      Revert "OMAP3 clock: fix non-CORE DPLL rate assignment bugs"
>>> >> >      Revert "OMAP3: PM: Do not set next states sw to
>>> >> control those is available"
>>> >> >      Revert "OMAP3: Do not set mpu, core, neon states if
>>> >> cpuidle is used"
>>> >> >      OMAP: PM: UART: fix can_sleep hook to return correct value
>>> >> >      OMAP: PM: UART: Only disable clocks in prepare-idle hook
>>> >> >      OMAP3: PM: Check for UART wakeups in 'resume_idle' hook
>>> >> >
>>> >> > Paul Walmsley (14):
>>> >> >      OMAP2/3 PM: create the OMAP PM interface and add a
>>> >> default OMAP PM no-op layer.
>>> >> >      OMAP2/3 omapdev: add basic omapdev structure
>>> >> >      OMAP242x omapdev: add OMAP242x omapdev records
>>> >> >      OMAP243x omapdev: add OMAP243x omapdev records
>>> >> >      OMAP3xxx omapdev: add OMAP3xxx omapdev records
>>> >> >      OMAP2/3 omapdev: add code to walk the omapdev records
>>> >> >      OMAP3 clock: fix non-CORE DPLL rate assignment bugs
>>> >> >      OMAP3 powerdomains: remove RET from SGX power states list
>>> >> >      OMAP3 powerdomains: remove RET from SGX power states list
>>> >> >      OMAP3 clock: remove unnecessary dpll_data dereferences
>>> >> >      OMAP3 clock: optimize DPLL rate rounding algorithm
>>> >> >      OMAP3 clock: avoid invalid FREQSEL values during DPLL
>>> >> rate rounding
>>> >> >      OMAP2/3 I2C: reprogram OCP_SYSCONFIG register after reset
>>> >> >      OMAP: I2C: convert 'rev1' flag to generic 'rev' u8
>>> >> >
>>> >> > Peter 'p2' De Schrijver (9):
>>> >> >      OMAP: PM counter infrastructure.
>>> >> >      OMAP: PM: Hook into PM counters
>>> >> >      OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
>>> >> >      OMAP: PM: Add pm-debug counters
>>> >> >      OMAP: PM debug: make powerdomains use PM-debug counters
>>> >> >      OMAP: PM: Add definitions for ETK pads and
>>> >> observability registers
>>> >> >      OMAP: Debug observability and ETK padconf implementation
>>> >> >      OMAP: Add debug observablity (debobs) Kconfig item
>>> >> >      OMAP: PM: Implement get_last_off_on_transaction_id()
>>> >> >
>>> >> > Rajendra Nayak (23):
>>> >> >      OMAP3: PM: GPMC context save/restore
>>> >> >      OMAP3: PM: GPIO context save/restore
>>> >> >      OMAP3: PM: I2C context save/restore
>>> >> >      OMAP3: PM: INTC context save/restore
>>> >> >      OMAP3: PM: PRCM context save/restore
>>> >> >      OMAP3: PM: Populate scratchpad contents
>>> >> >      OMAP3: PM: SCM context save/restore
>>> >> >      OMAP3: PM: SRAM restore function
>>> >> >      OMAP3: PM: handle PER/NEON/CORE in idle
>>> >> >      OMAP3: PM: Restore MMU table entry
>>> >> >      OMAP3: PM: MPU off-mode support
>>> >> >      OMAP3: PM: CORE domain off-mode support
>>> >> >      OMAP3: PM: allow runtime enable/disable of OFF mode
>>> >> >      OMAP3: 3430SDP minimal kernel defconfig
>>> >> >      OMAP3: PM: CPUidle: Basic support for C1-C2
>>> >> >      OMAP3: PM: CPUidle: Enables state C4
>>> >> >      OMAP3: PM: CPUidle: Enables C3 and C5
>>> >> >      OMAP3: PM: CPUidle: Safe-state on bm-activity
>>> >> >      OMAP3: PM: CPUidle: Enable Kconfig option for OMAP
>>> >> >      OMAP3 SRF: Generic shared resource f/w
>>> >> >      OMAP3 SRF: MPU/CORE/PD latency modeling
>>> >> >      OMAP3 SRF: omap3 srf driver
>>> >> >      OMAP3 SRF: OMAP PM srf implementation
>>> >> >
>>> >> > Tero Kristo (13):
>>> >> >      OMAP: PM debug: do not print out status for meta
>>> >> powerdomains (dpll*)
>>> >> >      OMAP: PM debug: Add PRCM register dump support
>>> >> >      OMAP: PM: DMA context save / restore
>>> >> >      OMAP: PM: off-mode support for DMA on EMU/HS devices
>>> >> >      OMAP3: SRAM size fix for HS/EMU devices
>>> >> >      OMAP3 PM: off-mode support for HS/EMU devices
>>> >> >      OMAP3: PM: Enable SDRAM auto-refresh during sleep
>>> >> >      OMAP: SDRC: Add new register definitions for SDRAM
>>> controller
>>> >> >      OMAP3: PM: SDRC auto-refresh workaround for off-mode
>>> >> >      PM: Fix a bug with noncore dpll rate calculation
>>> >> >      PM: Added three PLL registers to the PRCM context save
>>> >> >      PM: OMAP3: Make sure clk_disable_unused() order is correct
>>> >> >      PM: Changed secure RAM storage size from 0x8000 to 0x803F
>>> >> >
>>> >> > --
>>> >> > To unsubscribe from this list: send the line "unsubscribe
>>> >> linux-omap"
>>> >> > in the body of a message to majordomo@vger.kernel.org More
>>> >> majordomo
>>> >> > info at  http://vger.kernel.org/majordomo-info.html
>>> >> >
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe
>>> linux-omap"
>>> >> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>> >> info at http://vger.kernel.org/majordomo-info.html
>>> >>
>>> >>
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
