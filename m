From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 5/6] OMAP3: OMAP35x: Board specific updates
Date: Thu,  6 Aug 2009 16:06:26 +0530
Message-ID: <1249554986-20464-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36707 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZHFKgd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:36:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76AaRO5008552
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:36:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Includes:
- Updates to default board configuration.
- Call function omap2_set_globals_35xx()

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/configs/omap3_beagle_defconfig  |    1 +
 arch/arm/configs/omap3_evm_defconfig     |    1 +
 arch/arm/configs/omap3_pandora_defconfig |    1 +
 arch/arm/configs/overo_defconfig         |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/board-overo.c        |    2 +-
 8 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index c4726f0..8eddbdf 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -195,6 +195,7 @@ CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART3=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
+CONFIG_ARCH_OMAP35XX=y
 
 #
 # OMAP Board Type
diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 28be17f..da80ca7 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -205,6 +205,7 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 CONFIG_OMAP_SERIAL_WAKE=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
+CONFIG_ARCH_OMAP35XX=y
 
 #
 # OMAP Board Type
diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index b54ad2e..3df0644 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -190,6 +190,7 @@ CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART3=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
+CONFIG_ARCH_OMAP35XX=y
 
 #
 # OMAP Board Type
diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
index a57f9e4..5669be7 100644
--- a/arch/arm/configs/overo_defconfig
+++ b/arch/arm/configs/overo_defconfig
@@ -199,6 +199,7 @@ CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART3=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
+CONFIG_ARCH_OMAP35XX=y
 
 #
 # OMAP Board Type
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b6a68d5..20ae92f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -413,7 +413,7 @@ static void __init omap3_beagle_init(void)
 
 static void __init omap3_beagle_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 595beac..79dda7a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -314,7 +314,7 @@ static void __init omap3_evm_init(void)
 
 static void __init omap3_evm_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 85cc2a7..f6227fd 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -402,7 +402,7 @@ static void __init omap3pandora_init(void)
 
 static void __init omap3pandora_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 501d020..7d90261 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -443,7 +443,7 @@ static void __init overo_init(void)
 
 static void __init overo_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
-- 
1.6.2.2

