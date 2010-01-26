From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/14] omap DEBUG_LL and multiboot changes for 2.6.34
Date: Tue, 26 Jan 2010 12:12:31 -0800
Message-ID: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57690 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0AZUMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

These patches clean up the DEBUG_LL code for mach-omap1 and mach-omap2
and then makes multiboot work for mach-omap2.

Note that these patches currently allow only multiboot for 2420 + 36xx.
Adding 2430 and omap4 needs further work.

Also note that in order to boot multiomap configuration on 2420,
CONFIG_CPU_32v6K must not be set as posted earlier in patch:

http://lists.arm.linux.org.uk/lurker/message/20100126.193748.e3787171.en.html

Regards,

Tony


---

Tony Lindgren (14):
      omap: Clean the serial port defines
      omap: Make uncompress code and DEBUG_LL code generic
      omap: Remove old DEBUG_LL serial port options
      omap2/3: Make get_irqnr_and_base common for mach-omap2 multiboot
      omap2/3: Multiboot compile fixes to compile in omap2 and omap3
      omap: Fix dmtimer.c for multi-omap boot
      omap2/3/4: Fix omap2_map_common_io for multi-omap
      omap2/3/4: Fix mbox init for multi-omap
      omap2: Convert ARCH_OMAP24XX to ARCH_OMAP2
      omap3: Replace ARCH_OMAP34XX with ARCH_OMAP3
      omap2/3/4: Replace orred CONFIG_ARCH_OMAP2/3/4 with CONFIG_ARCH_OMAP2PLUS
      omap2/3: Fix initcalls for multi-omap
      omap2/3: Fix powerdomain init for multiomap
      omap2/3: Update omap3_defconfig to build in all the 2420 based boards


 arch/arm/configs/omap3_defconfig               |  174 ++++++++++++++++++-----
 arch/arm/mach-omap1/include/mach/debug-macro.S |   88 ++++++++++--
 arch/arm/mach-omap1/serial.c                   |    6 -
 arch/arm/mach-omap2/Kconfig                    |   55 +++----
 arch/arm/mach-omap2/Makefile                   |   10 +
 arch/arm/mach-omap2/board-2430sdp.c            |    2 
 arch/arm/mach-omap2/board-3430sdp.c            |    2 
 arch/arm/mach-omap2/board-3630sdp.c            |    4 -
 arch/arm/mach-omap2/board-4430sdp.c            |    2 
 arch/arm/mach-omap2/board-am3517evm.c          |    2 
 arch/arm/mach-omap2/board-apollon.c            |    2 
 arch/arm/mach-omap2/board-cm-t35.c             |    2 
 arch/arm/mach-omap2/board-generic.c            |    2 
 arch/arm/mach-omap2/board-h4.c                 |    2 
 arch/arm/mach-omap2/board-igep0020.c           |    2 
 arch/arm/mach-omap2/board-ldp.c                |    2 
 arch/arm/mach-omap2/board-n8x0.c               |    2 
 arch/arm/mach-omap2/board-omap3beagle.c        |    2 
 arch/arm/mach-omap2/board-omap3evm.c           |    2 
 arch/arm/mach-omap2/board-omap3pandora.c       |    2 
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 
 arch/arm/mach-omap2/board-overo.c              |    2 
 arch/arm/mach-omap2/board-rx51.c               |    2 
 arch/arm/mach-omap2/board-zoom2.c              |    2 
 arch/arm/mach-omap2/board-zoom3.c              |    4 -
 arch/arm/mach-omap2/clock.c                    |   26 +++
 arch/arm/mach-omap2/clock.h                    |   35 +++++
 arch/arm/mach-omap2/clock2xxx.c                |    6 -
 arch/arm/mach-omap2/clock2xxx_data.c           |    4 -
 arch/arm/mach-omap2/clock34xx.c                |    6 -
 arch/arm/mach-omap2/clock34xx_data.c           |    4 -
 arch/arm/mach-omap2/clock44xx.c                |    4 -
 arch/arm/mach-omap2/clock44xx_data.c           |    4 -
 arch/arm/mach-omap2/clockdomains.h             |   12 +-
 arch/arm/mach-omap2/devices.c                  |   30 +++-
 arch/arm/mach-omap2/emu.c                      |    3 
 arch/arm/mach-omap2/include/mach/debug-macro.S |  130 +++++++++++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S |   77 ++++++++--
 arch/arm/mach-omap2/io.c                       |   68 ++++++---
 arch/arm/mach-omap2/mcbsp.c                    |    2 
 arch/arm/mach-omap2/mux.c                      |    6 -
 arch/arm/mach-omap2/mux.h                      |    2 
 arch/arm/mach-omap2/omap_hwmod_34xx.h          |    2 
 arch/arm/mach-omap2/opp2xxx.h                  |    5 +
 arch/arm/mach-omap2/powerdomains.h             |   25 ++-
 arch/arm/mach-omap2/powerdomains24xx.h         |    4 -
 arch/arm/mach-omap2/powerdomains34xx.h         |    4 -
 arch/arm/mach-omap2/serial.c                   |   15 +-
 arch/arm/plat-omap/Kconfig                     |   40 ++---
 arch/arm/plat-omap/common.c                    |   31 ++++
 arch/arm/plat-omap/devices.c                   |    2 
 arch/arm/plat-omap/dma.c                       |    3 
 arch/arm/plat-omap/dmtimer.c                   |  102 ++++++--------
 arch/arm/plat-omap/gpio.c                      |   76 ++++------
 arch/arm/plat-omap/i2c.c                       |    8 +
 arch/arm/plat-omap/include/plat/clock.h        |    6 -
 arch/arm/plat-omap/include/plat/common.h       |    6 +
 arch/arm/plat-omap/include/plat/control.h      |    3 
 arch/arm/plat-omap/include/plat/cpu.h          |   14 +-
 arch/arm/plat-omap/include/plat/io.h           |   33 ++++
 arch/arm/plat-omap/include/plat/mcbsp.h        |    9 +
 arch/arm/plat-omap/include/plat/memory.h       |    3 
 arch/arm/plat-omap/include/plat/menelaus.h     |    2 
 arch/arm/plat-omap/include/plat/mux.h          |    2 
 arch/arm/plat-omap/include/plat/omap16xx.h     |   74 +++++-----
 arch/arm/plat-omap/include/plat/omap24xx.h     |    6 -
 arch/arm/plat-omap/include/plat/omap34xx.h     |    6 -
 arch/arm/plat-omap/include/plat/serial.h       |   70 ++++++---
 arch/arm/plat-omap/include/plat/uncompress.h   |  181 ++++++++++++++++++------
 arch/arm/plat-omap/mcbsp.c                     |    6 -
 arch/arm/plat-omap/sram.c                      |    2 
 drivers/char/hw_random/Kconfig                 |    2 
 drivers/mfd/Kconfig                            |    2 
 drivers/net/smc911x.h                          |    4 -
 drivers/spi/Kconfig                            |    2 
 drivers/spi/omap2_mcspi.c                      |    2 
 drivers/usb/Kconfig                            |    2 
 drivers/usb/host/ehci-hcd.c                    |    2 
 drivers/usb/musb/Kconfig                       |    6 -
 drivers/usb/musb/musb_core.c                   |    2 
 drivers/usb/musb/musb_core.h                   |    2 
 drivers/w1/masters/Kconfig                     |    2 
 drivers/watchdog/Kconfig                       |    2 
 sound/soc/omap/omap-mcbsp.c                    |    6 -
 sound/soc/omap/omap-mcbsp.h                    |    2 
 85 files changed, 1050 insertions(+), 524 deletions(-)

-- 
Signature
