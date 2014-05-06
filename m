From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/17] arm: dra7xx: Add hwmod data for pcie1 and pcie2 subsystems
Date: Tue, 6 May 2014 19:03:56 +0530
Message-ID: <1399383244-14556-11-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1399383244-14556-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
Cc: rogerq@ti.com, balajitk@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Added hwmod data for pcie1 and pcie2 subsystem present in DRA7xx SOC.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   55 +++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 1282a42..a51fa7f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1231,6 +1231,43 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
 };
 
 /*
+ * 'PCIE' class
+ *
+ */
+
+static struct omap_hwmod_class dra7xx_pcie_hwmod_class = {
+	.name	= "pcie",
+};
+
+/* pcie1 */
+static struct omap_hwmod dra7xx_pcie1_hwmod = {
+	.name		= "pcie1",
+	.class		= &dra7xx_pcie_hwmod_class,
+	.clkdm_name	= "l3init_clkdm",
+	.main_clk	= "l4_root_clk_div",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs	= DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* pcie2 */
+static struct omap_hwmod dra7xx_pcie2_hwmod = {
+	.name		= "pcie2",
+	.class		= &dra7xx_pcie_hwmod_class,
+	.clkdm_name	= "l3init_clkdm",
+	.main_clk	= "l4_root_clk_div",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'PCIE PHY' class
  *
  */
@@ -2388,6 +2425,22 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_cfg -> pcie1 */
+static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1 = {
+	.master		= &dra7xx_l4_cfg_hwmod,
+	.slave		= &dra7xx_pcie1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_cfg -> pcie2 */
+static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2 = {
+	.master		= &dra7xx_l4_cfg_hwmod,
+	.slave		= &dra7xx_pcie2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> pcie1 phy */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1_phy = {
 	.master		= &dra7xx_l4_cfg_hwmod,
@@ -2751,6 +2804,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l4_cfg__ocp2scp1,
 	&dra7xx_l4_cfg__ocp2scp3,
+	&dra7xx_l4_cfg__pcie1,
+	&dra7xx_l4_cfg__pcie2,
 	&dra7xx_l4_cfg__pcie1_phy,
 	&dra7xx_l4_cfg__pcie2_phy,
 	&dra7xx_l3_main_1__qspi,
-- 
1.7.9.5

