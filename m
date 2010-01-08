From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 4/6] Regulator: Modifying Kconfig to choose from the available PMICs
Date: Fri,  8 Jan 2010 23:28:06 +0530
Message-ID: <1262973486-32610-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564Ab0AHR6O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 12:58:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Kconfig is modified for OMAP3 EVM so that user can choose the appropriate
PMIC (currently only TWL4030). Config options for other PMICs will be
added later on.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 606bf04..95b8eb2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -82,6 +82,15 @@ config MACH_OMAP3EVM
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select OMAP_PACKAGE_CBB
 
+config PMIC_TWL4030
+	bool "TWL4030/TPS65950 Power Module"
+	default y
+	depends on TWL4030_CORE && MACH_OMAP3EVM
+	select REGULATOR_TWL4030 if REGULATOR
+	help
+	  Say yes here if you are using the TWL4030/TPS65950 based power module
+	  for the EVM boards.
+
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-- 
1.6.2.4

