From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/6] ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Fri, 15 Jun 2012 20:56:01 -0500
Message-ID: <1339811764-5337-4-git-send-email-omar.luna@linaro.org>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1339811764-5337-1-git-send-email-omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add mmu hwmod data for ipu and dsp.

Signed-off-by: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  136 +++++++++++++++++++++++++++-
 1 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ebf9657..3879e9c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,6 +30,7 @@
 #include <plat/mmc.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
+#include <plat/iommu.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -614,7 +615,6 @@ static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
 
 static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
 	{ .name = "dsp", .rst_shift = 0 },
-	{ .name = "mmu_cache", .rst_shift = 1 },
 };
 
 static struct omap_hwmod omap44xx_dsp_hwmod = {
@@ -1629,7 +1629,6 @@ static struct omap_hwmod_irq_info omap44xx_ipu_irqs[] = {
 static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
 	{ .name = "cpu0", .rst_shift = 0 },
 	{ .name = "cpu1", .rst_shift = 1 },
-	{ .name = "mmu_cache", .rst_shift = 2 },
 };
 
 static struct omap_hwmod omap44xx_ipu_hwmod = {
@@ -2436,6 +2435,137 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 };
 
 /*
+ * 'mmu' class
+ * The memory management unit performs virtual to physical address translation
+ * for its requestors.
+ */
+
+static struct omap_hwmod_class_sysconfig mmu_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
+	.name = "mmu",
+	.sysc = &mmu_sysc,
+};
+
+/* ipu mmu */
+
+static struct omap_mmu_dev_attr ipu_mmu_dev_attr = {
+	.da_start = 0x0,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap44xx_ipu_mmu_hwmod;
+static struct omap_hwmod_irq_info omap44xx_ipu_mmu_irqs[] = {
+	{ .irq = 100 + OMAP44XX_IRQ_GIC_START, },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_ipu_mmu_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 2 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_ipu_mmu_addrs[] = {
+	{
+		.pa_start	= 0x55082000,
+		.pa_end		= 0x550820ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l3_main_2 -> ipu_mmu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ipu_mmu = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_ipu_mmu_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_ipu_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod omap44xx_ipu_mmu_hwmod = {
+	.name		= "ipu_mmu",
+	.class		= &omap44xx_mmu_hwmod_class,
+	.clkdm_name	= "ducati_clkdm",
+	.mpu_irqs	= omap44xx_ipu_mmu_irqs,
+	.rst_lines	= omap44xx_ipu_mmu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_mmu_resets),
+	.main_clk	= "ipu_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
+			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+	.dev_attr	= &ipu_mmu_dev_attr,
+};
+
+/* dsp mmu */
+
+static struct omap_mmu_dev_attr dsp_mmu_dev_attr = {
+	.da_start = 0x0,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap44xx_dsp_mmu_hwmod;
+static struct omap_hwmod_irq_info omap44xx_dsp_mmu_irqs[] = {
+	{ .irq = 28 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_dsp_mmu_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 1 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dsp_mmu_addrs[] = {
+	{
+		.pa_start	= 0x4a066000,
+		.pa_end		= 0x4a0660ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_cfg -> dsp */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp_mmu = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_dsp_mmu_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_dsp_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod omap44xx_dsp_mmu_hwmod = {
+	.name		= "dsp_mmu",
+	.class		= &omap44xx_mmu_hwmod_class,
+	.clkdm_name	= "tesla_clkdm",
+	.mpu_irqs	= omap44xx_dsp_mmu_irqs,
+	.rst_lines	= omap44xx_dsp_mmu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_mmu_resets),
+	.main_clk	= "dsp_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
+			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
+			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+	.dev_attr	= &dsp_mmu_dev_attr,
+};
+
+/*
  * 'mpu' class
  * mpu sub-system
  */
@@ -6092,6 +6222,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l3_main_2__ipu_mmu,
+	&omap44xx_l4_cfg__dsp_mmu,
 	&omap44xx_l3_main_2__ocmc_ram,
 	&omap44xx_l4_cfg__ocp2scp_usb_phy,
 	&omap44xx_mpu_private__prcm_mpu,
-- 
1.7.4.1
