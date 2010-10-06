From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] OMAP: SCM/McBSP/clock: branch integration patches for
 2.6.37
Date: Wed, 6 Oct 2010 13:02:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010061259490.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37838 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab0JFTCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 15:02:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-kernel@lists.infradead.org

Hello Tony,

Here is an updated pull request for the ten original patches sent earlier, 
with recent Acked-by:'s added, and also with Jarkko's three fix patches:

The following changes since commit dbd3ad5354dbbe3f4ea7c0675d91475c25280f69:

  omap: hwmod: Handle modules with 16bit registers (2010-10-06 10:18:04 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 control_mcbsp_fix_2.6.37

Jarkko Nikula (3):
      OMAP: McBSP: Fix CLKR and FSR signal muxing
      OMAP: McBSP: Swap CLKS source definition
      OMAP: McBSP: Remove null omap44xx ops comment

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
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
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
 arch/arm/mach-omap2/clock2430_data.c               |   64 +++++-
 arch/arm/mach-omap2/clock3xxx_data.c               |   12 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
 arch/arm/mach-omap2/common.c                       |  135 ++++++++++
 arch/arm/mach-omap2/control.c                      |    3 +-
 .../include/plat => mach-omap2}/control.h          |   18 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    2 +-
 arch/arm/mach-omap2/devices.c                      |    3 +-
 arch/arm/mach-omap2/hsmmc.c                        |    2 +-
 arch/arm/mach-omap2/id.c                           |    3 +-
 arch/arm/mach-omap2/mcbsp.c                        |   80 ++++++
 arch/arm/mach-omap2/mux.c                          |    8 +-
 arch/arm/mach-omap2/pm24xx.c                       |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/prcm.c                         |    2 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 arch/arm/mach-omap2/sleep34xx.S                    |    2 +-
 arch/arm/mach-omap2/usb-fs.c                       |    6 +-
 arch/arm/plat-omap/Makefile                        |    2 +-
 arch/arm/plat-omap/clock.c                         |    5 +-
 arch/arm/plat-omap/common.c                        |  275 --------------------
 arch/arm/plat-omap/counter_32k.c                   |  183 +++++++++++++
 arch/arm/plat-omap/devices.c                       |    1 -
 arch/arm/plat-omap/include/plat/mcbsp.h            |   22 ++
 arch/arm/plat-omap/include/plat/omap-serial.h      |    1 -
 arch/arm/plat-omap/include/plat/omap24xx.h         |    2 +-
 arch/arm/plat-omap/mcbsp.c                         |    3 -
 arch/arm/plat-omap/sram.c                          |    3 -
 drivers/usb/gadget/omap_udc.c                      |   18 +-
 sound/soc/omap/omap-mcbsp.c                        |  119 ++-------
 44 files changed, 625 insertions(+), 444 deletions(-)
 create mode 100644 arch/arm/mach-omap2/common.c
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/control.h (97%)
 create mode 100644 arch/arm/plat-omap/counter_32k.c


- Paul
