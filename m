From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] New omap boards and rx51/n900 updates for 2.6.33
Date: Tue, 17 Nov 2009 15:04:44 -0800
Message-ID: <20091117230324.19869.44927.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53914 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbZKQXEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 18:04:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap patches for review for the 2.6.33 merge window.

This series mostly adds support for new boards, and updates the
rx51/n900 devices.

Regards,

Tony

---

Cory Maccarrone (2):
      omap1: Add board support and LCD for HTC Herald
      omap1: Add default kernel configuration for Herald

Enric Balletbo i Serra (2):
      omap3: Add minimal IGEP v2 support
      omap3: Add defconfig for IGEP v2 board

Kalle Valo (1):
      omap3: rx51: Add wl1251 wlan driver support

Mike Rapoport (2):
      omap3: Add CompuLab CM-T35 board support
      omap3: Add CompuLab CM-T35 defconfig

Ranjith Lohithakshan (2):
      AM35xx: Add support for AM3517 EVM board
      AM35xx: Defconfig for AM3517 EVM board

Tero Kristo (1):
      omap3: rx51: Add SDRAM init

vikram pandita (2):
      omap: 3630sdp: introduce 3630 sdp board support
      omap: 3630sdp: defconfig creation


 arch/arm/configs/am3517_evm_defconfig        | 1207 ++++++++++++++++++
 arch/arm/configs/cm_t35_defconfig            | 1733 ++++++++++++++++++++++++++
 arch/arm/configs/htcherald_defconfig         | 1142 +++++++++++++++++
 arch/arm/configs/igep0020_defconfig          | 1554 +++++++++++++++++++++++
 arch/arm/configs/omap_3630sdp_defconfig      | 1611 ++++++++++++++++++++++++
 arch/arm/mach-omap1/Kconfig                  |    6 
 arch/arm/mach-omap1/Makefile                 |    1 
 arch/arm/mach-omap1/board-htcherald.c        |  247 ++++
 arch/arm/mach-omap2/Kconfig                  |   16 
 arch/arm/mach-omap2/Makefile                 |   10 
 arch/arm/mach-omap2/board-3630sdp.c          |  101 ++
 arch/arm/mach-omap2/board-am3517evm.c        |   86 +
 arch/arm/mach-omap2/board-cm-t35.c           |  507 ++++++++
 arch/arm/mach-omap2/board-igep0020.c         |  251 ++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |   85 +
 arch/arm/mach-omap2/board-rx51-sdram.c       |  221 +++
 arch/arm/mach-omap2/board-rx51.c             |    7 
 drivers/video/omap/Makefile                  |    1 
 drivers/video/omap/lcd_htcherald.c           |  130 ++
 19 files changed, 8915 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/am3517_evm_defconfig
 create mode 100644 arch/arm/configs/cm_t35_defconfig
 create mode 100644 arch/arm/configs/htcherald_defconfig
 create mode 100644 arch/arm/configs/igep0020_defconfig
 create mode 100644 arch/arm/configs/omap_3630sdp_defconfig
 create mode 100644 arch/arm/mach-omap1/board-htcherald.c
 create mode 100755 arch/arm/mach-omap2/board-3630sdp.c
 create mode 100644 arch/arm/mach-omap2/board-am3517evm.c
 create mode 100644 arch/arm/mach-omap2/board-cm-t35.c
 create mode 100644 arch/arm/mach-omap2/board-igep0020.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-sdram.c
 create mode 100644 drivers/video/omap/lcd_htcherald.c

-- 
Signature
