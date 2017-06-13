From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/3] ARM: OMAP4: hwmod_data: add SHAM crypto accelerator
Date: Tue, 13 Jun 2017 16:45:50 +0300
Message-ID: <1497361550-4735-4-git-send-email-t-kristo@ti.com>
References: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: sebastian.reichel@collabora.co.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP4 SoC contains SHAM crypto hardware accelerator. Add hwmod data for
this IP so that it can be utilized by crypto frameworks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6353e8d..7580db5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -872,6 +872,33 @@
 	.parent_hwmod	= &omap44xx_dss_hwmod,
 };
 
+/* sha0 HIB2 (the 'P' (public) device) */
+static struct omap_hwmod_class_sysconfig omap44xx_sha0_sysc = {
+	.rev_offs	= 0x100,
+	.sysc_offs	= 0x110,
+	.syss_offs	= 0x114,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class omap44xx_sha0_hwmod_class = {
+	.name		= "sham",
+	.sysc		= &omap44xx_sha0_sysc,
+};
+
+struct omap_hwmod omap44xx_sha0_hwmod = {
+	.name		= "sham",
+	.class		= &omap44xx_sha0_hwmod_class,
+	.clkdm_name	= "l4_secure_clkdm",
+	.main_clk	= "l3_div_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L4SEC_SHA2MD51_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4SEC_SHA2MD51_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /*
  * 'elm' class
  * bch error location module
@@ -3979,6 +4007,14 @@ struct omap_hwmod_ocp_if omap44xx_l3_main_2__des = {
 	.user		= OCP_USER_MPU,
 };
 
+/* l3_main_2 -> sham */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sha0 = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_sha0_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per -> elm */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
 	.master		= &omap44xx_l4_per_hwmod,
@@ -4893,6 +4929,7 @@ struct omap_hwmod_ocp_if omap44xx_l3_main_2__des = {
 	&omap44xx_l3_main_2__aes1,
 	&omap44xx_l3_main_2__aes2,
 	&omap44xx_l3_main_2__des,
+	&omap44xx_l3_main_2__sha0,
 	NULL,
 };
 
-- 
1.9.1
