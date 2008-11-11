From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH OMAPZOOM] Fix warning about MTD_NAND_OMAP_HWECC in 3430SDP
 defconfig
Date: Tue, 11 Nov 2008 17:39:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02DF303512@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60096 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495AbYKKMKK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 07:10:10 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mABCA2gn031610
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 06:10:08 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mABCA1kP018288
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 17:40:02 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Fix this warning in omap_3430sdp_defconfig

arch/arm/configs/omap_3430sdp_defconfig:563:warning: symbol value '1' invalid for MTD_NAND_OMAP_HWECC

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 616ba92..e4d02eb 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.27-omap1
-# Fri Oct 17 13:41:54 2008
+# Tue Nov 11 17:33:52 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -216,6 +216,7 @@ CONFIG_ARCH_OMAP3430=y
 # OMAP Board Type
 #
 # CONFIG_MACH_OMAP_LDP is not set
+# CONFIG_MACH_OMAP_ZOOM2 is not set
 CONFIG_MACH_OMAP_3430SDP=y
 # CONFIG_MACH_OMAP3EVM is not set
 # CONFIG_MACH_OMAP3_BEAGLE is not set
@@ -560,7 +561,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_SMC=y
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
 CONFIG_MTD_NAND_OMAP2=y
-CONFIG_MTD_NAND_OMAP_HWECC=1
+CONFIG_MTD_NAND_OMAP_HWECC=y
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
