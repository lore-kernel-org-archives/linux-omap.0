From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/23] Series short description
Date: Wed, 17 Feb 2010 17:31:44 -0800
Message-ID: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58372 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0BRBa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:30:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Looks like stg mail choked on a bad email addres, here's a retry.

These patches are against what I have sitting in omap-for-linus
branch in the linux-omap tree.

Regards,

Tony

---

Enric Balletbo i Serra (8):
      omap3: Add platform data for the twl4030_codec MFD on IGEP v2
      omap3: Fix typo on IGEP v2 board
      omap3: Add platform init code for EHCI driver on IGEP v2
      omap3: Enable DSS2 for IGEP v2 board
      omap3: Add support for flash on IGEP v2 board
      ARM: OMAP3: SDRC: add timing data for Numonyx M65KxxxxAM
      omap3: Use timing data for omap2_init_common_hw on IGEP v2
      omap3: Update defconfig for IGEP v2 to allow new drivers andfeatures

Grazvydas Ignotas (3):
      OMAP: pandora: add DSS2 support and related regulators
      omap3: pandora: update regulator setup
      omap3: pandora: update defconfig

Jonas Zetterberg (2):
      IGEPv2: Added WIFI support
      IGEPv2: Use Red Led1 as Heartbeat if configured

Sanjeev Premi (4):
      omap3evm: Add mux settings for keypad
      omap3evm: Fixes after moving to matrix_keypad
      omap3evm: Configure GPIO175 for touchscreen PEN_IRQ
      OMAP3EVM: PM: Update defconfig

Thomas Weber (2):
      Add minimal support for DevKit8000
      Add devkit8000_defconfig

Vaibhav Hiremath (3):
      AM3517: Enable basic I2C Support
      AM3517: Enable RTC driver support for AM3517EVM
      AM3517: Enable I2C-GPIO Expander driver support for AM3517EVM

vikram pandita (1):
      omap: zoom3: enable ehci support


 arch/arm/configs/devkit8000_defconfig          | 1889 ++++++++++++++++++++++++
 arch/arm/configs/igep0020_defconfig            |  525 ++++---
 arch/arm/configs/omap3_evm_defconfig           |    6 
 arch/arm/configs/omap3_pandora_defconfig       |  678 +++++++--
 arch/arm/mach-omap2/Kconfig                    |    6 
 arch/arm/mach-omap2/Makefile                   |    2 
 arch/arm/mach-omap2/board-am3517evm.c          |   86 +
 arch/arm/mach-omap2/board-devkit8000.c         |  691 +++++++++
 arch/arm/mach-omap2/board-igep0020.c           |  269 +++
 arch/arm/mach-omap2/board-omap3evm.c           |   33 
 arch/arm/mach-omap2/board-omap3pandora.c       |  180 ++
 arch/arm/mach-omap2/board-zoom3.c              |   14 
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h |   51 +
 13 files changed, 4020 insertions(+), 410 deletions(-)
 create mode 100644 arch/arm/configs/devkit8000_defconfig
 create mode 100644 arch/arm/mach-omap2/board-devkit8000.c
 create mode 100644 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h

-- 
Signature
