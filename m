From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v2 1/1] ARM: OMAP2+: DRA7: hwmod: Add hwmod data for MDIO and
 CPSW
Date: Fri, 18 Oct 2013 20:21:27 +0530
Message-ID: <1382107887-11728-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: paul@pwsan.com
Cc: tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
Changes from initial version:
* changed the subject with proper text
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index db32d53..9a8191b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -273,6 +273,55 @@ static struct omap_hwmod dra7xx_ctrl_module_wkup_hwmod = {
 };
 
 /*
+ * 'gmac' class
+ * cpsw/gmac sub system
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_gmac_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x8,
+	.syss_offs	= 0x4,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | MSTANDBY_FORCE |
+			   MSTANDBY_NO),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_gmac_hwmod_class = {
+	.name		= "gmac",
+	.sysc		= &dra7xx_gmac_sysc,
+};
+
+static struct omap_hwmod dra7xx_gmac_hwmod = {
+	.name		= "gmac",
+	.class		= &dra7xx_gmac_hwmod_class,
+	.clkdm_name	= "gmac_clkdm",
+	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
+	.main_clk	= "dpll_gmac_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= DRA7XX_CM_GMAC_GMAC_CLKCTRL_OFFSET,
+			.context_offs	= DRA7XX_RM_GMAC_GMAC_CONTEXT_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
+ * 'mdio' class
+ */
+static struct omap_hwmod_class dra7xx_mdio_hwmod_class = {
+	.name		= "davinci_mdio",
+};
+
+static struct omap_hwmod dra7xx_mdio_hwmod = {
+	.name		= "davinci_mdio",
+	.class		= &dra7xx_mdio_hwmod_class,
+	.clkdm_name	= "gmac_clkdm",
+	.main_clk	= "dpll_gmac_ck",
+};
+
+/*
  * 'dcan' class
  *
  */
@@ -2000,6 +2049,19 @@ static struct omap_hwmod_ocp_if dra7xx_l4_wkup__ctrl_module_wkup = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__cpgmac0 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_gmac_hwmod,
+	.clk		= "dpll_gmac_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if dra7xx_gmac__mdio = {
+	.master		= &dra7xx_gmac_hwmod,
+	.slave		= &dra7xx_mdio_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
 /* l4_wkup -> dcan1 */
 static struct omap_hwmod_ocp_if dra7xx_l4_wkup__dcan1 = {
 	.master		= &dra7xx_l4_wkup_hwmod,
@@ -2653,6 +2715,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__ctrl_module_wkup,
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
+	&dra7xx_l4_per2__cpgmac0,
+	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__dss,
 	&dra7xx_l3_main_1__dispc,
-- 
1.8.4.1.516.g1d25dd4
