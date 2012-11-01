From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] more omap clean-up for ARCH_MULTIPLATFORM
Date: Thu, 01 Nov 2012 15:48:17 -0700
Message-ID: <20121101224703.2103.95474.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19645 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762436Ab2KAWsU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 18:48:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are patches to remove some now unnecessary code
in preparation for enabling ARCH_MULTIPLATFORM for
omap2+.

These are based on omap-for-v3.8/cleanup-headers-relative
branch.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP: Remove unnecessary mach and plat includes
      ARM: OMAP: Remove NEED_MACH_GPIO_H
      ARM: OMAP: Remove plat-omap/common.c


 arch/arm/Kconfig                        |    1 -
 arch/arm/mach-omap1/gpio15xx.c          |    2 ++
 arch/arm/mach-omap1/gpio16xx.c          |    2 ++
 arch/arm/mach-omap1/gpio7xx.c           |    2 ++
 arch/arm/mach-omap1/include/mach/gpio.h |    3 ---
 arch/arm/mach-omap2/board-2430sdp.c     |    1 -
 arch/arm/mach-omap2/board-cm-t35.c      |    2 --
 arch/arm/mach-omap2/hsmmc.c             |    1 -
 arch/arm/mach-omap2/include/mach/gpio.h |    3 ---
 arch/arm/plat-omap/Makefile             |    2 +-
 arch/arm/plat-omap/common.c             |   26 --------------------------
 arch/arm/plat-omap/debug-devices.c      |    1 -
 arch/arm/plat-omap/dma.c                |    8 ++++++++
 arch/arm/plat-omap/dmtimer.c            |    4 +---
 arch/arm/plat-omap/fb.c                 |    1 -
 arch/arm/plat-omap/i2c.c                |    2 --
 include/linux/platform_data/gpio-omap.h |    1 -
 sound/soc/omap/am3517evm.c              |    2 --
 sound/soc/omap/n810.c                   |    1 -
 sound/soc/omap/osk5912.c                |    1 -
 sound/soc/omap/sdp3430.c                |    2 --
 sound/soc/omap/zoom2.c                  |    3 ---
 22 files changed, 16 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-omap/common.c

-- 
Signature
