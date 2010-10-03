From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: SCM/McBSP/clock: branch integration patches for
 2.6.37
Date: Sat, 2 Oct 2010 20:11:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010022010190.22941@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57648 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab0JCCLx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 22:11:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello Tony,

The following changes since commit 7ad0e386d46e9edff64705ab25337ad9130baf63:

  OMAP2+: defconfig: disable CPUfreq (2010-09-29 10:39:02 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 control_mcbsp_fix_2.6.37

Paul Walmsley (10):
      OMAP2+: Kconfig: disallow builds for boards that don't use the currently-selected SoC
      OMAP2420: CTRL: fix OMAP242X_CTRL_REGADDR macro
      OMAP2420: clock: add MCBSP_CLKS node and clkdev aliases
      OMAP2430: clock: add MCBSP_CLKS node and clkdev aliases
      OMAP3xxx: clock: add clkdev aliases for McBSP fclk source switching
      OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c
      OMAP: McBSP: implement functional clock switching via clock framework
      OMAP: split plat-omap/common.c
      OMAP: control: move plat-omap/control.h to mach-omap2/control.h
      OMAP2+: clock: reduce the amount of standard debugging while disabling unused clocks

 arch/arm/mach-omap2/Kconfig                        |    6 +-
 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    2 +-
 arch/arm/mach-omap2/board-apollon.c                |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    2 +-
 arch/arm/mach-omap2/board-generic.c                |   16 +-
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-ldp.c                    |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c             |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    4 +-
 arch/arm/mach-omap2/clock.c                        |    2 +-
 arch/arm/mach-omap2/clock2420_data.c               |   40 +++-
 arch/arm/mach-omap2/clock2430_data.c               |   64 ++++-
 arch/arm/mach-omap2/clock3xxx_data.c               |   12 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
 arch/arm/mach-omap2/common.c                       |  138 +++++++++
 arch/arm/mach-omap2/control.c                      |    3 +-
 .../include/plat => mach-omap2}/control.h          |   18 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    2 +-
 arch/arm/mach-omap2/devices.c                      |    3 +-
 arch/arm/mach-omap2/hsmmc.c                        |    2 +-
 arch/arm/mach-omap2/id.c                           |    3 +-
 arch/arm/mach-omap2/mcbsp.c                        |   83 ++++++
 arch/arm/mach-omap2/mux.c                          |    8 +-
 arch/arm/mach-omap2/pm24xx.c                       |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/prcm.c                         |    2 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 arch/arm/mach-omap2/sleep34xx.S                    |    2 +-
 arch/arm/mach-omap2/usb-fs.c                       |    6 +-
 arch/arm/plat-omap/32ksynctimer.c                  |  184 ++++++++++++
 arch/arm/plat-omap/Makefile                        |    2 +-
 arch/arm/plat-omap/clock.c                         |    5 +-
 arch/arm/plat-omap/common.c                        |  291 --------------------
 arch/arm/plat-omap/devices.c                       |    1 -
 arch/arm/plat-omap/include/plat/mcbsp.h            |   22 ++
 arch/arm/plat-omap/include/plat/omap24xx.h         |    2 +-
 arch/arm/plat-omap/mcbsp.c                         |    3 -
 arch/arm/plat-omap/sram.c                          |    3 -
 drivers/usb/gadget/omap_udc.c                      |   18 +-
 sound/soc/omap/omap-mcbsp.c                        |  119 ++------
 43 files changed, 633 insertions(+), 459 deletions(-)
 create mode 100644 arch/arm/mach-omap2/common.c
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/control.h (97%)
 create mode 100644 arch/arm/plat-omap/32ksynctimer.c


- Paul
