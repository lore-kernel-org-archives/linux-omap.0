From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: new PM branch: pm-20081106
Date: Mon, 10 Nov 2008 11:22:36 +0530
Message-ID: <00b001c942f8$89f5f4d0$LocalHost@wipultra1382>
References: <87r65nxx4p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52724 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYKJFws convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 00:52:48 -0500
In-Reply-To: <87r65nxx4p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Hello Kevin,

I am seeing a couple of issues on the 3430sdp with this latest pm branch.
With the omap_3430sdp_min_defconfig I see a system freeze after bootup
after the debug UART inactivity. Also system wide suspend seems to freeze.
The system wide suspend freeze is seen even with the default (omap_3430sdp_defconfig)
config.
I ran into these issue while validating the DVFS patches and haven't really looked further
into what might be causing these. I have a ES3.0 GP based SDP board.

regards,
Rajendra 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, November 07, 2008 11:00 PM
> To: linux-omap@vger.kernel.org
> Subject: new PM branch: pm-20081106
> 
> For those who want to experiment with the latest PM branch, it is now
> available in OMAP git as branch pm-20081106
> 
> The shortlog is below[1], but the significant thing for now is a
> rework of how UART handles its clocks and allows idle.  I also did
> quite a bit of reordering and some restructuring.
> 
> I've tested this on Nokia HW and the basic retention-on-idle support
> on Beagle.  I'm still waiting for my SDP to arrive, so haven't tested
> on SDP.
> 
> Kevin
> 
> [1]
> Amit Kucheria (2):
>       OMAP: PM: Typo fix for clock_allow_idle
>       HSMMC: Make driver support dynamic idle
> 
> Jouni Hogander (5):
>       OMAP3: PM: Use pwrdm_set_next_pwrst instead of 
> set_pwrdm_state in idle loop
>       OMAP3: Do not set mpu, core, neon states if cpuidle is used
>       OMAP3: PM: Do not set next states sw to control those 
> is available
>       OMAP3: PM: Always return value in pwrdms_setup
>       OMAP3: PM: Fix wrong sequence in suspend.
> 
> Kalle Jokiniemi (3):
>       OMAP: PM: sysfs interface for enabling voltage off in idle
>       OMAP3: PM: Fix cpu idle init sequencing
>       OMAP: SRF: Fixes to shared resource framework (Ver.3)
> 
> Kevin Hilman (10):
>       OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
>       OMAP3: PM: Allow UARTs to be unclocked when inactive
>       8250: Allow platform to register PM hook
>       8250: when waking, PM hook should be called before 
> accessing port
>       OMAP3: PM: UART: Add 8250 UART PM hook for suspend/resume
>       OMAP3: PM: UART save/restore support for OFF-mode
>       OMAP2/3: HSMMC: Ensure HSMMC is fully reset on boot
>       OMAP3: PM: CPUidle: obey enable_off_mode flag
>       OMAP3: PM: CPUidle: restrict C-states on UART activity
>       OMAP3: PM: decouple PER and CORE context save and restore
> 
> Paul Walmsley (6):
>       OMAP2/3 PM: create the OMAP PM interface and add a 
> default OMAP PM no-op layer.
>       OMAP2/3 omapdev: add basic omapdev structure
>       OMAP242x omapdev: add OMAP242x omapdev records
>       OMAP243x omapdev: add OMAP243x omapdev records
>       OMAP3xxx omapdev: add OMAP3xxx omapdev records
>       OMAP2/3 omapdev: add code to walk the omapdev records
> 
> Peter 'p2' De Schrijver (9):
>       OMAP: PM counter infrastructure.
>       OMAP: PM: Hook into PM counters
>       OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
>       OMAP: PM: Add pm-debug counters
>       OMAP: PM debug: make powerdomains use PM-debug counters
>       OMAP: PM: Add definitions for ETK pads and 
> observability registers
>       OMAP: Debug observability and ETK padconf implementation
>       OMAP: Add debug observablity (debobs) Kconfig item
>       OMAP: PM: Implement get_last_off_on_transaction_id()
> 
> Rajendra Nayak (23):
>       OMAP3: PM: GPMC context save/restore
>       OMAP3: PM: GPIO context save/restore
>       OMAP3: PM: I2C context save/restore
>       OMAP3: PM: INTC context save/restore
>       OMAP3: PM: PRCM context save/restore
>       OMAP3: PM: Populate scratchpad contents
>       OMAP3: PM: SCM context save/restore
>       OMAP3: PM: SRAM restore function
>       OMAP3: PM: handle PER/NEON/CORE in idle
>       OMAP3: PM: Restore MMU table entry
>       OMAP3: PM: MPU off-mode support
>       OMAP3: PM: CORE domain off-mode support
>       OMAP3: PM: allow runtime enable/disable of OFF mode
>       OMAP3: 3430SDP minimal kernel defconfig
>       OMAP3: PM: CPUidle: Basic support for C1-C2
>       OMAP3: PM: CPUidle: Enables state C4
>       OMAP3: PM: CPUidle: Enables C3 and C5
>       OMAP3: PM: CPUidle: Safe-state on bm-activity
>       OMAP3: PM: CPUidle: Enable Kconfig option for OMAP
>       OMAP3 SRF: Generic shared resource f/w
>       OMAP3 SRF: MPU/CORE/PD latency modeling
>       OMAP3 SRF: omap3 srf driver
>       OMAP3 SRF: OMAP PM srf implementation
> 
> Tero Kristo (9):
>       OMAP: PM debug: do not print out status for meta 
> powerdomains (dpll*)
>       OMAP: PM debug: Add PRCM register dump support
>       OMAP: PM: DMA context save / restore
>       OMAP: PM: off-mode support for DMA on EMU/HS devices
>       OMAP3: SRAM size fix for HS/EMU devices
>       OMAP3 PM: off-mode support for HS/EMU devices
>       OMAP3: PM: Enable SDRAM auto-refresh during sleep
>       OMAP: SDRC: Add new register definitions for SDRAM controller
>       OMAP3: PM: SDRC auto-refresh workaround for off-mode
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

