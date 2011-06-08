From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 00/12] OMAP2+: Serial: Runtime adaptation + cleanup
Date: Wed, 8 Jun 2011 16:53:02 +0530
Message-ID: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Converting uart driver to adapt to pm runtime api's.
Code re-org + cleanup.
Moving some functionality from serial.c to omap-serial.c

Changes involves:
================
1.) Cleaning up certain uart calls from sram_idle func.
2.) Removed all types of uart clock handling code from serial.c
3.) Using hwmod_mux api enable wakeup capability for uart pad during
   hwmod_idle state i.e., when uart clocks are disabled we can enable
   io-pad wakeup capability for uart if mux_data is available for
   given uart. Also during during resume from idle call to uart we need
   to enable clocks back conditionally and this can be done only when io-pad
   wakeup event bit is set for uart_rx pad. So we need a hwmod api
   which can probe the uart pad and let us know whether a uart wakeup
   happened. So omap_hmwod_pad_wakeup_status api is added to meet this
   requirement.
3.) Adapted omap-serial driver to use runtime api's.
4.) Modify serial_init calls to accept certain uart parameters from board file.
5.) using resume_call to enable uart port back untill we have irq_chaining available.

Patch series is based on 3.0-rc2.
Hosted at: https://gitorious.org/runtime_3-0/runtime_3-0/commits/master

Dependency Patches:
----------
This patch series depends on patch [1], [2] posted earlier.
3.0-rc2 needs [3] patch for core to hit low power states.

[1] http://www.spinics.net/lists/arm-kernel/msg124495.html

[2] http://www.spinics.net/lists/arm-kernel/msg124493.html

[3] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;
	a=commit;h=345f79b3de7f6d651e4dba794af7c7303bdfd649

Testing updates:
----------------
3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked, off mode for per domain checked.
[uart3/uart4 in per domain on omap3630].
[ZOOM3 tested with uart3 as console uart and pm-ret checked]

OMAP4430-SDP/PANDA: Boot tested.
OMAP2420/2430SDP: Boot tested.
-------------
Govindraj.R (11):
  OMAP2+: UART: Remove certain uart calls from sram_idle
  OMAP2+: UART: Remove uart clock handling code from serial.c
  OMAP2+: Serial: Add default mux for all uarts.
  Serial: OMAP: Add runtime pm support for omap-serial driver
  OMAP: Serial: Hold console lock for console usage.
  Serial: OMAP2+: Move erratum handling from serial.c
  OMAP: Serial: Allow UART parameters to be configured from board file.
  OMAP3: Serial: Remove uart pads from 3430 board file.
  OMAP: Serial: Use resume call from prcm to enable uart
  OMAP2: Serial: Add has_async_wake flag.
  OMAP4: Serial: Set TX_FIFO_THRESHOLD if uart in dma mode for es2.0

Jon Hunter (1):
  Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each
    UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |    8 +-
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |    8 +-
 arch/arm/mach-omap2/pm24xx.c                  |   19 +-
 arch/arm/mach-omap2/pm34xx.c                  |   26 +-
 arch/arm/mach-omap2/serial.c                  |  929 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   49 ++-
 arch/arm/plat-omap/include/plat/serial.h      |   12 +-
 drivers/tty/serial/omap-serial.c              |  336 ++++++++-
 10 files changed, 620 insertions(+), 873 deletions(-)

