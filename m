From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 8/8] ARM: DRA7: hwmod_data: Add data for DSPs
Date: Mon, 21 Aug 2017 18:48:18 -0500
Message-ID: <20170821234818.4755-9-s-anna@ti.com>
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

The DRA7xx family of SoCs can have up to two identical DSP
processor subsystems, with most of them having a single DSP
processor subsystem. The second DSP is present only on DRA74x
and DRA76x variants currently.

These subsystems are very similar to the respective processor
subsystems on OMAP4/OMAP5 in terms of clock and reset integration.
The relevant hwmod class and data structures are added for both
the DSP remoteproc devices, with the data for DSP2 added only
on DRA74x/DRA76x variants.

Do note that these hwmod data structures do not have a .modulemode
field as the devices are managed together with their corresponding
MMUs. Each of the processor subsystem and its MMU are present within
the same clock domain and requires the domain be clocked and enabled
until the last entity is disabled. The module is disabled properly
during the omap_device_idle processing of the MMU hwmod while
disabling the MMU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index e65a02855633..2a6341753c70 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -555,6 +555,53 @@ static struct omap_hwmod dra7xx_tptc1_hwmod = {
 };
 
 /*
+ * 'dsp' class
+ * dsp sub-system
+ */
+
+static struct omap_hwmod_class dra7xx_dsp_hwmod_class = {
+	.name   = "dsp",
+};
+
+static struct omap_hwmod_rst_info dra7xx_dsp_resets[] = {
+	{ .name = "dsp", .rst_shift = 0 },
+};
+
+/* dsp1 processor */
+static struct omap_hwmod dra7xx_dsp1_hwmod = {
+	.name		= "dsp1",
+	.class		= &dra7xx_dsp_hwmod_class,
+	.clkdm_name	= "dsp1_clkdm",
+	.rst_lines	= dra7xx_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_dsp_resets),
+	.main_clk	= "dpll_dsp_m2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_DSP1_DSP1_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_DSP1_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_DSP1_DSP1_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/* dsp2 processor */
+static struct omap_hwmod dra7xx_dsp2_hwmod = {
+	.name		= "dsp2",
+	.class		= &dra7xx_dsp_hwmod_class,
+	.clkdm_name	= "dsp2_clkdm",
+	.rst_lines	= dra7xx_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_dsp_resets),
+	.main_clk	= "dpll_dsp_m2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_DSP2_DSP2_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_DSP2_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_DSP2_DSP2_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'dss' class
  *
  */
@@ -3266,6 +3313,22 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__tptc1 = {
 	.user		= OCP_USER_MPU,
 };
 
+/* dsp1 -> l3_main_1 */
+static struct omap_hwmod_ocp_if dra7xx_dsp1__l3_main_1 = {
+	.master		= &dra7xx_dsp1_hwmod,
+	.slave		= &dra7xx_l3_main_1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp2 -> l3_main_1 */
+static struct omap_hwmod_ocp_if dra7xx_dsp2__l3_main_1 = {
+	.master		= &dra7xx_dsp2_hwmod,
+	.slave		= &dra7xx_l3_main_1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> dss */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__dss = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -4215,6 +4278,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__tptc1,
 	&dra7xx_l3_main_1__dss,
 	&dra7xx_l3_main_1__dispc,
+	&dra7xx_dsp1__l3_main_1,
 	&dra7xx_l3_main_1__hdmi,
 	&dra7xx_l3_main_1__aes1,
 	&dra7xx_l3_main_1__aes2,
@@ -4326,6 +4390,7 @@ static struct omap_hwmod_ocp_if *dra76x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
 	&dra7xx_l3_main_1__mmu0_dsp2,
 	&dra7xx_l3_main_1__mmu1_dsp2,
+	&dra7xx_dsp2__l3_main_1,
 	NULL,
 };
 
@@ -4333,6 +4398,7 @@ static struct omap_hwmod_ocp_if *dra74x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
 	&dra7xx_l3_main_1__mmu0_dsp2,
 	&dra7xx_l3_main_1__mmu1_dsp2,
+	&dra7xx_dsp2__l3_main_1,
 	NULL,
 };
 
-- 
2.13.1
