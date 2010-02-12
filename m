From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/19] omap updates for 2.6.34 merge window, part 2
Date: Thu, 11 Feb 2010 16:51:05 -0800
Message-ID: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50946 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab0BLAuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here is part 2 of the omap updates for 2.6.34. The MMC low-level
init patches have been already posted to linux-omap and linux-mmc.

Regards,

Tony

---

Adrian Hunter (10):
      omap_hsmmc: Move gpio and regulator control from board file
      omap: Rename mmc-twl4030 files to hsmmc
      omap: Rename hsmmc symbols to reflect independence from twl4030
      omap: Reconnect hsmmc context loss count
      omap: RX51: Remux to pull eMMC lines down when powering off
      omap_hsmmc: Allow for power saving without going off
      omap_hsmmc: Fix disable timeouts
      omap_hsmmc: Ensure regulator enable / disable are paired
      omap_hsmmc: Allow for a shared VccQ
      omap_hsmmc: allow compile without regulator framework

Felipe Balbi (1):
      arm: omap: kill compile warning on board-4430-sdp.c

Jorge Eduardo Candelaria (3):
      OMAP4: IRQ: Add McPDM IRQ definition
      ARM: OMAP4: Add McPDM base address
      OMAP4: MCPDM: Register McPDM platform device

Lesly A M (1):
      omap3: pm: Add T2 Keypad as a wakeup source

Tony Lindgren (1):
      omap3: Clean-up for omap_mux_init

Vaibhav Hiremath (3):
      AM35xx: Introduce am35xx.h file
      AM35xx: Add AM35xx intr_clr & sw_rst cntrl reg bit definition
      AM35xx: Update irq.h for AM35xx IPSS module interrupts


 arch/arm/configs/rx51_defconfig              |    4 
 arch/arm/mach-omap2/Makefile                 |   28 +
 arch/arm/mach-omap2/board-2430sdp.c          |    6 
 arch/arm/mach-omap2/board-3430sdp.c          |    6 
 arch/arm/mach-omap2/board-4430sdp.c          |    4 
 arch/arm/mach-omap2/board-am3517evm.c        |    1 
 arch/arm/mach-omap2/board-cm-t35.c           |    6 
 arch/arm/mach-omap2/board-igep0020.c         |    6 
 arch/arm/mach-omap2/board-ldp.c              |    6 
 arch/arm/mach-omap2/board-omap3beagle.c      |    6 
 arch/arm/mach-omap2/board-omap3evm.c         |    6 
 arch/arm/mach-omap2/board-omap3pandora.c     |    6 
 arch/arm/mach-omap2/board-omap3touchbook.c   |    6 
 arch/arm/mach-omap2/board-overo.c            |    6 
 arch/arm/mach-omap2/board-rx51-peripherals.c |   63 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |   15 +
 arch/arm/mach-omap2/hsmmc.c                  |  266 +++++++++++++
 arch/arm/mach-omap2/hsmmc.h                  |   14 -
 arch/arm/mach-omap2/include/mach/am35xx.h    |   26 +
 arch/arm/mach-omap2/mmc-twl4030.c            |  542 --------------------------
 arch/arm/mach-omap2/mux.c                    |   46 ++
 arch/arm/plat-omap/devices.c                 |   37 ++
 arch/arm/plat-omap/include/plat/control.h    |   17 +
 arch/arm/plat-omap/include/plat/irqs.h       |   12 +
 arch/arm/plat-omap/include/plat/mmc.h        |   35 +-
 arch/arm/plat-omap/include/plat/omap44xx.h   |    2 
 drivers/mmc/host/omap_hsmmc.c                |  400 ++++++++++++++++++-
 27 files changed, 920 insertions(+), 652 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hsmmc.c
 rename arch/arm/mach-omap2/{mmc-twl4030.h => hsmmc.h} (63%)
 create mode 100644 arch/arm/mach-omap2/include/mach/am35xx.h
 delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.c

-- 
Signature
