From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/19] omap-fixes for 2.6.34-rc1
Date: Thu, 11 Mar 2010 15:48:00 -0800
Message-ID: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52124 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab0CKXqk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:46:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's some omap fixes for review.

I also threw in the n8x0 platform init for tusb6010 and
updated the defconfig as those were needed to fix and test
the tusb6010 for the DMA API changes as posted earlier.

Regards,

Tony

---

Aaro Koskinen (2):
      omap: pass the reboot command to the boot loader
      omap: mach-omap2/io.c: fix function declarations

Andrea Gelmini (1):
      omap: Checkpatch cleanup for blizzard.h

Andrew Clayton (1):
      ARM/OMAP: Remove the +x bit from a couple of source files

Enric Balletbo i Serra (1):
      omap3: Fix support for the LEDs connected to GPIO outputs on IGEP v2board

Felipe Balbi (1):
      omap2/3/4: ehci: avoid compiler error with touchbook

Francisco Alecrim (1):
      omap2: add USB initialization for tusb6010

Grazvydas Ignotas (1):
      omap3: pandora: add missing i2c3 board_info

Janusz Krzysztofik (1):
      omap: McBSP: Drop unnecessary status/error bit clearing on reg_cacheretrieved register values

Kevin Hilman (2):
      OMAP2: cpu_is_omap2*: fix compile-time removal of unused code
      OMAP4: fix temporary hacks that break multi-omap PM

Santosh Shilimkar (1):
      omap4: Fix build break by moving omap_smc1 into a separate .S

Suman Anna (1):
      omap2/3/4: mailbox: remove compiler warning

Thomas Weber (1):
      OMAP2: serial.c: Fix number of uarts in early_init

Tony Lindgren (4):
      omap3: Fix compile for Touch Book early_param
      omap2: Update n8x0 defconfig to test multi-omap and DMA api changes
      omap: Enable PM_RUNTIME in defconfigs to avoid USB compile errors
      omap: Fix gpio_resume_after_retention

Vaibhav Hiremath (1):
      omap: Add DSI regulator supply to OMAP3EVM board file


 arch/arm/configs/cm_t35_defconfig            |    2 
 arch/arm/configs/n770_defconfig              |    1 
 arch/arm/configs/n8x0_defconfig              |  160 +++++++++++++++++++++++---
 arch/arm/configs/omap3_beagle_defconfig      |    1 
 arch/arm/configs/omap3_defconfig             |    2 
 arch/arm/configs/omap3_evm_defconfig         |    1 
 arch/arm/configs/omap3_touchbook_defconfig   |    2 
 arch/arm/configs/omap_3430sdp_defconfig      |    1 
 arch/arm/configs/omap_3630sdp_defconfig      |    2 
 arch/arm/configs/omap_h2_1610_defconfig      |    1 
 arch/arm/configs/omap_zoom2_defconfig        |    1 
 arch/arm/configs/omap_zoom3_defconfig        |    2 
 arch/arm/configs/rx51_defconfig              |    1 
 arch/arm/mach-omap2/Makefile                 |    3 
 arch/arm/mach-omap2/board-3430sdp.c          |    2 
 arch/arm/mach-omap2/board-3630sdp.c          |    2 
 arch/arm/mach-omap2/board-4430sdp.c          |   26 ----
 arch/arm/mach-omap2/board-am3517evm.c        |    2 
 arch/arm/mach-omap2/board-cm-t35.c           |    2 
 arch/arm/mach-omap2/board-devkit8000.c       |    2 
 arch/arm/mach-omap2/board-igep0020.c         |   56 ++++++---
 arch/arm/mach-omap2/board-n8x0.c             |   98 ++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 
 arch/arm/mach-omap2/board-omap3evm.c         |   18 ++-
 arch/arm/mach-omap2/board-omap3pandora.c     |   12 ++
 arch/arm/mach-omap2/board-omap3touchbook.c   |   12 +-
 arch/arm/mach-omap2/board-overo.c            |    2 
 arch/arm/mach-omap2/board-zoom-peripherals.c |    0 
 arch/arm/mach-omap2/board-zoom3.c            |    2 
 arch/arm/mach-omap2/clock2420_data.c         |    1 
 arch/arm/mach-omap2/io.c                     |   21 ++-
 arch/arm/mach-omap2/mailbox.c                |   12 +-
 arch/arm/mach-omap2/omap44xx-smc.S           |   32 +++++
 arch/arm/mach-omap2/prcm.c                   |    4 -
 arch/arm/mach-omap2/serial.c                 |   15 ++
 arch/arm/mach-omap2/usb-ehci.c               |    6 -
 arch/arm/plat-omap/gpio.c                    |   10 +-
 arch/arm/plat-omap/include/plat/blizzard.h   |    2 
 arch/arm/plat-omap/include/plat/cpu.h        |    8 +
 arch/arm/plat-omap/include/plat/prcm.h       |    2 
 arch/arm/plat-omap/include/plat/system.h     |    6 -
 arch/arm/plat-omap/include/plat/usb.h        |    2 
 arch/arm/plat-omap/mcbsp.c                   |   12 +-
 43 files changed, 414 insertions(+), 137 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
 create mode 100644 arch/arm/mach-omap2/omap44xx-smc.S

-- 
Signature
