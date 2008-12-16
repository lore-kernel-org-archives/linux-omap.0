From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [ANNOUNCE] updated PM branch
Date: Mon, 15 Dec 2008 17:58:30 -0800
Message-ID: <87k5a098zd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:54638 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYLPB6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 20:58:42 -0500
Received: by qyk4 with SMTP id 4so2962129qyk.13
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 17:58:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The PM branch has been consolidated and rebased against today's
linux-omap HEAD.  I've also included a few patches that were posted to
the list that had fallen through the cracks.  

Reminder: The branch name is 'pm'.  It will continue to be called pm
and just be periodially rebased against linux-omap HEAD.

Some patchsets that have been submitted, but are still not included:

- [PATCH 0/2] Bug fixes for DVFS (Peter)
  - waiting for updated patch descriptions

- OMAP3: DVFS core patch set (Tero, Paul, Peter)
  - waiting for a split 

- OMAP3: GPIO fixes for off-mode
  - waiting for review comments to be addresed

Kevin


git-shortlog:

Carlos Chinea (1):
      OMAP3:PM: Update SSI omapdev record

Jouni Hogander (6):
      OMAP: UART: Add sysfs interface for adjusting UART sleep timeout
      OMAP3: PM: Use pwrdm_set_next_pwrst instead of set_pwrdm_state in idle loop
      OMAP3: PM: Fix wrong sequence in suspend.
      OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
      OMAP: PM: Build fails if PM is not enabled
      OMAP2: PM: Fix omap2 build

Kalle Jokiniemi (3):
      OMAP: PM: sysfs interface for enabling voltage off in idle
      OMAP3: PM: Fix cpu idle init sequencing
      OMAP: SRF: Fixes to shared resource framework (Ver.3)

Kevin Hilman (11):
      OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
      OMAP3: PM: UART: disable clocks when idle
      OMAP3: PM: UART save/restore support for OFF-mode
      OMAP3: PM: Force IVA2 into idle during bootup
      OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
      OMAP3: PM: D2D clockdomain supports SW supervised transitions
      OMAP3: PM: Ensure modem is reset during PRCM init
      OMAP3: PM: CPUidle: obey enable_off_mode flag
      OMAP3: PM: CPUidle: restrict C-states on UART activity
      OMAP3: PM: decouple PER and CORE context save and restore
      OMAP2/3: PM: system_rev -> omap_rev()

Paul Walmsley (6):
      OMAP2/3 PM: create the OMAP PM interface and add a default OMAP PM no-op layer.
      OMAP2/3 omapdev: add basic omapdev structure
      OMAP242x omapdev: add OMAP242x omapdev records
      OMAP243x omapdev: add OMAP243x omapdev records
      OMAP3xxx omapdev: add OMAP3xxx omapdev records
      OMAP2/3 omapdev: add code to walk the omapdev records

Peter 'p2' De Schrijver (10):
      OMAP: PM counter infrastructure.
      OMAP: PM: Hook into PM counters
      OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
      OMAP: PM: Add pm-debug counters
      OMAP: PM debug: make powerdomains use PM-debug counters
      OMAP: PM: Add definitions for ETK pads and observability registers
      OMAP: Debug observability and ETK padconf implementation
      OMAP: Add debug observablity (debobs) Kconfig item
      OMAP: PM: Implement get_last_off_on_transaction_id()
      Save sram context after changing MPU, DSP or core clocks

Rajendra Nayak (34):
      OMAP3: PM: GPMC context save/restore
      OMAP3: PM: GPIO context save/restore
      OMAP3: PM: I2C context save/restore
      OMAP3: PM: INTC context save/restore
      OMAP3: PM: PRCM context save/restore
      OMAP3: PM: Populate scratchpad contents
      OMAP3: PM: SCM context save/restore
      OMAP3: PM: SRAM restore function
      OMAP3: PM: handle PER/NEON/CORE in idle
      OMAP3: PM: Restore MMU table entry
      OMAP3: PM: MPU off-mode support
      OMAP3: PM: CORE domain off-mode support
      OMAP3: PM: allow runtime enable/disable of OFF mode
      OMAP3: 3430SDP minimal kernel defconfig
      OMAP3: PM: CPUidle: Basic support for C1-C2
      OMAP3: PM: CPUidle: Enables state C4
      OMAP3: PM: CPUidle: Enables C3 and C5
      OMAP3: PM: CPUidle: Safe-state on bm-activity
      OMAP3 SRF: Generic shared resource f/w
      OMAP3 SRF: MPU/CORE/PD latency modeling
      OMAP3 SRF: omap3 srf driver
      OMAP3 SRF: OMAP PM srf implementation
      OMAP3 SRF: Add CORE rate table param in OMAP-PM
      OMAP3 SRF: Add VDD1/VDD2 rate tables for 3430SDP
      OMAP3 SRF: Add virt clk nodes for VDD1/VDD2
      OMAP3 SRF: Adds OPP/Freq res's in SRF
      OMAP3 SRF: Update OMAP-PM layer
      OMAP3 SRF: Voltage scaling support
      OMAP3 SRF: VDD2 scaling support
      OMAP3 SRF: Adds sysfs control for VDD1/VDD2 OPP's
      OMAP3 PM: Replace spinlocks with mutex in SRF
      OMAP3 PM: CPUFreq driver for OMAP3
      OMAP3 PM: Update the min defconfig for 3430sdp
      OMAP3 SRF: Fix crash on non-3430SDP platforms with DVFS/CPUFreq

Tero Kristo (16):
      PM: OMAP3: Make sure clk_disable_unused() order is correct
      OMAP: PM debug: do not print out status for meta powerdomains (dpll*)
      OMAP: PM debug: Add PRCM register dump support
      OMAP: PM: DMA context save / restore
      OMAP: PM: off-mode support for DMA on EMU/HS devices
      OMAP3: SRAM size fix for HS/EMU devices
      OMAP3 PM: off-mode support for HS/EMU devices
      OMAP3: PM: Enable SDRAM auto-refresh during sleep
      OMAP: SDRC: Add new register definitions for SDRAM controller
      OMAP3: PM: SDRC auto-refresh workaround for off-mode
      PM: Added three PLL registers to the PRCM context save
      PM: Changed secure RAM storage size from 0x8000 to 0x803F
      PM: Added suspend target state control to debugfs for OMAP3
      OMAP3: PM: Prevent PER from going OFF when CORE is going INA
      PM OMAP3: Change omap3_save_secure_ram to be called only during init
      OMAP3: PM: MPU and CORE should stay awake if there is CAM domain ACTIVE

