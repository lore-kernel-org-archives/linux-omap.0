From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Mon, 24 Jan 2011 14:21:18 +0530
Message-ID: <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38251 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab1AXIvn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:51:43 -0500
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

This patch moves SCU register defines from smp_scu.c to smp_scu.h
so that its available for platforms to use

The SCU CPU power status registers is used for power management
on OMAP4.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp_scu.h |    6 ++++++
 arch/arm/kernel/smp_scu.c      |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 2376835..b6f42c9 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -1,6 +1,12 @@
 #ifndef __ASMARM_ARCH_SCU_H
 #define __ASMARM_ARCH_SCU_H
 
+#define SCU_CTRL		0x00
+#define SCU_CONFIG		0x04
+#define SCU_CPU_STATUS		0x08
+#define SCU_INVALIDATE		0x0c
+#define SCU_FPGA_REVISION	0x10
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 9ab4149..ee7bf47 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -14,12 +14,6 @@
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>
 
-#define SCU_CTRL		0x00
-#define SCU_CONFIG		0x04
-#define SCU_CPU_STATUS		0x08
-#define SCU_INVALIDATE		0x0c
-#define SCU_FPGA_REVISION	0x10
-
 /*
  * Get the number of CPU cores from the SCU configuration
  */
-- 
1.6.0.4

