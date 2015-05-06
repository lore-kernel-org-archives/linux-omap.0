From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod
Date: Wed, 6 May 2015 12:25:32 -0500
Message-ID: <1430933133-33412-2-git-send-email-d-gerlach@ti.com>
References: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58832 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbbEFR0J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 13:26:09 -0400
In-Reply-To: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>

Without a hwmod for am43xx emif use counting for emif clockdomain does
not happen correctly so it may be shut off by pm code unintentionally.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 13 -------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 22 ++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h                     |  1 +
 5 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index 130332c..7f73796 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -145,6 +145,7 @@ extern struct omap_hwmod am33xx_uart5_hwmod;
 extern struct omap_hwmod am33xx_uart6_hwmod;
 extern struct omap_hwmod am33xx_wd_timer1_hwmod;
 
+extern struct omap_hwmod_class am33xx_emif_hwmod_class;
 extern struct omap_hwmod_class am33xx_l4_hwmod_class;
 extern struct omap_hwmod_class am33xx_wkup_m3_hwmod_class;
 extern struct omap_hwmod_class am33xx_control_hwmod_class;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index cabc569..09907e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -203,6 +203,19 @@ struct omap_hwmod am33xx_prcm_hwmod = {
 };
 
 /*
+ * 'emif' class
+ * instance(s): emif
+ */
+static struct omap_hwmod_class_sysconfig am33xx_emif_sysc = {
+	.rev_offs	= 0x0000,
+};
+
+struct omap_hwmod_class am33xx_emif_hwmod_class = {
+	.name		= "emif",
+	.sysc		= &am33xx_emif_sysc,
+};
+
+/*
  * 'aes0' class
  */
 static struct omap_hwmod_class_sysconfig am33xx_aes0_sysc = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 0cf7b56..cc0791d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -34,19 +34,6 @@
  * IP blocks
  */
 
-/*
- * 'emif' class
- * instance(s): emif
- */
-static struct omap_hwmod_class_sysconfig am33xx_emif_sysc = {
-	.rev_offs	= 0x0000,
-};
-
-static struct omap_hwmod_class am33xx_emif_hwmod_class = {
-	.name		= "emif",
-	.sysc		= &am33xx_emif_sysc,
-};
-
 /* emif */
 static struct omap_hwmod am33xx_emif_hwmod = {
 	.name		= "emif",
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e222314..ad0ee8f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -24,6 +24,20 @@
 
 
 /* IP blocks */
+static struct omap_hwmod am43xx_emif_hwmod = {
+	.name		= "emif",
+	.class		= &am33xx_emif_hwmod_class,
+	.clkdm_name	= "emif_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE,
+	.main_clk	= "dpll_ddr_m2_ck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 static struct omap_hwmod am43xx_l4_hs_hwmod = {
 	.name		= "l4_hs",
 	.class		= &am33xx_l4_hwmod_class,
@@ -545,6 +559,13 @@ static struct omap_hwmod am43xx_hdq1w_hwmod = {
 };
 
 /* Interfaces */
+static struct omap_hwmod_ocp_if am43xx_l3_main__emif = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am43xx_emif_hwmod,
+	.clk		= "dpll_core_m4_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
 	.slave		= &am43xx_l4_hs_hwmod,
@@ -852,6 +873,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__l3_instr,
 	&am33xx_l3_main__gfx,
 	&am33xx_l3_s__l3_main,
+	&am43xx_l3_main__emif,
 	&am33xx_pruss__l3_main,
 	&am43xx_wkup_m3__l4_wkup,
 	&am33xx_gfx__l3_main,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 48df3b5..32bfab6 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -144,5 +144,6 @@
 #define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
 #define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
 #define AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET		0x04a0
+#define AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET		0x0720
 
 #endif
-- 
2.3.6

