From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 6/8] ARM: OMAP5: hwmod_data: Add data for IPU & DSP processors
Date: Mon, 21 Aug 2017 18:48:16 -0500
Message-ID: <20170821234818.4755-7-s-anna@ti.com>
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

OMAP5, like OMAP4, also has an IPU and a DSP processor subsystems.
The relevant hwmod classes and data structures are added for these
devices.

Do note that these hwmod data strucutures do not have a .modulemode
field as the devices are managed together with their corresponding
MMUs. Each of the processor subsystem and its MMU are present within
the same clock domain and requires the domain be clocked and enabled
until the last entity is disabled. The module is disabled properly
during the omap_device_idle processing of the MMU hwmod while
disabling the MMU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 9a67f013ebad..15f217b5e462 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -335,6 +335,36 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
 };
 
 /*
+ * 'dsp' class
+ * dsp sub-system
+ */
+
+static struct omap_hwmod_class omap54xx_dsp_hwmod_class = {
+	.name	= "dsp",
+};
+
+static struct omap_hwmod_rst_info omap54xx_dsp_resets[] = {
+	{ .name = "dsp", .rst_shift = 0 },
+};
+
+/* dsp */
+static struct omap_hwmod omap54xx_dsp_hwmod = {
+	.name		= "dsp",
+	.class		= &omap54xx_dsp_hwmod_class,
+	.clkdm_name	= "dsp_clkdm",
+	.rst_lines	= omap54xx_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_dsp_resets),
+	.main_clk	= "dpll_iva_h11x2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSP_DSP_CLKCTRL_OFFSET,
+			.rstctrl_offs = OMAP54XX_RM_DSP_RSTCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_DSP_DSP_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'dss' class
  * display sub-system
  */
@@ -940,6 +970,37 @@ static struct omap_hwmod omap54xx_i2c5_hwmod = {
 };
 
 /*
+ * 'ipu' class
+ * image processor unit
+ */
+
+static struct omap_hwmod_class omap54xx_ipu_hwmod_class = {
+	.name	= "ipu",
+};
+
+static struct omap_hwmod_rst_info omap54xx_ipu_resets[] = {
+	{ .name = "cpu0", .rst_shift = 0 },
+	{ .name = "cpu1", .rst_shift = 1 },
+};
+
+/* ipu */
+static struct omap_hwmod omap54xx_ipu_hwmod = {
+	.name		= "ipu",
+	.class		= &omap54xx_ipu_hwmod_class,
+	.clkdm_name	= "ipu_clkdm",
+	.rst_lines	= omap54xx_ipu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_ipu_resets),
+	.main_clk	= "dpll_core_h22x2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_IPU_IPU_CLKCTRL_OFFSET,
+			.rstctrl_offs = OMAP54XX_RM_IPU_RSTCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_IPU_IPU_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'kbd' class
  * keyboard controller
  */
@@ -2135,6 +2196,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* dsp -> l3_main_1 */
+static struct omap_hwmod_ocp_if omap54xx_dsp__l3_main_1 = {
+	.master		= &omap54xx_dsp_hwmod,
+	.slave		= &omap54xx_l3_main_1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> mmu_dsp */
 static struct omap_hwmod_ocp_if omap54xx_l4_cfg__mmu_dsp = {
 	.master		= &omap54xx_l4_cfg_hwmod,
@@ -2167,6 +2236,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_2 -> ipu */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__ipu = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_ipu_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> mmu_ipu */
 static struct omap_hwmod_ocp_if omap54xx_l3_main_2__mmu_ipu = {
 	.master		= &omap54xx_l3_main_2_hwmod,
@@ -2766,7 +2843,9 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l3_main_3__l3_instr,
 	&omap54xx_l3_main_2__l3_main_1,
 	&omap54xx_l4_cfg__l3_main_1,
+	&omap54xx_dsp__l3_main_1,
 	&omap54xx_mpu__l3_main_1,
+	&omap54xx_l3_main_2__ipu,
 	&omap54xx_l3_main_1__l3_main_2,
 	&omap54xx_l4_cfg__l3_main_2,
 	&omap54xx_l3_main_1__l3_main_3,
-- 
2.13.1
