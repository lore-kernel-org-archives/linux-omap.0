From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] omap3 board updates for merge window after 2.6.30
Date: Mon, 25 May 2009 10:46:58 -0700
Message-ID: <20090525174517.19679.18805.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65240 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbZEYRrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:47:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap3 board specific patches for the upcoming merge
window. It adds two new boards, and starts converting MMC to
use the regulator framework.

Regards,

Tony

---

Adrian Hunter (1):
      ARM: OMAP3: RX51: Connect VAUX3 to MMC2

David Brownell (2):
      ARM: OMAP3: Initialize regulators for Beagle and Overo
      ARM: OMAP3: mmc-twl4030 uses regulator framework

Grazvydas Ignotas (1):
      ARM: OMAP3: pandora: setup regulator framework for MMC

Syed Mohammed Khasim (2):
      ARM: OMAP3: Add omap3 EVM defconfig
      ARM: OMAP3: Add omap3 EVM support

Vikram Pandita (2):
      ARM: OMAP3: Defconfig for Zoom2 board
      ARM: OMAP3: Add support for OMAP3 Zoom2 board


 arch/arm/configs/omap3_evm_defconfig         | 1528 ++++++++++++++++++++++++++
 arch/arm/configs/omap_zoom2_defconfig        | 1211 +++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                  |    8 
 arch/arm/mach-omap2/Makefile                 |    6 
 arch/arm/mach-omap2/board-omap3beagle.c      |  104 ++
 arch/arm/mach-omap2/board-omap3evm.c         |  329 ++++++
 arch/arm/mach-omap2/board-omap3pandora.c     |   45 +
 arch/arm/mach-omap2/board-overo.c            |   76 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   30 -
 arch/arm/mach-omap2/board-zoom-debugboard.c  |  160 +++
 arch/arm/mach-omap2/board-zoom2.c            |  110 ++
 arch/arm/mach-omap2/mmc-twl4030.c            |  280 ++---
 arch/arm/mach-omap2/mmc-twl4030.h            |    3 
 drivers/mmc/host/omap_hsmmc.c                |    6 
 14 files changed, 3693 insertions(+), 203 deletions(-)
 create mode 100644 arch/arm/configs/omap3_evm_defconfig
 create mode 100644 arch/arm/configs/omap_zoom2_defconfig
 create mode 100644 arch/arm/mach-omap2/board-omap3evm.c
 create mode 100644 arch/arm/mach-omap2/board-zoom-debugboard.c
 create mode 100644 arch/arm/mach-omap2/board-zoom2.c

-- 
Signature
