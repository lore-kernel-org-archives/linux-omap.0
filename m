From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] Provide the set_power at TWL4030 MMC
Date: Thu, 27 Nov 2008 16:53:45 +0900
Message-ID: <20081127075345.GA17896@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:47658 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYK0Hxz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 02:53:55 -0500
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout5.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KAZ00EG4F9SEV@mailout5.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 27 Nov 2008 16:53:52 +0900 (KST)
Received: from spapp01.rdscm.com ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KAZ00JKMF9T9B@mmp2.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 27 Nov 2008 16:53:53 +0900 (KST)
Content-disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Custom board powered by VAUX2 and VAUX4 for MMC instead of VMMC
Also it uses VMMC for MMC core power not voltage.

MMC1: uses VMMC1(voltage) and VMMC2(Vdd)
MMC2: uses VAUX2(voltage) and VAUX4(Vdd)

To address this issue, platform uses its custom power function.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 626d668..571b7b0 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -27,28 +27,6 @@
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#define LDO_CLR			0x00
-#define VSEL_S2_CLR		0x40
-
-#define VMMC1_DEV_GRP		0x27
-#define VMMC1_CLR		0x00
-#define VMMC1_315V		0x03
-#define VMMC1_300V		0x02
-#define VMMC1_285V		0x01
-#define VMMC1_185V		0x00
-#define VMMC1_DEDICATED		0x2A
-
-#define VMMC2_DEV_GRP		0x2B
-#define VMMC2_CLR		0x40
-#define VMMC2_315V		0x0c
-#define VMMC2_300V		0x0b
-#define VMMC2_285V		0x0a
-#define VMMC2_260V		0x08
-#define VMMC2_185V		0x06
-#define VMMC2_DEDICATED		0x2E
-
-#define VMMC_DEV_GRP_P1		0x20
-
 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
 
@@ -385,14 +363,21 @@ void __init hsmmc_init(struct twl4030_hsmmc_info *controllers)
 		/* NOTE:  we assume OMAP's MMC1 and MMC2 use
 		 * the TWL4030's VMMC1 and VMMC2, respectively;
 		 * and that OMAP's MMC3 isn't used.
+		 * or provided by a platform.
 		 */
 
 		switch (c->mmc) {
 		case 1:
-			mmc->slots[0].set_power = twl_mmc1_set_power;
+			if (c->set_power)
+				mmc->slots[0].set_power = c->set_power;
+			else
+				mmc->slots[0].set_power = twl_mmc1_set_power;
 			break;
 		case 2:
-			mmc->slots[0].set_power = twl_mmc2_set_power;
+			if (c->set_power)
+				mmc->slots[0].set_power = c->set_power;
+			else
+				mmc->slots[0].set_power = twl_mmc2_set_power;
 			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index e2d58a2..25a08ed 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -6,12 +6,55 @@
  * published by the Free Software Foundation.
  */
 
+#define VAUX2_DEV_GRP		0x1B
+#define VAUX2_315V		0x0C
+#define VAUX2_300V		0x0B
+#define VAUX2_285V		0x0A
+#define VAUX2_260V		0x08
+#define VAUX2_185V		0x06
+#define VAUX2_180V		0x05
+#define VAUX2_DEDICATED		0x1E
+
+#define VAUX4_DEV_GRP		0x23
+#define VAUX4_315V		0x0C
+#define VAUX4_300V		0x0B
+#define VAUX4_285V		0x0A
+#define VAUX4_260V		0x08
+#define VAUX4_185V		0x06
+#define VAUX4_DEDICATED		0x26
+
+#define VAUX_DEV_GRP_P1		0x20
+
+#define LDO_CLR			0x00
+#define VSEL_S2_CLR		0x40
+
+#define VMMC1_DEV_GRP		0x27
+#define VMMC1_CLR		0x00
+#define VMMC1_315V		0x03
+#define VMMC1_300V		0x02
+#define VMMC1_285V		0x01
+#define VMMC1_185V		0x00
+#define VMMC1_DEDICATED		0x2A
+
+#define VMMC2_DEV_GRP		0x2B
+#define VMMC2_CLR		0x00
+#define VMMC2_315V		0x0c
+#define VMMC2_300V		0x0b
+#define VMMC2_285V		0x0a
+#define VMMC2_260V		0x08
+#define VMMC2_185V		0x06
+#define VMMC2_DEDICATED		0x2E
+
+#define VMMC_DEV_GRP_P1		0x20
+
 struct twl4030_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	int	ext_clock:1;	/* use external pin for input clock */
+	int	(*set_power)(struct device *dev, int slot,
+			int power_on, int vdd);
 };
 
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
