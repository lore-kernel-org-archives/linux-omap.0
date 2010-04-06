From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 2/2] OMAP3630SDP: enable Flash device support
Date: Tue,  6 Apr 2010 17:59:10 +0530
Message-ID: <1270556950-32336-3-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1270556950-32336-1-git-send-email-s-ghorai@ti.com>
 <1270556950-32336-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39916 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab0DFM3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 08:29:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o36CTBWn008952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 07:29:13 -0500
In-Reply-To: <1270556950-32336-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

update config file to support for NAND, OneNAND, NOR on OMAP 3630-sdp board.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
---
 arch/arm/configs/omap_3630sdp_defconfig |   77 ++++++++++++++++++++++++++++++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_3630sdp_defconfig b/arch/arm/configs/omap_3630sdp_defconfig
index 609f348..a623927 100644
--- a/arch/arm/configs/omap_3630sdp_defconfig
+++ b/arch/arm/configs/omap_3630sdp_defconfig
@@ -461,7 +461,82 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_SYS_HYPERVISOR is not set
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_OMAP_PREFETCH=y
+# CONFIG_MTD_NAND_OMAP_PREFETCH_DMA is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
+CONFIG_MTD_ONENAND=y
+# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
+# CONFIG_MTD_ONENAND_GENERIC is not set
+CONFIG_MTD_ONENAND_OMAP2=y
+# CONFIG_MTD_ONENAND_OTP is not set
+# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
+# CONFIG_MTD_ONENAND_SIM is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
-- 
1.5.4.7

