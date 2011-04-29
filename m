From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 00/12] OMAP2+: Serial: Runtime adaptation + cleanup
Date: Fri, 29 Apr 2011 18:09:44 +0530
Message-ID: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
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

Patch series is based on Kevin's PM Tree / pm-core branch [2.6.39-rc4]
Patch series hosted at https://gitorious.org/uart_runtime/pm

Testing updates:
----------------
3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked, off mode for per domain checked.
[uart3/uart4 in per domain on omap3630].
[ZOOM3 tested with uart3 as console uart and pm-ret checked]

OMAP4430-SDP: Boot tested.
OMAP2420/2430SDP: Boot tested.
-------------

Deepak K (1):
  OMAP: Serial: Allow UART parameters to be configured from board file

Govindraj.R (10):
  OMAP2+: UART: Remove certain uart calls from sram_idle
  OMAP2+: UART: Remove uart clock handling code from serial.c
  OMAP2+: Serial: Add default mux for all uarts.
  Serial: OMAP: Add runtime pm support for omap-serial driver
  OMAP: Serial: Hold console lock for console usage.
  Serial: OMAP2+: Move erratum handling from serial.c
  OMAP3: Serial: Remove uart pads from 3430 board file.
  OMAP2+: hwmod: Add api to enable io_ring wakeup.
  OMAP: Serial: Use resume call from prcm to enable uart
  OMAP2: Serial: Add no async wake flag.

Jon Hunter (1):
  Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each
    UART

 arch/arm/mach-omap2/board-2430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c           |  101 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   11 +-
 arch/arm/mach-omap2/board-am3517evm.c         |    3 +-
 arch/arm/mach-omap2/board-apollon.c           |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c            |    3 +-
 arch/arm/mach-omap2/board-cm-t3517.c          |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c        |    3 +-
 arch/arm/mach-omap2/board-generic.c           |    3 +-
 arch/arm/mach-omap2/board-h4.c                |    3 +-
 arch/arm/mach-omap2/board-igep0020.c          |    3 +-
 arch/arm/mach-omap2/board-igep0030.c          |    3 +-
 arch/arm/mach-omap2/board-ldp.c               |    3 +-
 arch/arm/mach-omap2/board-n8x0.c              |    9 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    3 +-
 arch/arm/mach-omap2/board-omap3logic.c        |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    3 +-
 arch/arm/mach-omap2/board-omap3stalker.c      |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c    |    3 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   11 +-
 arch/arm/mach-omap2/board-overo.c             |    3 +-
 arch/arm/mach-omap2/board-rm680.c             |    3 +-
 arch/arm/mach-omap2/board-rx51.c              |    3 +-
 arch/arm/mach-omap2/board-ti8168evm.c         |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    3 +-
 arch/arm/mach-omap2/mux.c                     |   23 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   47 ++
 arch/arm/mach-omap2/pm24xx.c                  |   19 +-
 arch/arm/mach-omap2/pm34xx.c                  |   26 +-
 arch/arm/mach-omap2/serial.c                  |  917 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   38 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/include/plat/serial.h      |   13 +-
 arch/arm/plat-omap/omap_device.c              |   34 +-
 drivers/tty/serial/omap-serial.c              |  319 ++++++++-
 38 files changed, 747 insertions(+), 902 deletions(-)

