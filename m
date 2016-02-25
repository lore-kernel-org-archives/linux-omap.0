From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/11] ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1
Date: Thu, 25 Feb 2016 16:50:18 +0200
Message-ID: <1456411827-23962-3-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add hwmod data for the eDMA blocks:
 - TPCC: Third-party channel controller
 - TPTC0: Third-party transfer controller 0
 - TPTC1: Third-party transfer controller 1

The TPCC is following it's clock and power domain. This means that
the hwmod can not control it's status.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 88 +++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index b61355e2a771..3953ad031c43 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -430,6 +430,67 @@ static struct omap_hwmod dra7xx_dma_system_hwmod = {
 };
 
 /*
+ * 'tpcc' class
+ *
+ */
+static struct omap_hwmod_class dra7xx_tpcc_hwmod_class = {
+	.name		= "tpcc",
+};
+
+static struct omap_hwmod dra7xx_tpcc_hwmod = {
+	.name		= "tpcc",
+	.class		= &dra7xx_tpcc_hwmod_class,
+	.clkdm_name	= "l3main1_clkdm",
+	.main_clk	= "l3_iclk_div",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = DRA7XX_CM_L3MAIN1_TPCC_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L3MAIN1_TPCC_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
+ * 'tptc' class
+ *
+ */
+static struct omap_hwmod_class dra7xx_tptc_hwmod_class = {
+	.name		= "tptc",
+};
+
+/* tptc0 */
+static struct omap_hwmod dra7xx_tptc0_hwmod = {
+	.name		= "tptc0",
+	.class		= &dra7xx_tptc_hwmod_class,
+	.clkdm_name	= "l3main1_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.main_clk	= "l3_iclk_div",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = DRA7XX_CM_L3MAIN1_TPTC1_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L3MAIN1_TPTC1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* tptc1 */
+static struct omap_hwmod dra7xx_tptc1_hwmod = {
+	.name		= "tptc1",
+	.class		= &dra7xx_tptc_hwmod_class,
+	.clkdm_name	= "l3main1_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.main_clk	= "l3_iclk_div",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = DRA7XX_CM_L3MAIN1_TPTC2_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L3MAIN1_TPTC2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'dss' class
  *
  */
@@ -2563,6 +2624,30 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__dma_system = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_1 -> tpcc */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__tpcc = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_tpcc_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3_main_1 -> tptc0 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__tptc0 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_tptc0_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3_main_1 -> tptc1 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__tptc1 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_tptc1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_addr_space dra7xx_dss_addrs[] = {
 	{
 		.name		= "family",
@@ -3380,6 +3465,9 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__mcasp3,
 	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
+	&dra7xx_l3_main_1__tpcc,
+	&dra7xx_l3_main_1__tptc0,
+	&dra7xx_l3_main_1__tptc1,
 	&dra7xx_l3_main_1__dss,
 	&dra7xx_l3_main_1__dispc,
 	&dra7xx_l3_main_1__hdmi,
-- 
2.7.1
