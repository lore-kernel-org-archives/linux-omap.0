From: "vimal singh" <vimalsingh@ti.com>
Subject: OMAP3 NAND: move NAND_BLOCK_SIZE macro to board-3430sdp-flash.c
Date: Tue, 7 Oct 2008 11:41:08 +0530 (IST)
Message-ID: <46446.192.168.10.89.1223359868.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYJGGLO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Oct 2008 02:11:14 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m976B9KP007968
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 01:11:14 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m976B6q6009012
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 01:11:07 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Moving NAND_BLOCK_SIZE definition to board-3430sdp-flash.c

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp-flash.c |    2 ++
 include/linux/mtd/nand.h                  |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-omap-2.6_27_08_2008/arch/arm/mach-omap2/board-3430sdp-flash.c
===================================================================
---
linux-omap-2.6_27_08_2008.orig/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-10-07
11:28:53.000000000 +0530
+++
linux-omap-2.6_27_08_2008/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-10-07
11:30:12.000000000 +0530
@@ -26,6 +26,8 @@
 #include <mach/gpmc.h>
 #include <mach/nand.h>

+#define NAND_BLOCK_SIZE		SZ_128K
+
 static struct mtd_partition sdp_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
Index: linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h
===================================================================
--- linux-omap-2.6_27_08_2008.orig/include/linux/mtd/nand.h	2008-10-07
11:29:00.000000000 +0530
+++ linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h	2008-10-07
11:29:56.000000000 +0530
@@ -45,7 +45,7 @@
  */
 #define NAND_MAX_OOBSIZE	64
 #define NAND_MAX_PAGESIZE	2048
-#define NAND_BLOCK_SIZE		SZ_128K
+
 /*
  * Constants for hardware specific CLE/ALE/NCE function
  *


