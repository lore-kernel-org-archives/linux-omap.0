From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 1/7] ARM: OMAP4+: prminst: provide function to find prm_dev instance offset
Date: Thu, 5 Jun 2014 22:35:55 -0500
Message-ID: <1402025761-16831-2-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbaFFDg2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jun 2014 23:36:28 -0400
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

PRM device instance can vary depending on SoC. We already handle the
same during reset of the device, However, this is also needed
for other logic instances. So, first abstract this out to a generic
function.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prminst44xx.c |   41 +++++++++++++++++++++++--------------
 arch/arm/mach-omap2/prminst44xx.h |    3 +++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 69f0dd0..fd2549d 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -31,6 +31,8 @@
 
 static void __iomem *_prm_bases[OMAP4_MAX_PRCM_PARTITIONS];
 
+static s32 prm_dev_inst = PRM_INSTANCE_UNKNOWN;
+
 /**
  * omap_prm_base_init - Populates the prm partitions
  *
@@ -41,6 +43,25 @@ void omap_prm_base_init(void)
 {
 	_prm_bases[OMAP4430_PRM_PARTITION] = prm_base;
 	_prm_bases[OMAP4430_PRCM_MPU_PARTITION] = prcm_mpu_base;
+
+}
+
+s32 omap4_prmst_get_prm_dev_inst(void)
+{
+	if (prm_dev_inst != PRM_INSTANCE_UNKNOWN)
+		return prm_dev_inst;
+
+	/* This cannot be done way early at boot.. as things are not setup */
+	if (cpu_is_omap44xx())
+		prm_dev_inst = OMAP4430_PRM_DEVICE_INST;
+	else if (soc_is_omap54xx())
+		prm_dev_inst = OMAP54XX_PRM_DEVICE_INST;
+	else if (soc_is_dra7xx())
+		prm_dev_inst = DRA7XX_PRM_DEVICE_INST;
+	else if (soc_is_am43xx())
+		prm_dev_inst = AM43XX_PRM_DEVICE_INST;
+
+	return prm_dev_inst;
 }
 
 /* Read a register in a PRM instance */
@@ -169,28 +190,18 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 void omap4_prminst_global_warm_sw_reset(void)
 {
 	u32 v;
-	s16 dev_inst;
+	s32 inst = omap4_prmst_get_prm_dev_inst();
 
-	if (cpu_is_omap44xx())
-		dev_inst = OMAP4430_PRM_DEVICE_INST;
-	else if (soc_is_omap54xx())
-		dev_inst = OMAP54XX_PRM_DEVICE_INST;
-	else if (soc_is_dra7xx())
-		dev_inst = DRA7XX_PRM_DEVICE_INST;
-	else if (soc_is_am43xx())
-		dev_inst = AM43XX_PRM_DEVICE_INST;
-	else
+	if (inst == PRM_INSTANCE_UNKNOWN)
 		return;
 
-	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, dev_inst,
+	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst,
 					OMAP4_PRM_RSTCTRL_OFFSET);
 	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
 	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
-				 dev_inst,
-				 OMAP4_PRM_RSTCTRL_OFFSET);
+				 inst, OMAP4_PRM_RSTCTRL_OFFSET);
 
 	/* OCP barrier */
 	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    dev_inst,
-				    OMAP4_PRM_RSTCTRL_OFFSET);
+				    inst, OMAP4_PRM_RSTCTRL_OFFSET);
 }
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index a2ede2d..583aa37 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -12,6 +12,9 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
 #define __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
 
+#define PRM_INSTANCE_UNKNOWN	-1
+extern s32 omap4_prmst_get_prm_dev_inst(void);
+
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
-- 
1.7.9.5

