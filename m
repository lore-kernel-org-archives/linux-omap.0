From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Omap3 updates for 2.6.29 merge window
Date: Fri, 05 Dec 2008 12:00:01 -0800
Message-ID: <20081205195846.31125.21080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64717 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597AbYLEUAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 15:00:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are some updates for omap3 for review. 

Regards,

Tony

---

Arun KS (1):
      ARM: OMAP3: Pin multiplexing updates for 24xx and 34xx

Grazvydas Ignotas (1):
      ARM: OMAP3: Add basic support for Pandora handheld console

Jarkko Nikula (1):
      ARM: OMAP3: Add OMAP34xx pin multiplexing into I2C bus registration helper

Santosh Shilimkar (1):
      ARM: OMAP3: DMA: Fix for sDMA Errata 1.113

Stanley.Miao (1):
      ARM: OMAP3: LDP: Add Ethernet device support to make ldp boot succeess

Tony Lindgren (1):
      ARM: OMAP3: Warn about spurious interrupts


 arch/arm/configs/omap3_pandora_defconfig    | 1409 +++++++++++++++++++++++++++
 arch/arm/configs/omap_ldp_defconfig         |  148 +++
 arch/arm/mach-omap2/Kconfig                 |    4 
 arch/arm/mach-omap2/Makefile                |    1 
 arch/arm/mach-omap2/board-ldp.c             |   57 +
 arch/arm/mach-omap2/board-omap3pandora.c    |  281 +++++
 arch/arm/mach-omap2/irq.c                   |   39 +
 arch/arm/mach-omap2/mux.c                   |   44 +
 arch/arm/plat-omap/dma.c                    |   15 
 arch/arm/plat-omap/i2c.c                    |   55 +
 arch/arm/plat-omap/include/mach/board-ldp.h |    5 
 arch/arm/plat-omap/include/mach/mux.h       |   41 +
 12 files changed, 2076 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/configs/omap3_pandora_defconfig
 create mode 100644 arch/arm/mach-omap2/board-omap3pandora.c

-- 
Signature
