From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 3/3] Updates for OMAP3EVM
Date: Sun, 11 Jan 2009 01:31:06 +0530
Message-ID: <1231617666-18760-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56573 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbZAJUBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 15:01:15 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0AK174j011035
	for <linux-omap@vger.kernel.org>; Sat, 10 Jan 2009 14:01:13 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Includes:
- Updates to default board configuration.
- Call function omap2_set_globals_35xx()

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/configs/omap3_evm_defconfig |    5 +++++
 arch/arm/mach-omap2/board-omap3evm.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index e42fe8c..deb148d 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -206,6 +206,11 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 CONFIG_OMAP_SERIAL_WAKE=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
+CONFIG_ARCH_OMAP35XX=y
+CONFIG_ARCH_OMAP3503=y
+# CONFIG_ARCH_OMAP3515 is not set
+# CONFIG_ARCH_OMAP3525 is not set
+# CONFIG_ARCH_OMAP3530 is not set
 
 #
 # OMAP Board Type
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index e4e60e2..7fb3eef 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -264,7 +264,7 @@ static void __init omap3_evm_init(void)
 
 static void __init omap3_evm_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_35xx();
 	omap2_map_common_io();
 }
 
-- 
1.5.6

