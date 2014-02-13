From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 12/16] ARM: OMAP5: hwmod data: add mmu data for ipu & dsp
Date: Thu, 13 Feb 2014 12:15:43 -0600
Message-ID: <1392315347-32967-13-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

A new MMU hwmod class and data structures are created
to represent the MMUs within the IPU and DSP processor
subsystems in OMAP5. The MMUs in OMAP5 are identical to
those in OMAP4.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 83 ++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index e297d62..8923172 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1122,6 +1122,71 @@ static struct omap_hwmod omap54xx_mmc5_hwmod = {
 };
 
 /*
+ * 'mmu' class
+ * The memory management unit performs virtual to physical address translation
+ * for its requestors.
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_mmu_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap54xx_mmu_hwmod_class = {
+	.name = "mmu",
+	.sysc = &omap54xx_mmu_sysc,
+};
+
+static struct omap_hwmod_rst_info omap54xx_mmu_dsp_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 1 },
+};
+
+static struct omap_hwmod omap54xx_mmu_dsp_hwmod = {
+	.name		= "mmu_dsp",
+	.class		= &omap54xx_mmu_hwmod_class,
+	.clkdm_name	= "dsp_clkdm",
+	.rst_lines	= omap54xx_mmu_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_dsp_resets),
+	.main_clk	= "dpll_iva_h11x2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSP_DSP_CLKCTRL_OFFSET,
+			.rstctrl_offs = OMAP54XX_RM_DSP_RSTCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_DSP_DSP_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* mmu ipu */
+static struct omap_hwmod_rst_info omap54xx_mmu_ipu_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 2 },
+};
+
+static struct omap_hwmod omap54xx_mmu_ipu_hwmod = {
+	.name		= "mmu_ipu",
+	.class		= &omap54xx_mmu_hwmod_class,
+	.clkdm_name	= "ipu_clkdm",
+	.rst_lines	= omap54xx_mmu_ipu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_ipu_resets),
+	.main_clk	= "dpll_core_h22x2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_IPU_IPU_CLKCTRL_OFFSET,
+			.rstctrl_offs = OMAP54XX_RM_IPU_RSTCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_IPU_IPU_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'mpu' class
  * mpu sub-system
  */
@@ -1763,6 +1828,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_cfg -> mmu_dsp */
+static struct omap_hwmod_ocp_if omap54xx_l4_cfg__mmu_dsp = {
+	.master		= &omap54xx_l4_cfg_hwmod,
+	.slave		= &omap54xx_mmu_dsp_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* mpu -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap54xx_mpu__l3_main_1 = {
 	.master		= &omap54xx_mpu_hwmod,
@@ -1787,6 +1860,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_2 -> mmu_ipu */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__mmu_ipu = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_mmu_ipu_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> l3_main_3 */
 static struct omap_hwmod_ocp_if omap54xx_l3_main_1__l3_main_3 = {
 	.master		= &omap54xx_l3_main_1_hwmod,
@@ -2345,6 +2426,7 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_wkup__counter_32k,
 	&omap54xx_l4_cfg__dma_system,
 	&omap54xx_l4_abe__dmic,
+	&omap54xx_l4_cfg__mmu_dsp,
 	&omap54xx_mpu__emif1,
 	&omap54xx_mpu__emif2,
 	&omap54xx_l4_wkup__gpio1,
@@ -2360,6 +2442,7 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_per__i2c3,
 	&omap54xx_l4_per__i2c4,
 	&omap54xx_l4_per__i2c5,
+	&omap54xx_l3_main_2__mmu_ipu,
 	&omap54xx_l4_wkup__kbd,
 	&omap54xx_l4_cfg__mailbox,
 	&omap54xx_l4_abe__mcbsp1,
-- 
1.8.5.3
