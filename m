From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 14/14] ARM: OMAP2+: prm44xx: Introduce context save/restore for am43 PRCM IO
Date: Thu, 12 Apr 2018 09:23:59 +0530
Message-ID: <1523505239-16229-15-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

There are two registers on am43x needed for IO daisy chain wake to work
properly, however currently after an RTC+DDR cycle they are lost. We
must take care to save and restore these before and after entering RTC
mode otherwise IO daisy chain wake will stop working from DeepSleep
after resuming.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm.h     |  2 ++
 arch/arm/mach-omap2/prm44xx.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index f0fb508..32e275f 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -179,6 +179,8 @@ int omap_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
 u32 omap_prm_vp_check_txdone(u8 vp_id);
 void omap_prm_vp_clear_txdone(u8 vp_id);
 
+void am43xx_prm_save_context(void);
+void am43xx_prm_restore_context(void);
 #endif
 
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 47b657c..0d1111e 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -57,6 +57,13 @@
 	.reconfigure_io_chain	= &omap44xx_prm_reconfigure_io_chain,
 };
 
+struct omap_prm_irq_context {
+	unsigned long irq_enable;
+	unsigned long pm_ctrl;
+};
+
+static struct omap_prm_irq_context omap_prm_context;
+
 /*
  * omap44xx_prm_reset_src_map - map from bits in the PRM_RSTST
  *   hardware register (which are specific to OMAP44xx SoCs) to reset
@@ -739,6 +746,28 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 
 static int omap44xx_prm_late_init(void);
 
+void am43xx_prm_save_context(void)
+{
+	omap_prm_context.irq_enable =
+			omap4_prm_read_inst_reg(AM43XX_PRM_OCP_SOCKET_INST,
+						omap4_prcm_irq_setup.mask);
+
+	omap_prm_context.pm_ctrl =
+			omap4_prm_read_inst_reg(AM43XX_PRM_DEVICE_INST,
+						omap4_prcm_irq_setup.pm_ctrl);
+}
+
+void am43xx_prm_restore_context(void)
+{
+	omap4_prm_write_inst_reg(omap_prm_context.irq_enable,
+				 OMAP4430_PRM_OCP_SOCKET_INST,
+				 omap4_prcm_irq_setup.mask);
+
+	omap4_prm_write_inst_reg(omap_prm_context.pm_ctrl,
+				 AM43XX_PRM_DEVICE_INST,
+				 omap4_prcm_irq_setup.pm_ctrl);
+}
+
 /*
  * XXX document
  */
-- 
1.9.1
