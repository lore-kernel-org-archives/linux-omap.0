From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/7] OMAP2+: UART: runtime conversion + cleanup.
Date: Mon, 28 Feb 2011 20:09:11 +0530
Message-ID: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Converting uart driver to adapt to pm runtime api's.
Changes involves:
================
1.) Cleaning up certain uart calls from sram_idle func but still 
    retaining the prepare_idle/resume_idle func calls because as
    of today uart module level wakeup doesn't seem to work. 
    We have informed the hardware folks about this and discussion
    is in progress. So until we have a workaround for this we have to
    depend on prepare/resume calls to cut uart clock and wakeup based
    on io-daisy chain mechanism using uart_rx padconf.
2.) Removed all types of uart clock handling code from serial.c
    file and now onwards serial.c file is used only for device registration 
    and to probe early uart and pass some uart board data which
    can be passed as pdata to driver. Also cleaned up direct padconf usage.
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
4.) Modify serial_init calls to accept certain dma based uart parameters
5.) Minor cleanups and rename uart_rx_dma api.

Patch series is based on LO Kernel omap_for_linus branch.
Commit-id: 7cab8713b1ed0dab08ad6458f92a40b7ff4be619
Dependency patches needed to test system wide suspend on omap_for_linus branch.
https://patchwork.kernel.org/patch/550551/
https://patchwork.kernel.org/patch/513481/
https://patchwork.kernel.org/patch/501211/

Testing updates:
----------------
3430SDP, ZOOM2: retention, off_mode, system_wide suspend is tested.
OMAP3630 - Zoom3: pm-retention checked, off mode for per domain checked.
	[uart3/uart4 in per domain on omap3630].
OMAP4430[Blaze]: Boot tested.
OMAP2420/2430SDP: Boot tested

Govindraj.R (5):
  OMAP2+ : hwmod_data: update uart hwmod data.
  OMAP2+: mux: Enable wakeup for wakeup enable requested pads.
  OMAP2+: UART: Remove certain uart calls from sram_idle.
  OMAP2+: UART: Remove uart clock handling code serial.c
  Serial: OMAP: add runtime pm support for omap-serial driver

Jon Hunter (2):
  OMAP: Serial: Allow UART parameters to be configured from board file
  Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each
    UART

 arch/arm/mach-omap2/board-2430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    3 +-
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
 arch/arm/mach-omap2/board-omap4panda.c        |    3 +-
 arch/arm/mach-omap2/board-overo.c             |    3 +-
 arch/arm/mach-omap2/board-rm680.c             |    3 +-
 arch/arm/mach-omap2/board-rx51.c              |    3 +-
 arch/arm/mach-omap2/board-ti8168evm.c         |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    3 +-
 arch/arm/mach-omap2/mux.c                     |   23 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   13 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |    3 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |    3 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    4 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |    4 +
 arch/arm/mach-omap2/pm24xx.c                  |   11 -
 arch/arm/mach-omap2/pm34xx.c                  |   16 -
 arch/arm/mach-omap2/serial.c                  |  845 +++++--------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   37 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  323 +++++++++-
 40 files changed, 601 insertions(+), 789 deletions(-)

