From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/6] ARM: OMAP3: hwmod data: add mmu data for iva and isp
Date: Fri, 15 Jun 2012 20:56:00 -0500
Message-ID: <1339811764-5337-3-git-send-email-omar.luna@linaro.org>
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

Add mmu hwmod data for iva and isp.

Due to compatibility an ifdef CONFIG_OMAP_IOMMU_IVA2 needs to be
propagated (previously on iommu resource info) to hwmod data in OMAP3,
so users of iommu and tidspbridge can avoid issues of two modules
managing mmu data/irqs/resets; this until tidspbridge can be migrated
to iommu framework.

Signed-off-by: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  117 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/iommu.h    |   13 +++
 2 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0ea53bc..89df566 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -27,6 +27,7 @@
 #include <plat/mcbsp.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
+#include <plat/iommu.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2777,6 +2778,118 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/*
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
+static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
+	.name = "mmu",
+	.sysc = &mmu_sysc,
+};
+
+/* isp mmu */
+
+static struct omap_mmu_dev_attr isp_mmu_dev_attr = {
+	.da_start = 0x0,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 8,
+};
+
+static struct omap_hwmod omap3xxx_isp_mmu_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_isp_mmu_irqs[] = {
+	{ .irq = 24 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_addr_space omap3xxx_isp_mmu_addrs[] = {
+	{
+		.pa_start	= 0x480bd400,
+		.pa_end		= 0x480bd47f,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_core -> isp mmu */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__isp_mmu = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_isp_mmu_hwmod,
+	.addr		= omap3xxx_isp_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod omap3xxx_isp_mmu_hwmod = {
+	.name		= "isp_mmu",
+	.class		= &omap3xxx_mmu_hwmod_class,
+	.mpu_irqs	= omap3xxx_isp_mmu_irqs,
+	.main_clk	= "cam_ick",
+	.dev_attr	= &isp_mmu_dev_attr,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* iva mmu */
+
+static struct omap_mmu_dev_attr iva_mmu_dev_attr = {
+	.da_start = 0x11000000,
+	.da_end = 0xfffff000,
+	.nr_tlb_entries = 32,
+};
+
+static struct omap_hwmod omap3xxx_iva_mmu_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_iva_mmu_irqs[] = {
+	{ .irq = 28 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_rst_info omap3xxx_iva_mmu_resets[] = {
+	{ .name = "mmu", .rst_shift = 1, .st_shift = 9 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_iva_mmu_addrs[] = {
+	{
+		.pa_start	= 0x5d000000,
+		.pa_end		= 0x5d00007f,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l3_main -> iva mmu */
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__iva_mmu = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_iva_mmu_hwmod,
+	.addr		= omap3xxx_iva_mmu_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod omap3xxx_iva_mmu_hwmod = {
+	.name		= "iva_mmu",
+	.class		= &omap3xxx_mmu_hwmod_class,
+	.mpu_irqs	= omap3xxx_iva_mmu_irqs,
+	.rst_lines	= omap3xxx_iva_mmu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_iva_mmu_resets),
+	.main_clk	= "iva2_ck",
+	.prcm = {
+		.omap2 = {
+			.module_offs = OMAP3430_IVA2_MOD,
+		},
+	},
+	.dev_attr	= &iva_mmu_dev_attr,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* l4_per -> gpio4 */
 static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
 	{
@@ -3174,6 +3287,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap34xx_l4_core__mcspi2,
 	&omap34xx_l4_core__mcspi3,
 	&omap34xx_l4_core__mcspi4,
+	&omap3xxx_l4_core__isp_mmu,
+#ifdef CONFIG_OMAP_IOMMU_IVA2
+	&omap3xxx_l3_main__iva_mmu,
+#endif
 	&omap3xxx_l4_wkup__counter_32k,
 	NULL,
 };
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index e58d571..44518cc 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -103,6 +103,19 @@ struct iommu_functions {
 	ssize_t (*dump_ctx)(struct omap_iommu *obj, char *buf, ssize_t len);
 };
 
+/**
+ * omap_mmu_dev_attr - OMAP mmu device attributes for omap_hwmod
+ * @da_start:		device address where the va space starts.
+ * @da_end:		device address where the va space ends.
+ * @nr_tlb_entries:	number of entries supported by the translation
+ *			look-aside buffer (TLB).
+ */
+struct omap_mmu_dev_attr {
+	u32 da_start;
+	u32 da_end;
+	int nr_tlb_entries;
+};
+
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
-- 
1.7.4.1
