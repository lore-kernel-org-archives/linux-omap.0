From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCHv3 2/4] Regulator: OMAP: Modifying Kconfig/Makefile to choose from available PMICs
Date: Tue,  2 Mar 2010 15:59:47 +0530
Message-ID: <1267525787-3169-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48873 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0CBK37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 05:29:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

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
index a8a3d1e..1974dda 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -77,6 +77,15 @@ config MACH_OMAP3EVM
 	depends on ARCH_OMAP3
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
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2069fb3..c33e24d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
 					   hsmmc.o
+obj-$(CONFIG_PMIC_TWL4030)		+= twl4030-pmic.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o

 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
--
1.6.2.4

