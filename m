From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] Omap fixes for 2.6.30-rc1
Date: Tue, 14 Apr 2009 14:47:47 -0700
Message-ID: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54819 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZDNVr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:47:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Huang Weiyi (1):
      ARM: OMAP3: remove duplicated #include

Jarkko Nikula (1):
      ARM: OMAP2: Remove defines and resource init for OMAP24XX EAC

Kevin Hilman (1):
      ARM: OMAP2/3: GPIO: do not attempt to wake-enable

Ladislav Michl (3):
      ARM: OMAP1: Fix mmc_set_power GPIO usage
      ARM: OMAP1: Simplify board-h2 MMC setup
      ARM: OMAP: MMC: Remove unused power_pin

Roel Kluin (1):
      ARM: OMAP2: possible division by 0

Roger Quadros (2):
      ARM: OMAP3: Clean up spurious interrupt check logic
      ARM: OMAP3: Fixed spurious IRQ issue for GPIO interrupts

Santosh Shilimkar (1):
      ARM: OMAP: Fix for possible race condition in omap_free_dma()

Tony Lindgren (1):
      ARM: OMAP: Remove old dead gpio expander code


 arch/arm/mach-omap1/board-h2-mmc.c             |   14 +--
 arch/arm/mach-omap1/board-h3-mmc.c             |    6 -
 arch/arm/mach-omap1/board-h3.c                 |  101 ------------------------
 arch/arm/mach-omap1/board-nokia770.c           |    6 -
 arch/arm/mach-omap2/board-h4.c                 |   95 -----------------------
 arch/arm/mach-omap2/board-rx51.c               |    1 
 arch/arm/mach-omap2/devices.c                  |   33 --------
 arch/arm/mach-omap2/irq.c                      |    4 -
 arch/arm/mach-omap2/usb-tusb6010.c             |    2 
 arch/arm/plat-omap/dma.c                       |   13 +--
 arch/arm/plat-omap/gpio.c                      |   20 ++---
 arch/arm/plat-omap/include/mach/eac.h          |  100 ------------------------
 arch/arm/plat-omap/include/mach/gpioexpander.h |   35 --------
 arch/arm/plat-omap/include/mach/irda.h         |    4 -
 arch/arm/plat-omap/include/mach/mmc.h          |    1 
 drivers/mmc/host/omap.c                        |    2 
 16 files changed, 24 insertions(+), 413 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/eac.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpioexpander.h

-- 
Signature
