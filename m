From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 00/15] OMAP2+: Serial: Runtime adaptation + cleanup
Date: Wed, 21 Sep 2011 17:41:37 +0530
Message-ID: <1316607097-21564-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab1IUMMV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 08:12:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Partha Basak <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, Govindraj R <govindraj.raja@ti.com>

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
	
Patch series is based on 3.1.0-rc4 + omap_device fixes.
>From Kevin's tree.
git://gitorious.org/khilman/linux-omap-pm.git for_3.2/omap_device

Also the patch series depends on Tero's Irq_chaining patches.
Dependent irq_chaining patches are as below.

3d5b543 omap3: pm: use prcm chain handler
c00b340 OMAP2+: mux: add support for PAD wakeup interrupts
db6397c power: omap-prm: added chain interrupt handler
b3f8628 TEMP: OMAP4xxx: hwmod data: add PRM hwmod
61ec0fc TEMP: OMAP3xxx: hwmod data: add PRM hwmod
a1ecf8c power: add omap prm driver skeleton

Same combination is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git v5_uart_irqchn

Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.

Changes from v4:
---------------

1.) Fixing v4 comments from Kevin.
    Spilt into smaller logical patches.
2.) Using Irq_chaining OMAP_PRM driver for waking up uart.

Testing updates:
----------------
3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked with quart/omap-uart3
[Also tested with uart3 as console uart and pm-ret checked]

OMAP4430-SDP: Boot tested.
OMAP2420/2430SDP: Boot tested.

Deepak K (1):
  OMAP2+: UART: Allow UART parameters to be configured from board file.

Govindraj.R (13):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status
  OMAP2+: UART: cleanup + remove uart pm specific API
  OMAP2+: UART: cleanup 8250 console driver support
  OMAP2+: UART: Cleanup part of clock gating mechanism for uart
  OMAP2+: UART: Remove certain feilds from omap_uart_state struct
  OMAP2+: UART: Add default mux for all uarts.
  OMAP2+: UART: Store certain reg values to port structure
  OMAP2+: UART: Add runtime pm support for omap-serial driver
  OMAP2+: UART: Move errata handling from serial.c to omap-serial
  OMAP2+: UART: Take console_lock in suspend path if not taken
  OMAP2+: UART: Enable back uart clocks with runtime API for early
    console
  OMAP2+: UART: Do not gate uart clocks if used for debug_prints

Jon Hunter (1):
  OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |    8 +-
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |    8 +-
 arch/arm/mach-omap2/mux.c                     |   30 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   66 ++
 arch/arm/mach-omap2/pm24xx.c                  |   19 -
 arch/arm/mach-omap2/pm34xx.c                  |   24 -
 arch/arm/mach-omap2/serial.c                  |  933 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   30 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |   11 +-
 drivers/tty/serial/omap-serial.c              |  305 +++++++--
 14 files changed, 654 insertions(+), 900 deletions(-)

-- 
1.7.4.1

