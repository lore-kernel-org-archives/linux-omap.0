From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 4/4] Regulator: Modifying Kconfig to choose from the available PMICs
Date: Wed, 11 Nov 2009 20:15:01 +0530
Message-ID: <1257950701-32561-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55632 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756362AbZKKOpC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 09:45:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Kconfig is modified so that the user can choose the appropriate
PMIC in the underlying EVM.
Config options for other PMICs will be added later on.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

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
-- 
1.6.2.4

