From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 22/29] ARM: omap: clk: Use plat/clock.c only for OMAP1
Date: Thu, 14 Jun 2012 18:17:11 +0530
Message-ID: <1339678038-23082-23-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53463 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930Ab2FNMsT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:48:19 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/Makefile |    3 ++-
 arch/arm/plat-omap/clock.c  |    2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index ed8605f..83c4aa3 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,12 +3,13 @@
 #
 
 # Common support
-obj-y := common.o sram.o clock.o devices.o dma.o mux.o \
+obj-y := common.o sram.o devices.o dma.o mux.o \
 	 usb.o fb.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=
 
+obj-$(CONFIG_ARCH_OMAP1) += clock.o
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index d311b7c..62ec5c4 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -10,7 +10,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef CONFIG_COMMON_CLK
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -568,4 +567,3 @@ err_out:
 late_initcall(clk_debugfs_init);
 
 #endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
-#endif /* CONFIG_COMMON_CLK */
-- 
1.7.1

