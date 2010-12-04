From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Create omap1_defconfig, remove other omap1 configs
Date: Sat, 04 Dec 2010 13:36:47 -0800
Message-ID: <20101204213358.32208.4195.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32167 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab0LDVgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 16:36:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This series allows us to get rid of 15 omap1 defconfigs
for various boards.

Based on the recent GPIO patches and depends on the asm_irq
patches posted earlier. For testing, it's probably easiest
to use the devel-omap1 branch in the linux-omap git tree.

Regards,

Tony

---

Tony Lindgren (4):
      omap: Disable omap_read/write functions for omap2+
      omap1: Add initcall checks for omap1 and booted board
      omap1: Add omap1_defconfig
      omap1: Delete old defconfigs


 arch/arm/configs/ams_delta_defconfig           |  121 ----------
 arch/arm/configs/htcherald_defconfig           |   73 ------
 arch/arm/configs/n770_defconfig                |  138 ------------
 arch/arm/configs/omap1_defconfig               |  286 ++++++++++++++++++++++++
 arch/arm/configs/omap_generic_1510_defconfig   |   84 -------
 arch/arm/configs/omap_generic_1610_defconfig   |   87 -------
 arch/arm/configs/omap_generic_1710_defconfig   |   75 ------
 arch/arm/configs/omap_h2_1610_defconfig        |  109 ---------
 arch/arm/configs/omap_innovator_1510_defconfig |  102 ---------
 arch/arm/configs/omap_innovator_1610_defconfig |   58 -----
 arch/arm/configs/omap_osk_5912_defconfig       |   87 -------
 arch/arm/configs/omap_perseus2_730_defconfig   |   65 -----
 arch/arm/configs/palmte_defconfig              |   48 ----
 arch/arm/configs/palmtt_defconfig              |   56 -----
 arch/arm/configs/palmz71_defconfig             |   53 ----
 arch/arm/configs/sx1_defconfig                 |  110 ---------
 arch/arm/mach-omap1/board-ams-delta.c          |    3 
 arch/arm/mach-omap1/board-voiceblue.c          |    6 +
 arch/arm/mach-omap1/devices.c                  |    3 
 arch/arm/mach-omap1/lcd_dma.c                  |    3 
 arch/arm/mach-omap1/leds.c                     |    3 
 arch/arm/mach-omap1/mcbsp.c                    |    3 
 arch/arm/mach-omap1/pm.c                       |    3 
 arch/arm/mach-omap1/pm_bus.c                   |    3 
 arch/arm/mach-omap1/serial.c                   |    3 
 arch/arm/plat-omap/include/plat/io.h           |   45 ++++
 arch/arm/plat-omap/io.c                        |   36 +--
 27 files changed, 372 insertions(+), 1291 deletions(-)
 delete mode 100644 arch/arm/configs/ams_delta_defconfig
 delete mode 100644 arch/arm/configs/htcherald_defconfig
 delete mode 100644 arch/arm/configs/n770_defconfig
 create mode 100644 arch/arm/configs/omap1_defconfig
 delete mode 100644 arch/arm/configs/omap_generic_1510_defconfig
 delete mode 100644 arch/arm/configs/omap_generic_1610_defconfig
 delete mode 100644 arch/arm/configs/omap_generic_1710_defconfig
 delete mode 100644 arch/arm/configs/omap_h2_1610_defconfig
 delete mode 100644 arch/arm/configs/omap_innovator_1510_defconfig
 delete mode 100644 arch/arm/configs/omap_innovator_1610_defconfig
 delete mode 100644 arch/arm/configs/omap_osk_5912_defconfig
 delete mode 100644 arch/arm/configs/omap_perseus2_730_defconfig
 delete mode 100644 arch/arm/configs/palmte_defconfig
 delete mode 100644 arch/arm/configs/palmtt_defconfig
 delete mode 100644 arch/arm/configs/palmz71_defconfig
 delete mode 100644 arch/arm/configs/sx1_defconfig

-- 
Signature
