From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 3/8] OMAP3+: PRM: add tranxdone IRQ handlers for ABB
Date: Wed, 29 Jun 2011 17:25:55 -0700
Message-ID: <1309393560-8874-4-git-send-email-mturquette@ti.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38657 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754144Ab1F3A1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 20:27:07 -0400
Received: by yib18 with SMTP id 18so929643yib.34
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 17:27:06 -0700 (PDT)
In-Reply-To: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com, Mike Turquette <mturquette@ti.com>

From: Nishanth Menon <nm@ti.com>

OMAP3 and more recent platforms support a PRM interrupt to the MPU for
Adapative Body-Bias ldo transitions.

Add helpers to the OMAP3 & OMAP4 PRM code to check the status of the
interrupt and also to clear it.  These will be called from the ABB code
as part of the greater voltage scaling sequence.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   35 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    3 ++
 arch/arm/mach-omap2/prm44xx.c      |   40 +++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/prm44xx.h      |    3 ++
 4 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 8a20242..49e9719 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -163,18 +163,23 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
 
 /*
  * struct omap3_prm_irq - OMAP3 PRM IRQ register access description.
- * @tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
+ * @vp_tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
+ * @abb_tranxdone_status: ABB_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
+ *			  (ONLY for OMAP3630)
  */
 struct omap3_prm_irq {
-	u32 tranxdone_status;
+	u32 vp_tranxdone_status;
+	u32 abb_tranxdone_status;
 };
 
 static struct omap3_prm_irq omap3_prm_irqs[] = {
 	[OMAP3_PRM_IRQ_VDD_MPU_ID] = {
-		.tranxdone_status = OMAP3430_VP1_TRANXDONE_ST_MASK,
+		.vp_tranxdone_status = OMAP3430_VP1_TRANXDONE_ST_MASK,
+		.abb_tranxdone_status = OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
 	},
 	[OMAP3_PRM_IRQ_VDD_CORE_ID] = {
-		.tranxdone_status = OMAP3430_VP2_TRANXDONE_ST_MASK,
+		.vp_tranxdone_status = OMAP3430_VP2_TRANXDONE_ST_MASK,
+		/* no abb for core */
 	},
 };
 
@@ -187,14 +192,32 @@ u32 omap3_prm_vp_check_txdone(u8 irq_id)
 
 	irqstatus = omap2_prm_read_mod_reg(OCP_MOD,
 					   OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-	return irqstatus & irq->tranxdone_status;
+	return irqstatus & irq->vp_tranxdone_status;
 }
 
 void omap3_prm_vp_clear_txdone(u8 irq_id)
 {
 	struct omap3_prm_irq *irq = &omap3_prm_irqs[irq_id];
 
-	omap2_prm_write_mod_reg(irq->tranxdone_status,
+	omap2_prm_write_mod_reg(irq->vp_tranxdone_status,
+				OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+}
+
+u32 omap36xx_prm_abb_check_txdone(u8 irq_id)
+{
+	struct omap3_prm_irq *irq = &omap3_prm_irqs[irq_id];
+	u32 irqstatus;
+
+	irqstatus = omap2_prm_read_mod_reg(OCP_MOD,
+					   OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	return irqstatus & irq->abb_tranxdone_status;
+}
+
+void omap36xx_prm_abb_clear_txdone(u8 irq_id)
+{
+	struct omap3_prm_irq *irq = &omap3_prm_irqs[irq_id];
+
+	omap2_prm_write_mod_reg(irq->abb_tranxdone_status,
 				OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 }
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index d90b23f..08d5f1e 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -313,6 +313,9 @@ extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
 u32 omap3_prm_vp_check_txdone(u8 irq_id);
 void omap3_prm_vp_clear_txdone(u8 irq_id);
 
+/* OMAP36xx-specific ABB functions */
+u32 omap36xx_prm_abb_check_txdone(u8 irq_id);
+void omap36xx_prm_abb_clear_txdone(u8 irq_id);
 
 /*
  * OMAP3 access functions for voltage controller (VC) and
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 9d0b641..a062b63 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -202,25 +202,30 @@ void omap4_prm_global_warm_sw_reset(void)
 /*
  * struct omap4_prm_irq - OMAP4 VP register access description.
  * @irqstatus_mpu: offset to IRQSTATUS_MPU register for VP
- * @tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
+ * @vp_tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
+ * @abb_tranxdone_status: ABB_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
  */
 struct omap4_prm_irq {
 	u32 irqstatus_mpu;
-	u32 tranxdone_status;
+	u32 vp_tranxdone_status;
+	u32 abb_tranxdone_status;
 };
 
 static struct omap4_prm_irq omap4_prm_irqs[] = {
 	[OMAP4_PRM_IRQ_VDD_MPU_ID] = {
 		.irqstatus_mpu = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
-		.tranxdone_status = OMAP4430_VP_MPU_TRANXDONE_ST_MASK,
+		.vp_tranxdone_status = OMAP4430_VP_MPU_TRANXDONE_ST_MASK,
+		.abb_tranxdone_status = OMAP4430_ABB_MPU_DONE_ST_MASK
 	},
 	[OMAP4_PRM_IRQ_VDD_IVA_ID] = {
 		.irqstatus_mpu = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
-		.tranxdone_status = OMAP4430_VP_IVA_TRANXDONE_ST_MASK,
+		.vp_tranxdone_status = OMAP4430_VP_IVA_TRANXDONE_ST_MASK,
+		.abb_tranxdone_status = OMAP4430_ABB_IVA_DONE_ST_MASK,
 	},
 	[OMAP4_PRM_IRQ_VDD_CORE_ID] = {
 		.irqstatus_mpu = OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
-		.tranxdone_status = OMAP4430_VP_CORE_TRANXDONE_ST_MASK,
+		.vp_tranxdone_status = OMAP4430_VP_CORE_TRANXDONE_ST_MASK,
+		/* Core has no ABB */
 	},
 };
 
@@ -232,19 +237,40 @@ u32 omap4_prm_vp_check_txdone(u8 irq_id)
 	irqstatus = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
 						OMAP4430_PRM_OCP_SOCKET_INST,
 						irq->irqstatus_mpu);
-	return irqstatus & irq->tranxdone_status;
+	return irqstatus & irq->vp_tranxdone_status;
 }
 
 void omap4_prm_vp_clear_txdone(u8 irq_id)
 {
 	struct omap4_prm_irq *irq = &omap4_prm_irqs[irq_id];
 
-	omap4_prminst_write_inst_reg(irq->tranxdone_status,
+	omap4_prminst_write_inst_reg(irq->vp_tranxdone_status,
 				     OMAP4430_PRM_PARTITION,
 				     OMAP4430_PRM_OCP_SOCKET_INST,
 				     irq->irqstatus_mpu);
 };
 
+u32 omap4_prm_abb_check_txdone(u8 irq_id)
+{
+	struct omap4_prm_irq *irq = &omap4_prm_irqs[irq_id];
+	u32 irqstatus;
+
+	irqstatus = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+						OMAP4430_PRM_OCP_SOCKET_INST,
+						irq->irqstatus_mpu);
+	return irqstatus & irq->abb_tranxdone_status;
+}
+
+void omap4_prm_abb_clear_txdone(u8 irq_id)
+{
+	struct omap4_prm_irq *irq = &omap4_prm_irqs[irq_id];
+
+	omap4_prminst_write_inst_reg(irq->abb_tranxdone_status,
+				     OMAP4430_PRM_PARTITION,
+				     OMAP4430_PRM_OCP_SOCKET_INST,
+				     irq->irqstatus_mpu);
+}
+
 u32 omap4_prm_vcvp_read(u8 offset)
 {
 	return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index bd0fc85..3993ed4 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -779,6 +779,9 @@ extern void omap4_prm_global_warm_sw_reset(void);
 /* OMAP4-specific VP functions */
 u32 omap4_prm_vp_check_txdone(u8 irq_id);
 void omap4_prm_vp_clear_txdone(u8 irq_id);
+/* OMAP4-specific ABB functions */
+u32 omap4_prm_abb_check_txdone(u8 irq_id);
+void omap4_prm_abb_clear_txdone(u8 irq_id);
 
 /*
  * OMAP4 access functions for voltage controller (VC) and
-- 
1.7.4.1

