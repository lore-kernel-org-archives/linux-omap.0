From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/11] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Mon, 24 Aug 2015 10:19:57 +0300
Message-ID: <1440400807-32274-2-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

McASP3 is used by default on DRA7x based boards for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 562247bced49..c38b7fa30c27 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1298,6 +1298,38 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 };
 
 /*
+ * 'mcasp' class
+ *
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
+	.name	= "mcasp",
+	.sysc	= &dra7xx_mcasp_sysc,
+};
+
+/* mcasp3 */
+static struct omap_hwmod dra7xx_mcasp3_hwmod = {
+	.name		= "mcasp3",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp3_ahclkx_mux",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'mmc' class
  *
  */
@@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> mcasp3 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp3_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
 	{
 		.pa_start	= 0x48078000,
@@ -3338,6 +3378,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
 	&dra7xx_l4_per2__cpgmac0,
+	&dra7xx_l4_per2__mcasp3,
 	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__dss,
-- 
2.5.0
