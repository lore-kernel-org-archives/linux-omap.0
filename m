From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/7] ARM: DRA7: hwmod: Add data for SHA IP
Date: Tue, 18 Oct 2016 10:55:23 +0300
Message-ID: <1476777327-700-4-git-send-email-t-kristo@ti.com>
References: <1476777327-700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476777327-700-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

DRA7 SoC contains SHA crypto hardware accelerator. Add hwmod data for
this IP so that it can be utilized by crypto frameworks.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 4988a9e..87e9293 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -734,6 +734,34 @@
 	},
 };
 
+/* sha0 HIB2 (the 'P' (public) device) */
+static struct omap_hwmod_class_sysconfig dra7xx_sha0_sysc = {
+	.rev_offs	= 0x100,
+	.sysc_offs	= 0x110,
+	.syss_offs	= 0x114,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class dra7xx_sha0_hwmod_class = {
+	.name		= "sham",
+	.sysc		= &dra7xx_sha0_sysc,
+	.rev		= 2,
+};
+
+struct omap_hwmod dra7xx_sha0_hwmod = {
+	.name		= "sham",
+	.class		= &dra7xx_sha0_hwmod_class,
+	.clkdm_name	= "l4sec_clkdm",
+	.main_clk	= "l3_iclk_div",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4SEC_SHA2MD51_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4SEC_SHA2MD51_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
 /*
  * 'elm' class
  *
@@ -3017,6 +3045,14 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_1 -> sha0 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__sha0 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_sha0_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per2 -> mcasp1 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp1 = {
 	.master		= &dra7xx_l4_per2_hwmod,
@@ -3898,6 +3934,7 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	&dra7xx_l3_main_1__hdmi,
 	&dra7xx_l3_main_1__aes1,
 	&dra7xx_l3_main_1__aes2,
+	&dra7xx_l3_main_1__sha0,
 	&dra7xx_l4_per1__elm,
 	&dra7xx_l4_wkup__gpio1,
 	&dra7xx_l4_per1__gpio2,
-- 
1.9.1
