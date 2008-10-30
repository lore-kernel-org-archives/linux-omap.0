From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH - Omapzoom][NAND] Fix selection of sw/hw ecc
Date: Thu, 30 Oct 2008 17:08:59 +0530 (IST)
Message-ID: <45877.192.168.10.89.1225366739.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45489 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbYJ3LjG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 07:39:06 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9UBcxnZ015918
	for <linux-omap@vger.kernel.org>; Thu, 30 Oct 2008 06:39:05 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m9UBcveX011626
	for <linux-omap@vger.kernel.org>; Thu, 30 Oct 2008 06:38:58 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Removing unnecessary '#ifdef' in 'nand/omap2.c' and changing hwecc config
option from 'int' to 'bool' in 'nand/Kconfig'.

Because of 'int' option hw ecc was always used even if sw ecc had been selected.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>

---
 drivers/mtd/nand/Kconfig |    6 ++----
 drivers/mtd/nand/omap2.c |    4 ----
 2 files changed, 2 insertions(+), 8 deletions(-)

Index: omapkernel/drivers/mtd/nand/Kconfig
===================================================================
--- omapkernel.orig/drivers/mtd/nand/Kconfig	2008-10-24 11:24:52.000000000 +0530
+++ omapkernel/drivers/mtd/nand/Kconfig	2008-10-29 15:57:03.000000000 +0530
@@ -75,14 +75,12 @@
           Support for NAND flash on Texas Instruments OMAP2 and OMAP3 platforms.

 config MTD_NAND_OMAP_HWECC
-         int "The ECC computation logic (0 = software ecc, 1 = hardware ecc)"
+         bool "The ECC computation logic (y = hardware ecc, n = software ecc)"
          depends on MTD_NAND && MTD_NAND_OMAP2
-         default "0"
+         default y
          help
            The ECC compuatation for the data to be written/read can be either by
            software or omap has Hw ecc engine which calculates it.
-           MTD_NAND_OMAP_HWECC = 1 which enables the hw ecc
-           MTD_NAND_OMAP_HWECC = 0, enables software ecc

 config MTD_NAND_OMAP
 	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
Index: omapkernel/drivers/mtd/nand/omap2.c
===================================================================
--- omapkernel.orig/drivers/mtd/nand/omap2.c	2008-10-24 11:24:52.000000000 +0530
+++ omapkernel/drivers/mtd/nand/omap2.c	2008-10-29 16:19:48.000000000 +0530
@@ -111,10 +111,6 @@
 static const char *part_probes[] = { "cmdlinepart", NULL };
 #endif

-#ifndef MTD_NAND_OMAP_HWECC
-#define MTD_NAND_OMAP_HWECC   0
-#endif
-
 struct omap_nand_info {
 	struct nand_hw_control		controller;
 	struct omap_nand_platform_data	*pdata;


