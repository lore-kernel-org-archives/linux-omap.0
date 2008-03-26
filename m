From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH] OMAP: MMU_FWK: Changed Kconfig entry from tristate to bool.
Date: Wed, 26 Mar 2008 10:48:07 -0400
Message-ID: <1206542887-12321-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16640 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYCZOs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2008 10:48:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2QEmPRc026708
	for <linux-omap@vger.kernel.org>; Wed, 26 Mar 2008 16:48:54 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

As this code uses unexported symbols, it must be always
built-in. For this reason, a better type of its Kconfig entry
is bool.

Fixed also defconfig which sets this entry as module.

Compile test only.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/configs/ams_delta_defconfig |    2 +-
 arch/arm/plat-omap/Kconfig           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
index a6b77ab..2c4aa11 100644
--- a/arch/arm/configs/ams_delta_defconfig
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -164,7 +164,7 @@ CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
 CONFIG_OMAP_MCBSP=y
-CONFIG_OMAP_MMU_FWK=m
+CONFIG_OMAP_MMU_FWK=y
 CONFIG_OMAP_MBOX_FWK=m
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 50291ed..536f8aa 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -122,7 +122,7 @@ config OMAP_MCBSP
 	  Buffered Serial Port.
 
 config OMAP_MMU_FWK
-	tristate "MMU framework support"
+	bool "MMU framework support"
 	depends on ARCH_OMAP
 	default n
 	help
-- 
1.5.4.2

