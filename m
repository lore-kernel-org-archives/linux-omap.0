From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap2plus: Remove auto selection on PMICs
Date: Wed, 23 Feb 2011 17:41:12 +0530
Message-ID: <1298463072-19891-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab1BWMNA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 07:13:00 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NCCvS7006263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 06:12:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The current implementation almost assumes that only
TWL4030/TWL5030/TWl6030 are (or can be) used with the
OMAP processors. This is, however, not true.

This patch removes the automatic selection of the PMIC
from Kconfig. Current defaults are chosen in default
configuration omap2plus_defconfig and can easily be
added to configuration for any board, there should be
no compile/run-time impact.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
Compiled omap2plus-defconfig and boot tested on
OMAP3EVM Rev G.

 arch/arm/mach-omap2/Kconfig |    3 ---
 drivers/mfd/Kconfig         |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ae7f47d..9c4f903 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -16,9 +16,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select I2C
 	select I2C_OMAP
 	select MFD_SUPPORT
-	select MENELAUS if ARCH_OMAP2
-	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
-	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
 	help
 	  Compile a kernel suitable for booting most boards
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fd01836..67dcee4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -155,7 +155,7 @@ config MENELAUS
 
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
-	depends on I2C=y && GENERIC_HARDIRQS
+	depends on I2C=y && GENERIC_HARDIRQS && (ARCH_OMAP3 || ARCH_OMAP4)
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
 	  This core driver provides register access and IRQ handling
@@ -169,7 +169,7 @@ config TWL4030_CORE
 
 config TWL4030_POWER
 	bool "Support power resources on TWL4030 family chips"
-	depends on TWL4030_CORE && ARM
+	depends on TWL4030_CORE && (ARCH_OMAP3 || ARCH_OMAP4)
 	help
 	  Say yes here if you want to use the power resources on the
 	  TWL4030 family chips.  Most of these resources are regulators,
-- 
1.7.2.2

