From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] GPMC: add ECC control definitions
Date: Mon, 23 Jan 2012 13:04:03 +0100
Message-ID: <4F1D4CB3.5080803@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:53119 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab2AWMEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 07:04:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: arm-linux <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/mach-omap2/gpmc.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

Index: b/arch/arm/mach-omap2/gpmc.c
===================================================================
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -50,6 +50,19 @@
 #define GPMC_ECC_SIZE_CONFIG	0x1fc
 #define GPMC_ECC1_RESULT        0x200
 
+/* GPMC ECC control settings */
+#define GPMC_ECC_CTRL_ECCCLEAR		0x100
+#define GPMC_ECC_CTRL_ECCDISABLE	0x000
+#define GPMC_ECC_CTRL_ECCREG1		0x001
+#define GPMC_ECC_CTRL_ECCREG2		0x002
+#define GPMC_ECC_CTRL_ECCREG3		0x003
+#define GPMC_ECC_CTRL_ECCREG4		0x004
+#define GPMC_ECC_CTRL_ECCREG5		0x005
+#define GPMC_ECC_CTRL_ECCREG6		0x006
+#define GPMC_ECC_CTRL_ECCREG7		0x007
+#define GPMC_ECC_CTRL_ECCREG8		0x008
+#define GPMC_ECC_CTRL_ECCREG9		0x009
+
 #define GPMC_CS0_OFFSET		0x60
 #define GPMC_CS_SIZE		0x30
 
@@ -855,8 +868,9 @@
 	gpmc_ecc_used = cs;
 
 	/* clear ecc and enable bits */
-	val = ((0x00000001<<8) | 0x00000001);
-	gpmc_write_reg(GPMC_ECC_CONTROL, val);
+	gpmc_write_reg(GPMC_ECC_CONTROL,
+			GPMC_ECC_CTRL_ECCCLEAR |
+			GPMC_ECC_CTRL_ECCREG1);
 
 	/* program ecc and result sizes */
 	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
@@ -864,13 +878,19 @@
 
 	switch (mode) {
 	case GPMC_ECC_READ:
-		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		gpmc_write_reg(GPMC_ECC_CONTROL,
+				GPMC_ECC_CTRL_ECCCLEAR |
+				GPMC_ECC_CTRL_ECCREG1);
 		break;
 	case GPMC_ECC_READSYN:
-		 gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
+		gpmc_write_reg(GPMC_ECC_CONTROL,
+				GPMC_ECC_CTRL_ECCCLEAR |
+				GPMC_ECC_CTRL_ECCDISABLE);
 		break;
 	case GPMC_ECC_WRITE:
-		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		gpmc_write_reg(GPMC_ECC_CONTROL,
+				GPMC_ECC_CTRL_ECCCLEAR |
+				GPMC_ECC_CTRL_ECCREG1);
 		break;
 	default:
 		printk(KERN_INFO "Error: Unrecognized Mode[%d]!\n", mode);

