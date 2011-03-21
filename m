From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] omap display subsystem changes for 2.6.39
Date: Mon, 21 Mar 2011 11:51:23 +0200
Message-ID: <1300701083.2891.77.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab1CUJvb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 05:51:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi Paul,

Here are OMAP display subsystem patches for 2.6.39 merge window. Quite a
bit of them, and many changes also in arch/arm/mach-omap2, which
unfortunately couldn't go through Tony's linux-omap tree due to
dependencies on DSS driver code.

The patches are mostly aiming to get OMAP4 display support up and
running and both HDMI and DVI outputs should now work on Blaze and Panda
boards.

One problem I noticed just now, the committer names seem a bit messed
up. For example, Archit Taneja has three different style names there. Do
you think I should rebase and fix them? Not a big job, but it'll mean,
well, rebasing.

There's a minor conflict in Overo's board file. I have pushed
"for-paul-merged" branch to gitorious, which contains a merge with
Linus' tree. I'm not sure that is the best way to show how to fix the
conflict, but hopefully it'll give the idea.

 Tomi


The following changes since commit a44f99c7efdb88fa41128065c9a9445c19894e34:

  Merge branch 'trivial' of git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild-2.6 (2011-03-20 18:14:55 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-paul

Archit Taneja (9):
      OMAP2PLUS: DSS2: Generalize naming of PRCM related clock enums in DSS driver
      OMAP2PLUS: DSS2: Generalize external clock names in struct dss of dss.c
      OMAP2PLUS: DSS2: FEATURES: DISPC overlay code cleanup
      OMAP2PLUS: DSS2: FEATURES: Function to Provide the max fck supported
      OMAP2PLUS: DSS2: Make members of dss_clk_source generic
      OMAP2PLUS: DSS2: Use dss features to get clock source names of current OMAP
      OMAP2PLUS: DSS2: DSI: Generalize DSI PLL Clock Naming
      OMAP: DSS2: Functions to request/release DSI VCs
      OMAP: DSS2: Use request / release calls in Taal for DSI Virtual Channels.

Jani Nikula (1):
      OMAP: DSS2: Fix def_disp module param description

Janorkar, Mayuresh (2):
      OMAPFB: Adding a check for timings in set_def_mode
      OMAP: OMAPFB: Adding help for FB_OMAP_LCD_VGA option

Jarkko Nikula (1):
      omapfb: Fix linker error in drivers/video/omap/lcd_2430sdp.c

K, Mythri P (1):
      OMAP4: HDMI: Add HDMI structure in the board file for OMAP4 PANDA

Mayuresh Janorkar (2):
      OMAP2PLUS: DSS2: Add OMAP4 Kconfig support
      OMAP4: DSS2: Add hwmod device names for OMAP4.

Murthy, Raghuveer (5):
      OMAP: DSS2: Adding dss_features for independent core clk divider
      OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
      OMAP4: DSS2: Using dss_features to set independent core clock divider
      OMAP: DSS2: Implement OMAP4 DSS fclk support
      OMAP4: PandaBoard: Adding DVI support

Mythri P K (9):
      OMAP4: DSS2: Add display type HDMI to DSS2
      OMAP4: DSS2: HDMI: Select between HDMI VENC clock source.
      OMAP4: DSS2: HDMI: Dispc gamma enable set/reset function for TV.
      OMAP4: DSS2: HDMI: HDMI driver header file addition
      OMAP4: DSS2: HDMI: HDMI driver addition in the DSS
      OMAP4: DSS2: HDMI: HDMI panel driver addition in the DSS
      OMAP4: DSS2: HDMI: Add makefile and kconfig changes to enable HDMI in OMAP4
      OMAP4: DSS: HDMI: Call to HDMI module init to register driver.
      OMAP4: HDMI: Add HDMI structure in the board file for OMAP4 SDP

Samreen (1):
      OMAP2/3/4: DSS2: Enable Display SubSystem as modules

Semwal, Sumit (2):
      OMAP2PLUS:DSS2: add opt_clock_available in pdata
      OMAP2PLUS:DSS2: Use opt_clock_available from pdata

Senthilvadivu Guruswamy (9):
      OMAP2,3: DSS2: Build omap_device for each DSS HWIP
      OMAP2, 3: DSS2: DSS: create platform_driver, move init, exit to driver
      OMAP2, 3: DSS2: Move clocks from core driver to dss driver
      OMAP2, 3: DSS2: RFBI: create platform_driver, move init, exit to driver
      OMAP2, 3: DSS2: DISPC: create platform_driver, move init, exit to driver
      OMAP2, 3: DSS2: VENC: create platform_driver, move init, exit to driver
      OMAP2, 3: DSS2: DSI: create platform_driver, move init, exit to driver
      OMAP2,3: DSS2: Use platform device to get baseaddr
      OMAP2,3: DSS2: Get DSS IRQ from platform device

Steve Sakoman (5):
      OMAP: DSS2: Add support for LG Philips LB035Q02 panel
      OMAP: DSS2: Add DSS2 support for Overo
      omap: overo: Add regulator for ads7846
      OMAP: Add gpio-leds support for Overo
      OMAP: Add gpio-keys support for Overo

Sumit Semwal (4):
      OMAP2, 3: DSS2: remove forced clk-disable from omap_dss_remove
      OMAP2,3: DSS2: replace printk with dev_dbg in init
      OMAP2PLUS: clocks: Align DSS clock names and roles
      OMAP4: DSS2: clocks: Add ick as dummy clock

Taneja, Archit (5):
      OMAP2PLUS: DSS2: Cleanup clock source related code
      OMAP4: DSS2: Clock source changes for OMAP4
      OMAP2PLUS: DSS2: FEATURES: Fix usage of dss_reg_field and dss_clk_source_name
      OMAP: DSS2: FEATURES: Functions to return min and max values of parameters
      OMAP: DSS2: FEATURES: DSI PLL parameter cleanup

Tomi Valkeinen (25):
      OMAP: 3430SDP: Remove unused vdda_dac supply
      OMAP: DSS2: Delay regulator_get() calls
      OMAP: DSS2: Support for Samsung LTE430WQ-F0C
      MAINTAINERS: Update OMAP DSS maintainer
      OMAP: DSS2: Clean up a switch-case
      OMAP: DSS2: FEATURES: Remove SDI from 3630 displays
      OMAP: DSS2: FEATURES: Remove DSI & SDI from OMAP2
      OMAP: DSS2: Check for SDI HW before accessing SDI registers
      OMAP: DSS2: Remove unused list
      OMAP: DSS2: DSI: remove unused function
      OMAP: DSS2: Remove FB_OMAP_BOOTLOADER_INIT support
      OMAP: DSS2: Remove pdev argument from dpi_init
      OMAP: DSS2: Move DPI & SDI init into DSS plat driver
      OMAP: DSS2: Remove unneeded cpu_is_xxx checks
      HACK: OMAP: DSS2: Fix OMAP2_DSS_USE_DSI_PLL
      HACK: OMAP: DSS2: add delay after enabling clocks
      OMAP: DSS2: fix omap_dispc_register_isr() fail path
      HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 to prevent crash
      OMAP: DSS2: DSI: Restructure IRQ handler
      OMAP: DSS2: DSI: Add ISR support
      OMAP: DSS2: DSI: use ISR in send_bta_sync
      OMAP: DSS2: DSI: use ISR for BTA in framedone
      OMAP: DSS2: DSI: catch DSI errors in send_bta_sync
      OMAP: DSS2: DSI: fix IRQ debug prints
      OMAP: DSS2: Clean up for dpll4_m4_ck handling

archit taneja (1):
      OMAP: DSS2: Have separate irq handlers for DISPC and DSI

 MAINTAINERS                                        |    4 +-
 arch/arm/configs/omap2plus_defconfig               |   11 +
 arch/arm/mach-omap2/board-3430sdp.c                |    6 +-
 arch/arm/mach-omap2/board-4430sdp.c                |   75 ++
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   12 +-
 arch/arm/mach-omap2/board-igep0020.c               |   10 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   12 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   12 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    3 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   12 +-
 arch/arm/mach-omap2/board-omap4panda.c             |  203 +++-
 arch/arm/mach-omap2/board-overo.c                  |  357 +++++-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c       |   12 +-
 arch/arm/mach-omap2/clock2420_data.c               |    8 +-
 arch/arm/mach-omap2/clock2430_data.c               |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |   14 +-
 arch/arm/mach-omap2/clock44xx_data.c               |   15 +-
 arch/arm/mach-omap2/display.c                      |   80 ++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   13 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   12 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   23 +-
 arch/arm/plat-omap/include/plat/display.h          |   15 +-
 drivers/video/omap/Kconfig                         |    7 +-
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 drivers/video/omap2/displays/panel-generic-dpi.c   |   25 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  279 ++++
 drivers/video/omap2/displays/panel-taal.c          |  123 +-
 drivers/video/omap2/dss/Kconfig                    |   14 +-
 drivers/video/omap2/dss/Makefile                   |    2 +
 drivers/video/omap2/dss/core.c                     |  480 +-------
 drivers/video/omap2/dss/dispc.c                    |  335 ++++--
 drivers/video/omap2/dss/display.c                  |   35 +-
 drivers/video/omap2/dss/dpi.c                      |   45 +-
 drivers/video/omap2/dss/dsi.c                      |  967 +++++++++++----
 drivers/video/omap2/dss/dss.c                      |  763 +++++++++--
 drivers/video/omap2/dss/dss.h                      |  153 ++-
 drivers/video/omap2/dss/dss_features.c             |  163 ++-
 drivers/video/omap2/dss/dss_features.h             |   27 +
 drivers/video/omap2/dss/hdmi.c                     | 1332 ++++++++++++++++++++
 drivers/video/omap2/dss/hdmi.h                     |  415 ++++++
 drivers/video/omap2/dss/hdmi_omap4_panel.c         |  222 ++++
 drivers/video/omap2/dss/manager.c                  |   13 +-
 drivers/video/omap2/dss/overlay.c                  |   10 +-
 drivers/video/omap2/dss/rfbi.c                     |  128 ++-
 drivers/video/omap2/dss/sdi.c                      |   62 +-
 drivers/video/omap2/dss/venc.c                     |  128 ++-
 drivers/video/omap2/omapfb/Kconfig                 |    6 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |   23 +-
 51 files changed, 5323 insertions(+), 1362 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
 create mode 100644 drivers/video/omap2/dss/hdmi.c
 create mode 100644 drivers/video/omap2/dss/hdmi.h
 create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c


