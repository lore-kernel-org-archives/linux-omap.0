From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Fri, 11 Nov 2011 15:27:17 +0530
Message-ID: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60361 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab1KKJ6g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 04:58:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Converting uart driver to adapt to pm runtime API's.
Code re-org + cleanup.
Moving some functionality from serial.c to omap-serial.c

Changes involves:
================
1.) Cleaning up certain uart calls from sram_idle func.
2.) Removed all types of uart clock handling code from serial.c
3.) Using hwmod_mux API enable wakeup capability for uart pad during
   hwmod_idle state i.e., when uart clocks are disabled we can enable
   io-pad wakeup capability for uart if mux_data is available for
   given uart. Also during during resume from idle call to uart we need
   to enable clocks back conditionally and this can be done only when io-pad
   wakeup event bit is set for uart_rx pad. So we need a hwmod API
   which can probe the uart pad and let us know whether a uart wakeup
   happened. So omap_hmwod_pad_wakeup_status API is added to meet this
   requirement.
3.) Adapted omap-serial driver to use runtime API's.
4.) Modify serial_init calls to accept uart parameters from board file.
    Like dma_usage, rx_timeout, dma_rx_pollrate, auto_suspend_timeout etc.
5.) Use the omap_prm driver with irq_chaining to wake up uart after clocks are
    cut.
	
Patch series is based on 3.2-rc1.

Patch series depends on *Tero's v9 Irq_chaining patches*.
Dependent irq_chaining patches are as below.

89ac62b omap3+: add omap prm driver initialization
170431f OMAP3: pm: do not enable PRCM MPU interrupts manually
9aba1b0 omap3: pm: use prcm chain handler
435481f OMAP2+: mux: add support for PAD wakeup interrupts
5b2d361 mfd: omap-prm: added suspend prepare and complete callbacks
aa55c41 mfd: omap-prm: added chain interrupt handler
d1db904 mfd: omap-prm: add driver skeleton
31d056c TEMP: OMAP4xxx: hwmod data: add PRM hwmod
19ec3bc TEMP: OMAP3xxx: hwmod data: add PRM hwmod
9a89688 OMAP2+: hwmod: Add API to check IO PAD wakeup status
78e8b65 OMAP2+: hwmod: Add API to enable IO ring wakeup.

Same combination is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git 3.2-rc1_uart_runtime

Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
And for pm_qos usage ensure CONFIG_CPU_IDLE is selected other wise
console might be sluggish.

Changes from v7:
---------------
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57804.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58209.html
http://www.spinics.net/lists/linux-omap/msg59978.html
http://www.spinics.net/lists/linux-serial/msg04772.html

Testing updates:
----------------
OMAP2420/2430SDP: Boot tested.

OMAP3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked with quart/omap-uart3
[Also tested with uart3 as console uart and pm-ret checked]

BeagleBoard XM Rev C(3630):
retention, off_mode, system_wide suspend is tested.

Deepak K (1):
  OMAP2+: UART: Allow UART parameters to be configured from board file.

Govindraj.R (18):
  OMAP2+: UART: cleanup + remove uart pm specific API
  OMAP2+: UART: cleanup 8250 console driver support
  OMAP2+: UART: Cleanup part of clock gating mechanism for uart
  OMAP2+: UART: Add default mux for all uarts.
  OMAP2+: UART: Remove mapbase/membase fields from pdata.
  OMAP2+: UART: Add runtime pm support for omap-serial driver
  OMAP2+: UART: Remove context_save and move context restore to driver
  OMAP2+: UART: Ensure all reg values configured are available from
    port structure
  OMAP2+: UART: Remove uart reset function.
  OMAP2+: UART: Get context loss count to context restore
  OMAP2+: UART: Move errata handling from serial.c to omap-serial
  OMAP2+: UART: Add wakeup mechanism for omap-uarts
  OMAP2+: UART: Remove old and unused clocks handling funcs
  OMAP2+: UART: remove temporary variable used to count uart instance
  OMAP2+: UART: Use custom activate func for console uart.
  OMAP2+: UART: Avoid uart idling on suspend for no_console_suspend
    usecase
  OMAP2+: UART: Do not gate uart clocks if used for debug_prints
  OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos

Jon Hunter (1):
  OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   68 +--
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   68 +--
 arch/arm/mach-omap2/cpuidle34xx.c             |    5 -
 arch/arm/mach-omap2/pm24xx.c                  |   20 -
 arch/arm/mach-omap2/pm34xx.c                  |   42 --
 arch/arm/mach-omap2/serial.c                  |  926 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   36 +-
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  341 ++++++++--
 11 files changed, 607 insertions(+), 1015 deletions(-)

-- 
1.7.4.1

