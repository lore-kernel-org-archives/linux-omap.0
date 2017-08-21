From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 7/8] ARM: DRA7: hwmod_data: Add data for IPUs
Date: Mon, 21 Aug 2017 18:48:17 -0500
Message-ID: <20170821234818.4755-8-s-anna@ti.com>
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

The DRA7xx family of SoCs usually have two IPU remote processor
subsystems. These subsystems are very similar to the respective
processor subsystems on OMAP4/OMAP5 in terms of clock and reset
integration. The relevant hwmod classes and data structures are
added for IPU1 and IPU2 remoteproc devices that's present on
almost all DRA7xx/AM57xx SoCs.

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
index 63ad0d3217dc..e65a02855633 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1201,6 +1201,54 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
 };
 
 /*
+ * 'ipu' class
+ * image processor unit
+ */
+
+static struct omap_hwmod_class dra7xx_ipu_hwmod_class = {
+	.name	= "ipu",
+};
+
+static struct omap_hwmod_rst_info dra7xx_ipu_resets[] = {
+	{ .name = "cpu0", .rst_shift = 0 },
+	{ .name = "cpu1", .rst_shift = 1 },
+};
+
+/* ipu1 processor */
+static struct omap_hwmod dra7xx_ipu1_hwmod = {
+	.name		= "ipu1",
+	.class		= &dra7xx_ipu_hwmod_class,
+	.clkdm_name	= "ipu1_clkdm",
+	.rst_lines	= dra7xx_ipu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_ipu_resets),
+	.main_clk	= "ipu1_gfclk_mux",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_IPU1_IPU1_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_IPU1_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_IPU1_IPU1_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/* ipu2 processor */
+static struct omap_hwmod dra7xx_ipu2_hwmod = {
+	.name		= "ipu2",
+	.class		= &dra7xx_ipu_hwmod_class,
+	.clkdm_name	= "ipu2_clkdm",
+	.rst_lines	= dra7xx_ipu_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_ipu_resets),
+	.main_clk	= "dpll_core_h22x2_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_IPU2_IPU2_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_IPU2_RSTCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_IPU2_IPU2_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'mailbox' class
  *
  */
@@ -3492,6 +3540,22 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__i2c5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* ipu1 -> l3_main_1 */
+static struct omap_hwmod_ocp_if dra7xx_ipu1__l3_main_1 = {
+	.master		= &dra7xx_ipu1_hwmod,
+	.slave		= &dra7xx_l3_main_1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ipu2 -> l3_main_1 */
+static struct omap_hwmod_ocp_if dra7xx_ipu2__l3_main_1 = {
+	.master		= &dra7xx_ipu2_hwmod,
+	.slave		= &dra7xx_l3_main_1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> mailbox1 */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mailbox1 = {
 	.master		= &dra7xx_l4_cfg_hwmod,
@@ -4171,6 +4235,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__i2c3,
 	&dra7xx_l4_per1__i2c4,
 	&dra7xx_l4_per1__i2c5,
+	&dra7xx_ipu1__l3_main_1,
+	&dra7xx_ipu2__l3_main_1,
 	&dra7xx_l4_cfg__mailbox1,
 	&dra7xx_l4_per3__mailbox2,
 	&dra7xx_l4_per3__mailbox3,
-- 
2.13.1
