From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 00/21] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 18 Oct 2011 20:55:55 +0530
Message-ID: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

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
	
Patch series is based on 3.1.0-rc9 + omap_device fixes from Kevin's tree.
git://gitorious.org/khilman/linux-omap-pm.git for_3.2/omap_device

Also the patch series depends on *Tero's v9 Irq_chaining patches*.
Dependent irq_chaining patches are as below.

e9e7ae1 omap3+: add omap prm driver initialization
e52486f OMAP3: pm: do not enable PRCM MPU interrupts manually
ae5f2af omap3: pm: use prcm chain handler
61ad50f OMAP2+: mux: add support for PAD wakeup interrupts
cab47bf mfd: omap-prm: added suspend prepare and complete callbacks
8ed5bcd mfd: omap-prm: added chain interrupt handler
024f0e3 mfd: omap-prm: add driver skeleton
d285827 TEMP: OMAP4xxx: hwmod data: add PRM hwmod
da6f48f TEMP: OMAP3xxx: hwmod data: add PRM hwmod

Same combination is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git v7_rc9_uart_runtime

Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.

Changes from v6:
---------------
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57469.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57538.html

Errata handling:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57543.html

PM_qos usage suggestion:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57588.html

Adding custom hwmod activate func.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57679.html

Changes from v5:
---------------
* Incorporating omap_uart_can_sleep function to avoid
  console sluglishness as reported by tero.
* fixing below comments adding omap4 for autosuspend and wakeup.
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg56221.html

  In addition cleaning up pads from omap4430sdp/panda board file
  to use default pads from serial.c

Changes from v4:
---------------

1.) Fixing v4 comments from Kevin.
    Spilt into smaller logical patches.
2.) Using Irq_chaining OMAP_PRM driver for waking up uart.

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

Govindraj.R (19):
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
  OMAP2+: UART: Remove custom activate funcs and use generic funcs.
  OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
  OMAP2+: UART: remove temporary variable used to count uart instance
  OMAP2+: UART: Use custom activate func for console uart.
  OMAP2+: UART: Avoid uart idling on suspend for no_console_suspend
    usecase
  OMAP2+: UART: Do not gate uart clocks if used for debug_prints

Jon Hunter (1):
  OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   68 +--
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   68 +--
 arch/arm/mach-omap2/cpuidle34xx.c             |    5 -
 arch/arm/mach-omap2/pm24xx.c                  |   20 -
 arch/arm/mach-omap2/pm34xx.c                  |   33 -
 arch/arm/mach-omap2/serial.c                  |  937 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   38 +-
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  345 ++++++++--
 11 files changed, 609 insertions(+), 1021 deletions(-)

-- 
1.7.4.1

