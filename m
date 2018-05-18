From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: prm44xx: Introduce context save/restore for
 am43 PRCM IO
Date: Fri, 18 May 2018 14:10:21 +0530
Message-ID: <1526632822-26049-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
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
 arch/arm/mach-omap2/prm44xx.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index acb9593..0a4aa90 100644
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
@@ -689,6 +696,28 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 
 static int omap44xx_prm_late_init(void);
 
+void prm_save_context(void)
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
+void prm_restore_context(void)
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
