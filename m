From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 3/3] Updates to OMAP3EVM defconfig
Date: Tue,  2 Sep 2008 01:27:47 +0530
Message-ID: <1220299067-17307-3-git-send-email-premi@ti.com>
References: <1220299067-17307-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44902 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbYIAT56 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 15:57:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81JvoRi005142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 14:57:57 -0500
In-Reply-To: <1220299067-17307-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

---
 arch/arm/configs/omap3_evm_defconfig |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 718c914..cdf74e9 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc1-omap1
-# Thu May  8 08:18:45 2008
+# Linux kernel version: 2.6.26-omap1
+# Thu Sep  1 22:10:43 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -173,6 +173,7 @@ CONFIG_ARCH_OMAP3=y
 CONFIG_OMAP_DEBUG_SRAM_PATCH=y
 # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
+# CONFIG_OMAP_SMARTREFLEX is not set
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -191,6 +192,11 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
+CONFIG_ARCH_OMAP35XX=y
+CONFIG_ARCH_OMAP3503=y
+# CONFIG_ARCH_OMAP3515 is not set
+# CONFIG_ARCH_OMAP3525 is not set
+# CONFIG_ARCH_OMAP3530 is not set
 
 #
 # OMAP Board Type
@@ -198,6 +204,8 @@ CONFIG_ARCH_OMAP3430=y
 # CONFIG_MACH_OMAP_3430SDP is not set
 CONFIG_MACH_OMAP3EVM=y
 # CONFIG_MACH_OMAP3_BEAGLE is not set
+# CONFIG_MACH_OMAP_LDP is not set
+CONFIG_OMAP_TICK_GPTIMER=1
 
 #
 # Boot options
@@ -297,7 +305,7 @@ CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
-# CONFIG_NEON is not set
+CONFIG_NEON=y
 
 #
 # Userspace binary formats
@@ -778,6 +786,7 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
 
 #
 # Multimedia drivers
-- 
1.5.6

