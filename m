From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 8/8] zoom3: enable NAND support
Date: Wed, 16 Jun 2010 17:10:00 +0530
Message-ID: <1276688400-4812-9-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-3-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-4-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-5-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-6-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-7-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-8-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36845 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705Ab0FPLkI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 07:40:08 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5GBe51h001093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 06:40:07 -0500
In-Reply-To: <1276688400-4812-8-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

update config file to support for NAND on zoom3 board.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/configs/omap_zoom3_defconfig |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)
 arch/arm/configs/omap_zoom3_defconfig

diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index 5e55b55..e3e53cd
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -461,7 +461,22 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_SYS_HYPERVISOR is not set
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_OMAP_PREFETCH=y
+CONFIG_MTD_NAND_IDS=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -1311,6 +1326,13 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
-- 
1.5.4.7

