From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle inside each ARCH Kconfig
Date: Fri, 29 Jan 2010 15:43:35 +0900
Message-ID: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:60425 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab0A2GwZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 01:52:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: ben-linux@fluff.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>

Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
L1 cache lines which are 64bytes to indicate this without having to
alter the arch/arm/mm/Kconfig entry each time.

Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
uses this and change OMAP3 and S5PC1XX to select ARM_L1_CACHE_SHIFT_6.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig           |    6 ++++++
 arch/arm/mm/Kconfig        |    2 +-
 arch/arm/plat-omap/Kconfig |    1 +
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a5602ec..13c07a6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -161,6 +161,11 @@ config ARCH_MTD_XIP
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	def_bool y
 
+config ARM_L1_CACHE_SHIFT_6
+	bool
+	help
+	  Setting ARM L1 cache line size to 64 Bytes.
+
 if OPROFILE
 
 config OPROFILE_ARMV6
@@ -646,6 +651,7 @@ config ARCH_S5PC1XX
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
 	help
 	  Samsung S5PC1XX series based systems
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 91617f7..8ca9fb7 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -779,5 +779,5 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
+	default 6 if ARM_L1_CACHE_SHIFT_6
 	default 5
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e2ea04a..2e3eec6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -22,6 +22,7 @@ config ARCH_OMAP3
 	bool "TI OMAP3"
 	select CPU_V7
 	select COMMON_CLKDEV
+	select ARM_L1_CACHE_SHIFT_6
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
-- 
1.6.2.5

