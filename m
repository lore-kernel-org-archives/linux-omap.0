From: yegorslists@googlemail.com
Subject: [PATCH v2] GPMC: add ECC control definitions
Date: Thu,  8 Mar 2012 12:07:26 +0100
Message-ID: <1331204846-19573-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:43450 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2CHLIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 06:08:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
v2: READ and WRITE will be configured in the same way, so change the cases accordingly
 arch/arm/mach-omap2/gpmc.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 00d5108..212018d 100644
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
 
@@ -861,8 +874,9 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
 	gpmc_ecc_used = cs;
 
 	/* clear ecc and enable bits */
-	val = ((0x00000001<<8) | 0x00000001);
-	gpmc_write_reg(GPMC_ECC_CONTROL, val);
+	gpmc_write_reg(GPMC_ECC_CONTROL,
+			GPMC_ECC_CTRL_ECCCLEAR |
+			GPMC_ECC_CTRL_ECCREG1);
 
 	/* program ecc and result sizes */
 	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
@@ -870,13 +884,15 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
 
 	switch (mode) {
 	case GPMC_ECC_READ:
-		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+	case GPMC_ECC_WRITE:
+		gpmc_write_reg(GPMC_ECC_CONTROL,
+				GPMC_ECC_CTRL_ECCCLEAR |
+				GPMC_ECC_CTRL_ECCREG1);
 		break;
 	case GPMC_ECC_READSYN:
-		 gpmc_write_reg(GPMC_ECC_CONTROL, 0x100);
-		break;
-	case GPMC_ECC_WRITE:
-		gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+		gpmc_write_reg(GPMC_ECC_CONTROL,
+				GPMC_ECC_CTRL_ECCCLEAR |
+				GPMC_ECC_CTRL_ECCDISABLE);
 		break;
 	default:
 		printk(KERN_INFO "Error: Unrecognized Mode[%d]!\n", mode);
-- 
1.7.7

