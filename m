From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 4/6] ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 register offsets
Date: Wed, 8 Jul 2015 11:12:26 +0530
Message-ID: <1436334148-9309-5-git-send-email-j-keerthy@ti.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com, paul@pwsan.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The register offsets of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 are hardcoded.
This makes it difficult to reuse the code for SoCs like AM437x that have
a single instance of IRQENABLE_MPU and IRQSTATUS_MPU registers.
Hence handling the case using offset of 4 to accommodate single set of IRQ*
registers generically.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 8149e5a..f82d89a 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -217,11 +217,11 @@ static inline u32 _read_pending_irq_reg(u16 irqen_offs, u16 irqst_offs)
  */
 static void omap44xx_prm_read_pending_irqs(unsigned long *events)
 {
-	events[0] = _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_OFFSET,
-					  OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
+	int i;
 
-	events[1] = _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_2_OFFSET,
-					  OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET);
+	for (i = 0; i < omap4_prcm_irq_setup.nr_regs; i++)
+		events[i] = _read_pending_irq_reg(omap4_prcm_irq_setup.mask +
+				i * 4, omap4_prcm_irq_setup.ack + i * 4);
 }
 
 /**
@@ -251,17 +251,15 @@ static void omap44xx_prm_ocp_barrier(void)
  */
 static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
 {
-	saved_mask[0] =
-		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
-					OMAP4_PRM_IRQENABLE_MPU_OFFSET);
-	saved_mask[1] =
-		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
-					OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
+	int i;
 
-	omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
-				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
-	omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
-				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
+	for (i = 0; i < omap4_prcm_irq_setup.nr_regs; i++) {
+		saved_mask[i] =
+			omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+					omap4_prcm_irq_setup.mask + i * 4);
+		omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
+					 omap4_prcm_irq_setup.mask + i * 4);
+	}
 
 	/* OCP barrier */
 	omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
@@ -280,10 +278,12 @@ static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
  */
 static void omap44xx_prm_restore_irqen(u32 *saved_mask)
 {
-	omap4_prm_write_inst_reg(saved_mask[0], OMAP4430_PRM_OCP_SOCKET_INST,
-				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
-	omap4_prm_write_inst_reg(saved_mask[1], OMAP4430_PRM_OCP_SOCKET_INST,
-				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
+	int i;
+
+	for (i = 0; i < omap4_prcm_irq_setup.nr_regs; i++)
+		omap4_prm_write_inst_reg(saved_mask[i],
+				OMAP4430_PRM_OCP_SOCKET_INST,
+				omap4_prcm_irq_setup.mask + i * 4);
 }
 
 /**
-- 
1.9.1
