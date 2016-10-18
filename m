From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/7] ARM: DRA7: hwmod: Add data for DES IP
Date: Tue, 18 Oct 2016 10:55:21 +0300
Message-ID: <1476777327-700-2-git-send-email-t-kristo@ti.com>
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

From: Joel Fernandes <joelf@ti.com>

DRA7 SoC contains DES crypto hardware accelerator. Add hwmod data for
this IP so that it can be utilized by crypto frameworks.

Signed-off-by: Joel Fernandes <joelf@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 1ab7096..e89a7ec 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2541,6 +2541,34 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	},
 };
 
+/* DES (the 'P' (public) device) */
+static struct omap_hwmod_class_sysconfig dra7xx_des_sysc = {
+	.rev_offs	= 0x0030,
+	.sysc_offs	= 0x0034,
+	.syss_offs	= 0x0038,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class dra7xx_des_hwmod_class = {
+	.name	= "des",
+	.sysc	= &dra7xx_des_sysc,
+};
+
+/* DES */
+static struct omap_hwmod dra7xx_des_hwmod = {
+	.name		= "des",
+	.class		= &dra7xx_des_hwmod_class,
+	.clkdm_name	= "l4sec_clkdm",
+	.main_clk	= "l3_iclk_div",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4SEC_DES3DES_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4SEC_DES3DES_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
 /*
  * 'usb_otg_ss' class
  *
@@ -3642,6 +3670,14 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per1 -> des */
+static struct omap_hwmod_ocp_if dra7xx_l4_per1__des = {
+	.master		= &dra7xx_l4_per1_hwmod,
+	.slave		= &dra7xx_des_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per2 -> uart8 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per2__uart8 = {
 	.master		= &dra7xx_l4_per2_hwmod,
@@ -3875,6 +3911,7 @@ static int dra7xx_pciess_reset(struct omap_hwmod *oh)
 	&dra7xx_l4_per2__uart8,
 	&dra7xx_l4_per2__uart9,
 	&dra7xx_l4_wkup__uart10,
+	&dra7xx_l4_per1__des,
 	&dra7xx_l4_per3__usb_otg_ss1,
 	&dra7xx_l4_per3__usb_otg_ss2,
 	&dra7xx_l4_per3__usb_otg_ss3,
-- 
1.9.1
