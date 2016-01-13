From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/3] ARM: DRA7: hwmod: Add reset data for PCIe
Date: Wed, 13 Jan 2016 12:17:44 +0530
Message-ID: <1452667666-17533-2-git-send-email-kishon@ti.com>
References: <1452667666-17533-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1452667666-17533-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, nsekhar@ti.com, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add PCIe reset data to PCIe hwmods on DRA7x.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   15 +++++++++++++++
 arch/arm/mach-omap2/prm7xx.h              |    1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ee4e044..1281deb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1532,14 +1532,21 @@ static struct omap_hwmod_class dra7xx_pciess_hwmod_class = {
 };
 
 /* pcie1 */
+static struct omap_hwmod_rst_info dra7xx_pciess1_resets[] = {
+	{ .name = "pcie", .rst_shift = 0 },
+};
+
 static struct omap_hwmod dra7xx_pciess1_hwmod = {
 	.name		= "pcie1",
 	.class		= &dra7xx_pciess_hwmod_class,
 	.clkdm_name	= "pcie_clkdm",
+	.rst_lines	= dra7xx_pciess1_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess1_resets),
 	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
@@ -1547,14 +1554,22 @@ static struct omap_hwmod dra7xx_pciess1_hwmod = {
 };
 
 /* pcie2 */
+static struct omap_hwmod_rst_info dra7xx_pciess2_resets[] = {
+	{ .name = "pcie", .rst_shift = 1 },
+};
+
+/* pcie2 */
 static struct omap_hwmod dra7xx_pciess2_hwmod = {
 	.name		= "pcie2",
 	.class		= &dra7xx_pciess_hwmod_class,
 	.clkdm_name	= "pcie_clkdm",
+	.rst_lines	= dra7xx_pciess2_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess2_resets),
 	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS2_CLKCTRL_OFFSET,
+			.rstctrl_offs = DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_PCIESS2_CONTEXT_OFFSET,
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
diff --git a/arch/arm/mach-omap2/prm7xx.h b/arch/arm/mach-omap2/prm7xx.h
index cc1e6a2..294deed 100644
--- a/arch/arm/mach-omap2/prm7xx.h
+++ b/arch/arm/mach-omap2/prm7xx.h
@@ -360,6 +360,7 @@
 /* PRM.L3INIT_PRM register offsets */
 #define DRA7XX_PM_L3INIT_PWRSTCTRL_OFFSET			0x0000
 #define DRA7XX_PM_L3INIT_PWRSTST_OFFSET				0x0004
+#define DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET			0x0010
 #define DRA7XX_PM_L3INIT_MMC1_WKDEP_OFFSET			0x0028
 #define DRA7XX_RM_L3INIT_MMC1_CONTEXT_OFFSET			0x002c
 #define DRA7XX_PM_L3INIT_MMC2_WKDEP_OFFSET			0x0030
-- 
1.7.9.5
