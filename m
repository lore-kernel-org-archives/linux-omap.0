From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCHv2 2/4] Regulator: OMAP:Modifying Kconfig/Makefile to choose from available PMICs
Date: Tue, 12 Jan 2010 14:43:58 +0530
Message-ID: <1263287638-10174-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40964 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab0ALJOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 04:14:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Kconfig is modified for OMAP3 EVM so that user can choose the appropriate
PMIC (currently only TWL4030). Config options for other PMICs will be
added later on.
Makefile is modified so that twl4030-pmic.c gets compiled for the
platforms having TWL4030 as the PMIC.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    9 +++++++++
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 606bf04..69173f3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -82,6 +82,15 @@ config MACH_OMAP3EVM
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select OMAP_PACKAGE_CBB
 
+config PMIC_TWL4030
+	bool "TWL4030/TPS65950 Power Module"
+	default y
+	select TWL4030_CORE
+	select REGULATOR_TWL4030 if REGULATOR
+	help
+	  Say yes here if you are using the TWL4030/TPS65950 based power module
+	  for the EVM boards.
+
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b32678b..de6ace5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
 					   mmc-twl4030.o
+obj-$(CONFIG_PMIC_TWL4030)		+= twl4030-pmic.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
-- 
1.6.2.4

