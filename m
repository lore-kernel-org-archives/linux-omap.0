From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: [PATCH] ARM: OMAP: Kconfig support HW ECC for nand driver on OMAP3
Date: Mon, 25 Aug 2008 11:12:59 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD45C99B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60285 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbYHYFxj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 01:53:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7P5h2YV006428
	for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 00:43:08 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7P5h1DT012248
	for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 11:13:01 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Teerth Reddy <teerth@ti.com>

Add kconfig support for HW ECC for nand driver on OMAP3

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 drivers/mtd/nand/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index : linux-omap-2.6/drivers/mtd/nand/Kconfig
==================================================================================
--- a/drivers/mtd/nand/Kconfig	2008-08-25 10:26:51.708901000 +0530
+++ b/drivers/mtd/nand/Kconfig	2008-08-25 10:28:12.820012000 +0530
@@ -74,6 +74,16 @@ config MTD_NAND_OMAP2
 	help
           Support for NAND flash on Texas Instruments OMAP2 and OMAP3 platforms.
 
+config MTD_NAND_OMAP_HWECC
+	bool "The Hardware ECC support"
+	depends on MTD_NAND && MTD_NAND_OMAP2
+	default n
+	help
+	 The ECC compuatation for the data to be written/read can be either by
+	 software or omap has Hw ecc engine which calculates it.
+	 MTD_NAND_OMAP_HWECC = y which enables the hw ecc
+	 MTD_NAND_OMAP_HWECC = n enables software ecc
+
 config MTD_NAND_OMAP
 	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
 	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
