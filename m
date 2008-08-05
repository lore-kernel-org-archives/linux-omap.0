From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP3: Update BeagleBoard defconfig
Date: Tue, 05 Aug 2008 20:41:04 +0200
Message-ID: <48989EC0.4020806@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000605090402000309060204"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:36300 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653AbYHESlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 14:41:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2355620fkq.5
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2008 11:41:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000605090402000309060204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Dirk Behme <dirk.behme@gmail.com>

Update BeagleBoard defconfig:

- Use MPU timer instead of 32k timer to work around serial hang issue
- Disable CONFIG_DEBUG_LL

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------000605090402000309060204
Content-Type: text/plain;
 name="beagle_defconfig_update.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="beagle_defconfig_update.txt"

Index: linux-beagle/arch/arm/configs/omap3_beagle_defconfig
===================================================================
--- linux-beagle.orig/arch/arm/configs/omap3_beagle_defconfig
+++ linux-beagle/arch/arm/configs/omap3_beagle_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc8-omap1
-# Fri Jul  4 10:19:23 2008
+# Linux kernel version: 2.6.26-omap1
+# Tue Aug  5 20:31:33 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -182,9 +182,8 @@ CONFIG_OMAP_BOOT_REASON=y
 # CONFIG_OMAP_MCBSP is not set
 # CONFIG_OMAP_MMU_FWK is not set
 # CONFIG_OMAP_MBOX_FWK is not set
-# CONFIG_OMAP_MPU_TIMER is not set
-CONFIG_OMAP_32K_TIMER=y
-CONFIG_OMAP_32K_TIMER_HZ=128
+CONFIG_OMAP_MPU_TIMER=y
+# CONFIG_OMAP_32K_TIMER is not set
 CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
@@ -251,7 +250,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_PREEMPT is not set
-CONFIG_HZ=128
+CONFIG_HZ=100
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
@@ -663,6 +662,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
+# CONFIG_I2C2_OMAP_BEAGLE is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_TAOS_EVM is not set
@@ -1228,8 +1228,7 @@ CONFIG_FRAME_POINTER=y
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
-CONFIG_DEBUG_LL=y
-# CONFIG_DEBUG_ICEDCC is not set
+# CONFIG_DEBUG_LL is not set
 
 #
 # Security options

--------------000605090402000309060204--
