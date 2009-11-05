From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 3/5] Regulator: Changing Kconfig / Makefile for OMAP3 PMIC file
Date: Thu,  5 Nov 2009 22:09:32 +0530
Message-ID: <1257439172-28897-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47072 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757474AbZKEQji (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Nov 2009 11:39:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

It updates the Kconfig so that the PMIC present on the EVM can
be chosen. Initially adding TWL4030 to it, others will be added
in the later patches.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    8 ++++++++
 arch/arm/mach-omap2/Makefile |    3 ++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8685df5..7c45801 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -64,6 +64,14 @@ config MACH_OVERO
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+config PMIC_TWL4030
+	bool "TWL4030/TPS65950 Power Module"
+	default y
+	depends on TWL4030_CORE && MACH_OMAP3EVM
+	select REGULATOR_TWL4030 if REGULATOR
+	help
+	  Say yes here if you are using the TWL4030/TPS65950 based power module
+	  for the EVM boards.
 
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 03cb4fc..0b561ae 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -62,7 +62,8 @@ obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
-					   mmc-twl4030.o
+					   mmc-twl4030.o \
+					   board-omap35x-pmic.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
-- 
1.6.2.4

