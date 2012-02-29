From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 2/4] ARM: OMAP4: prm: fix interrupt register offsets
Date: Wed, 29 Feb 2012 17:25:04 +0200
Message-ID: <1330529106-10423-3-git-send-email-t-kristo@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37332 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655Ab2B2PZe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 10:25:34 -0500
In-Reply-To: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Previous code used wrong instance for the interrupt register access.
Use the right one which is OCP_SOCKET.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm44xx.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a931f8f..caa5e0f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -145,8 +145,9 @@ static inline u32 _read_pending_irq_reg(u16 irqen_offs, u16 irqst_offs)
 	u32 mask, st;
 
 	/* XXX read mask from RAM? */
-	mask = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, irqen_offs);
-	st = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, irqst_offs);
+	mask = omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+				       irqen_offs);
+	st = omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST, irqst_offs);
 
 	return mask & st;
 }
@@ -178,7 +179,7 @@ void omap44xx_prm_read_pending_irqs(unsigned long *events)
  */
 void omap44xx_prm_ocp_barrier(void)
 {
-	omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+	omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
 				OMAP4_REVISION_PRM_OFFSET);
 }
 
@@ -196,19 +197,19 @@ void omap44xx_prm_ocp_barrier(void)
 void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
 {
 	saved_mask[0] =
-		omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
 					OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
 	saved_mask[1] =
-		omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
 					OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET);
 
-	omap4_prm_write_inst_reg(0, OMAP4430_PRM_DEVICE_INST,
+	omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
-	omap4_prm_write_inst_reg(0, OMAP4430_PRM_DEVICE_INST,
+	omap4_prm_write_inst_reg(0, OMAP4430_PRM_OCP_SOCKET_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
 
 	/* OCP barrier */
-	omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+	omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
 				OMAP4_REVISION_PRM_OFFSET);
 }
 
@@ -224,9 +225,9 @@ void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
  */
 void omap44xx_prm_restore_irqen(u32 *saved_mask)
 {
-	omap4_prm_write_inst_reg(saved_mask[0], OMAP4430_PRM_DEVICE_INST,
+	omap4_prm_write_inst_reg(saved_mask[0], OMAP4430_PRM_OCP_SOCKET_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
-	omap4_prm_write_inst_reg(saved_mask[1], OMAP4430_PRM_DEVICE_INST,
+	omap4_prm_write_inst_reg(saved_mask[1], OMAP4430_PRM_OCP_SOCKET_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
 }
 
-- 
1.7.4.1

