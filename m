From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/8] ARM: DRA7: hwmod data: Add MMU data for DSPs
Date: Mon, 21 Aug 2017 18:48:12 -0500
Message-ID: <20170821234818.4755-3-s-anna@ti.com>
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

Add the data structures for representing the MMUs within the DSP
processor subsystems present in DRA7xx/AM57xx SoCs. The DRA7xx
family of SoCs usually have one or two DSPs. The DRA74x/DRA76x
family has two DSPs, while DRA72x/DRA71x has only a single DSP.
Each DSP subsystem has two MMUs, one for the processor core and
the other for the internal EDMA block. The hwmod data for the
second DSP is only added for DRA74x/DRA76x family of SoCs.

Both these MMUs share a common reset line, the MMU on the EDMA
port is expected to be mirror-programmed alongside the primary
MMU. The reset data is added to both the MMUs to allow the
omap_hwmod layer to skip the enabling and idling of these devices,
as that would require the reset be released, which is outside
the scope of the hwmod core code. The other PRCM data fields are
also skipped for both the second MMUs, this will be handled as
part of the primary MMU enabling sequence. The pdata quirks will
also not be added for the second MMU as the OMAP IOMMU driver
releases the reset once and is expected to program both the MMUs
together.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 109 ++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index bf55802448ac..63ad0d3217dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1821,6 +1821,77 @@ static struct omap_hwmod_class dra7xx_mmu_hwmod_class = {
 	.sysc = &dra7xx_mmu_sysc,
 };
 
+/* DSP MMUs */
+static struct omap_hwmod_rst_info dra7xx_mmu_dsp_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 1 },
+};
+
+/* mmu0 - dsp1 */
+static struct omap_hwmod dra7xx_mmu0_dsp1_hwmod = {
+	.name		= "mmu0_dsp1",
+	.class		= &dra7xx_mmu_hwmod_class,
+	.clkdm_name	= "dsp1_clkdm",
+	.rst_lines	= dra7xx_mmu_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_mmu_dsp_resets),
+	.main_clk	= "dpll_dsp_m2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_DSP1_DSP1_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_DSP1_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_DSP1_DSP1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* mmu1 - dsp1 */
+static struct omap_hwmod dra7xx_mmu1_dsp1_hwmod = {
+	.name		= "mmu1_dsp1",
+	.class		= &dra7xx_mmu_hwmod_class,
+	.clkdm_name	= "dsp1_clkdm",
+	.rst_lines	= dra7xx_mmu_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_mmu_dsp_resets),
+	.main_clk	= "dpll_dsp_m2_ck",
+	.prcm = {
+		.omap4 = {
+			.rstctrl_offs = DRA7XX_RM_DSP1_RSTCTRL_OFFSET,
+		},
+	},
+};
+
+/* mmu0 - dsp2 */
+static struct omap_hwmod dra7xx_mmu0_dsp2_hwmod = {
+	.name		= "mmu0_dsp2",
+	.class		= &dra7xx_mmu_hwmod_class,
+	.clkdm_name	= "dsp2_clkdm",
+	.rst_lines	= dra7xx_mmu_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_mmu_dsp_resets),
+	.main_clk	= "dpll_dsp_m2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_DSP2_DSP2_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_DSP2_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_DSP2_DSP2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* mmu1 - dsp2 */
+static struct omap_hwmod dra7xx_mmu1_dsp2_hwmod = {
+	.name		= "mmu1_dsp2",
+	.class		= &dra7xx_mmu_hwmod_class,
+	.clkdm_name	= "dsp2_clkdm",
+	.rst_lines	= dra7xx_mmu_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_mmu_dsp_resets),
+	.main_clk	= "dpll_dsp_m2_ck",
+	.prcm = {
+		.omap4 = {
+			.rstctrl_offs = DRA7XX_RM_DSP2_RSTCTRL_OFFSET,
+		},
+	},
+};
+
 /* IPU MMUs */
 static struct omap_hwmod_rst_info dra7xx_mmu_ipu_resets[] = {
 	{ .name = "mmu_cache", .rst_shift = 2 },
@@ -2964,6 +3035,38 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_cfg = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_1 -> mmu0_dsp1 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu0_dsp1 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mmu0_dsp1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mmu1_dsp1 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu1_dsp1 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mmu1_dsp1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mmu0_dsp2 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu0_dsp2 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mmu0_dsp2_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mmu1_dsp2 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu1_dsp2 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mmu1_dsp2_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> mmu_ipu1 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mmu_ipu1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -4089,6 +4192,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__mmc2,
 	&dra7xx_l4_per1__mmc3,
 	&dra7xx_l4_per1__mmc4,
+	&dra7xx_l3_main_1__mmu0_dsp1,
+	&dra7xx_l3_main_1__mmu1_dsp1,
 	&dra7xx_l3_main_1__mmu_ipu1,
 	&dra7xx_l3_main_1__mmu_ipu2,
 	&dra7xx_l4_cfg__mpu,
@@ -4153,11 +4258,15 @@ static struct omap_hwmod_ocp_if *dra7xx_gp_hwmod_ocp_ifs[] __initdata = {
 /* SoC variant specific hwmod links */
 static struct omap_hwmod_ocp_if *dra76x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
+	&dra7xx_l3_main_1__mmu0_dsp2,
+	&dra7xx_l3_main_1__mmu1_dsp2,
 	NULL,
 };
 
 static struct omap_hwmod_ocp_if *dra74x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
+	&dra7xx_l3_main_1__mmu0_dsp2,
+	&dra7xx_l3_main_1__mmu1_dsp2,
 	NULL,
 };
 
-- 
2.13.1
