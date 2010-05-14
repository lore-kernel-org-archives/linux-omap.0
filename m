From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] omap platform init patches for 2.6.35 merge window
Date: Fri, 14 May 2010 14:27:43 -0700
Message-ID: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63032 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0ENV1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:27:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap patches mostly to get some more devices
initialized.

With these the omap4 Ethernet should work, the drivers
related patches are queued too.

Regards,

Tony

---

Abraham Arce (2):
      OMAP4: Ethernet: KS8851 Board Support
      OMAP4: Networking: Defconfig Support

Mika Westerberg (1):
      OMAP2/3/4: DMA: disable channel interrupts in omap_init_dma()

Santosh Shilimkar (1):
      omap4: Move SOC specific code from board file

Syed Rafiuddin (1):
      OMAP4: SPI: Fix Driver Kconfig

Tony Lindgren (1):
      omap: GPIO: Fix OMAP4 GPIO reg access issues

manjugk manjugk (1):
      omap: DMA: Fix multi-line comments

stanley.miao (3):
      omap: init the gpio pinmux for mmc
      omap: hsmmc: fix the hsmmc driver for am3517
      AM3517: rename the i2c boardinfo to make it more readable


 arch/arm/configs/omap_4430sdp_defconfig         |   57 ++++++++++
 arch/arm/mach-omap2/Makefile                    |    2 
 arch/arm/mach-omap2/board-4430sdp.c             |  128 +++++++++++++++--------
 arch/arm/mach-omap2/board-am3517evm.c           |   20 ++--
 arch/arm/mach-omap2/devices.c                   |    9 ++
 arch/arm/mach-omap2/hsmmc.c                     |   27 ++++-
 arch/arm/mach-omap2/include/mach/omap4-common.h |   26 +++++
 arch/arm/mach-omap2/omap-smp.c                  |    2 
 arch/arm/mach-omap2/omap4-common.c              |   72 +++++++++++++
 arch/arm/plat-omap/common.c                     |    3 -
 arch/arm/plat-omap/dma.c                        |   45 ++++++--
 arch/arm/plat-omap/gpio.c                       |   59 ++++++++---
 arch/arm/plat-omap/include/plat/common.h        |    3 -
 arch/arm/plat-omap/include/plat/mmc.h           |    4 +
 drivers/spi/Kconfig                             |    6 +
 15 files changed, 362 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap4-common.h
 create mode 100644 arch/arm/mach-omap2/omap4-common.c

-- 
Signature
