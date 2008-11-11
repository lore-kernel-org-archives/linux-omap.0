From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch: pm-20081106
Date: Tue, 11 Nov 2008 09:21:17 -0800
Message-ID: <87ej1ikwky.fsf@deeprootsystems.com>
References: <00b001c942f8$89f5f4d0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:13368 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbYKKRV0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 12:21:26 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1422134nfc.21
        for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 09:21:24 -0800 (PST)
In-Reply-To: <00b001c942f8$89f5f4d0$LocalHost@wipultra1382> (Rajendra Nayak's message of "Mon\, 10 Nov 2008 11\:22\:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> I am seeing a couple of issues on the 3430sdp with this latest pm
> branch.  With the omap_3430sdp_min_defconfig I see a system freeze
> after bootup after the debug UART inactivity. Also system wide
> suspend seems to freeze.  The system wide suspend freeze is seen
> even with the default (omap_3430sdp_defconfig) config.  I ran into
> these issue while validating the DVFS patches and haven't really
> looked further into what might be causing these. I have a ES3.0 GP
> based SDP board.

Rajendra,

I just pushed another patch to pm-20081106 for you to try.  This
reverts a commit[1] from linux-omap which is causing problems coming
out of retention.

Could you update your PM branch, and also modify the 'enabled_uarts'
settings in your board-3430sdp.c file so that only the console UART is
enabled.  Doing this would help me understand what's working on SDP.

Until I get my SDP, I'll need to rely on you for this testing.

Kevin

[1] 2ac1da8c787f73f067e717408e631501ba60aabc

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Friday, November 07, 2008 11:00 PM
>> To: linux-omap@vger.kernel.org
>> Subject: new PM branch: pm-20081106
>> 
>> For those who want to experiment with the latest PM branch, it is now
>> available in OMAP git as branch pm-20081106
>> 
>> The shortlog is below[1], but the significant thing for now is a
>> rework of how UART handles its clocks and allows idle.  I also did
>> quite a bit of reordering and some restructuring.
>> 
>> I've tested this on Nokia HW and the basic retention-on-idle support
>> on Beagle.  I'm still waiting for my SDP to arrive, so haven't tested
>> on SDP.
>> 
>> Kevin
>> 
>> [1]
>> Amit Kucheria (2):
>>       OMAP: PM: Typo fix for clock_allow_idle
>>       HSMMC: Make driver support dynamic idle
>> 
>> Jouni Hogander (5):
>>       OMAP3: PM: Use pwrdm_set_next_pwrst instead of 
>> set_pwrdm_state in idle loop
>>       OMAP3: Do not set mpu, core, neon states if cpuidle is used
>>       OMAP3: PM: Do not set next states sw to control those 
>> is available
>>       OMAP3: PM: Always return value in pwrdms_setup
>>       OMAP3: PM: Fix wrong sequence in suspend.
>> 
>> Kalle Jokiniemi (3):
>>       OMAP: PM: sysfs interface for enabling voltage off in idle
>>       OMAP3: PM: Fix cpu idle init sequencing
>>       OMAP: SRF: Fixes to shared resource framework (Ver.3)
>> 
>> Kevin Hilman (10):
>>       OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
>>       OMAP3: PM: Allow UARTs to be unclocked when inactive
>>       8250: Allow platform to register PM hook
>>       8250: when waking, PM hook should be called before 
>> accessing port
>>       OMAP3: PM: UART: Add 8250 UART PM hook for suspend/resume
>>       OMAP3: PM: UART save/restore support for OFF-mode
>>       OMAP2/3: HSMMC: Ensure HSMMC is fully reset on boot
>>       OMAP3: PM: CPUidle: obey enable_off_mode flag
>>       OMAP3: PM: CPUidle: restrict C-states on UART activity
>>       OMAP3: PM: decouple PER and CORE context save and restore
>> 
>> Paul Walmsley (6):
>>       OMAP2/3 PM: create the OMAP PM interface and add a 
>> default OMAP PM no-op layer.
>>       OMAP2/3 omapdev: add basic omapdev structure
>>       OMAP242x omapdev: add OMAP242x omapdev records
>>       OMAP243x omapdev: add OMAP243x omapdev records
>>       OMAP3xxx omapdev: add OMAP3xxx omapdev records
>>       OMAP2/3 omapdev: add code to walk the omapdev records
>> 
>> Peter 'p2' De Schrijver (9):
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
>> 
>> Rajendra Nayak (23):
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
>>       OMAP3: PM: CPUidle: Enable Kconfig option for OMAP
>>       OMAP3 SRF: Generic shared resource f/w
>>       OMAP3 SRF: MPU/CORE/PD latency modeling
>>       OMAP3 SRF: omap3 srf driver
>>       OMAP3 SRF: OMAP PM srf implementation
>> 
>> Tero Kristo (9):
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
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
