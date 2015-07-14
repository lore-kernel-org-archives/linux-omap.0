From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 1/6] ARM: OMAP4: PRM: Remove hardcoding of PRM_IO_PMCTRL_OFFSET register
Date: Tue, 14 Jul 2015 15:38:13 +0530
Message-ID: <1436868498-27019-2-git-send-email-j-keerthy@ti.com>
References: <1436868498-27019-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436868498-27019-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, galak@codeaurora.org, bcousson@baylibre.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

PRM_IO_PMCTRL_OFFSET need not be same for all SOCs hence
remove hardcoding and use the value provided by the omap_prcm_irq_setup
structure.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |  1 +
 arch/arm/mach-omap2/prm44xx.c     | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 6ae0b3a..2e60406 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -494,6 +494,7 @@ struct omap_prcm_irq {
 struct omap_prcm_irq_setup {
 	u16 ack;
 	u16 mask;
+	u16 pm_ctrl;
 	u8 nr_regs;
 	u8 nr_irqs;
 	const struct omap_prcm_irq *irqs;
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 4541700..8149e5a 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -45,6 +45,7 @@ static const struct omap_prcm_irq omap4_prcm_irqs[] = {
 static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
 	.ack			= OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
 	.mask			= OMAP4_PRM_IRQENABLE_MPU_OFFSET,
+	.pm_ctrl		= OMAP4_PRM_IO_PMCTRL_OFFSET,
 	.nr_regs		= 2,
 	.irqs			= omap4_prcm_irqs,
 	.nr_irqs		= ARRAY_SIZE(omap4_prcm_irqs),
@@ -306,10 +307,10 @@ static void omap44xx_prm_reconfigure_io_chain(void)
 	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
 				    OMAP4430_WUCLK_CTRL_MASK,
 				    inst,
-				    OMAP4_PRM_IO_PMCTRL_OFFSET);
+				    omap4_prcm_irq_setup.pm_ctrl);
 	omap_test_timeout(
 		(((omap4_prm_read_inst_reg(inst,
-					   OMAP4_PRM_IO_PMCTRL_OFFSET) &
+					   omap4_prcm_irq_setup.pm_ctrl) &
 		   OMAP4430_WUCLK_STATUS_MASK) >>
 		  OMAP4430_WUCLK_STATUS_SHIFT) == 1),
 		MAX_IOPAD_LATCH_TIME, i);
@@ -319,10 +320,10 @@ static void omap44xx_prm_reconfigure_io_chain(void)
 	/* Trigger WUCLKIN disable */
 	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
 				    inst,
-				    OMAP4_PRM_IO_PMCTRL_OFFSET);
+				    omap4_prcm_irq_setup.pm_ctrl);
 	omap_test_timeout(
 		(((omap4_prm_read_inst_reg(inst,
-					   OMAP4_PRM_IO_PMCTRL_OFFSET) &
+					   omap4_prcm_irq_setup.pm_ctrl) &
 		   OMAP4430_WUCLK_STATUS_MASK) >>
 		  OMAP4430_WUCLK_STATUS_SHIFT) == 0),
 		MAX_IOPAD_LATCH_TIME, i);
@@ -350,7 +351,7 @@ static void __init omap44xx_prm_enable_io_wakeup(void)
 	omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
 				    OMAP4430_GLOBAL_WUEN_MASK,
 				    inst,
-				    OMAP4_PRM_IO_PMCTRL_OFFSET);
+				    omap4_prcm_irq_setup.pm_ctrl);
 }
 
 /**
-- 
1.9.1
