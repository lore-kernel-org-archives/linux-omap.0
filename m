From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/8] ARM: DRA7: hwmod data: Add MMU data for IPUs
Date: Mon, 21 Aug 2017 18:48:11 -0500
Message-ID: <20170821234818.4755-2-s-anna@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821234818.4755-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

A new MMU hwmod class and data structures are added for
representing the MMUs within the IPU1 and IPU2 processor
subsystems present on DRA7xx/AM57xx SoCs.

Note that the clock integration is slightly different between
IPU1 and IPU2. IPU2 functional clock is sourced directly from
dpll_core_h22x2_ck, while IPU1 has a mux clock for which one
of the inputs is dpll_core_h22x2_ck. This mux clock is configured
to be sourced from the dpll_core_h22x2_ck in turn, so that both
IPU1 and IPU2 run at the same clock frequency. This is already
addressed in commit 39879c7d963e ("ARM: dts: dra7xx-clocks:
Source IPU1 functional clock from CORE DPLL").

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 81 +++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index f040244c57e7..bf55802448ac 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1800,6 +1800,69 @@ static struct omap_hwmod dra7xx_mmc4_hwmod = {
 };
 
 /*
+ * 'mmu' class
+ * The memory management unit performs virtual to physical address translation
+ * for its requestors.
+ */
+
+static struct omap_hwmod_class_sysconfig dra7xx_mmu_sysc = {
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
+static struct omap_hwmod_class dra7xx_mmu_hwmod_class = {
+	.name = "mmu",
+	.sysc = &dra7xx_mmu_sysc,
+};
+
+/* IPU MMUs */
+static struct omap_hwmod_rst_info dra7xx_mmu_ipu_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 2 },
+};
+
+/* mmu ipu1 */
+static struct omap_hwmod dra7xx_mmu_ipu1_hwmod = {
+	.name		= "mmu_ipu1",
+	.class		= &dra7xx_mmu_hwmod_class,
+	.clkdm_name	= "ipu1_clkdm",
+	.rst_lines	= dra7xx_mmu_ipu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_mmu_ipu_resets),
+	.main_clk	= "ipu1_gfclk_mux",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_IPU1_IPU1_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_IPU1_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_IPU1_IPU1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* mmu ipu2 */
+static struct omap_hwmod dra7xx_mmu_ipu2_hwmod = {
+	.name		= "mmu_ipu2",
+	.class		= &dra7xx_mmu_hwmod_class,
+	.clkdm_name	= "ipu2_clkdm",
+	.rst_lines	= dra7xx_mmu_ipu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_mmu_ipu_resets),
+	.main_clk	= "dpll_core_h22x2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_IPU2_IPU2_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_IPU2_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_IPU2_IPU2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'mpu' class
  *
  */
@@ -2901,6 +2964,22 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_cfg = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_1 -> mmu_ipu1 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu_ipu1 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mmu_ipu1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mmu_ipu2 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu_ipu2 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mmu_ipu2_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> l4_per1 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_per1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -4010,6 +4089,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__mmc2,
 	&dra7xx_l4_per1__mmc3,
 	&dra7xx_l4_per1__mmc4,
+	&dra7xx_l3_main_1__mmu_ipu1,
+	&dra7xx_l3_main_1__mmu_ipu2,
 	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l4_cfg__ocp2scp1,
 	&dra7xx_l4_cfg__ocp2scp3,
-- 
2.13.1
