From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 5/5] ARM: OMAP4: hwmod data: add des
Date: Tue, 13 Jun 2017 11:28:47 +0200
Message-ID: <20170613092847.16732-6-sebastian.reichel@collabora.co.uk>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

This fixes the following error during kernel boot:

platform 480a5000.des: Cannot lookup hwmod 'des'

Unfortunately the DES module is only documented partly
in the OMAP4430 TRM. I found an old patch from Joel,
which I took over and updated for currently mainline.

Signed-off-by: Joel Fernandes <joelf@ti.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3d58eaef387e..6353e8df9b76 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1014,6 +1014,42 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__aes2 = {
 };
 
 /*
+ * 'des' class for DES3DES module
+ */
+static struct omap_hwmod_class_sysconfig omap44xx_des_sysc = {
+	.rev_offs	= 0x30,
+	.sysc_offs	= 0x34,
+	.syss_offs	= 0x38,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class omap44xx_des_hwmod_class = {
+	.name		= "des",
+	.sysc		= &omap44xx_des_sysc,
+};
+
+static struct omap_hwmod omap44xx_des_hwmod = {
+	.name		= "des",
+	.class		= &omap44xx_des_hwmod_class,
+	.clkdm_name	= "l4_secure_clkdm",
+	.main_clk	= "l3_div_ck",
+	.prcm		= {
+		.omap4	= {
+			.context_offs	= OMAP4_RM_L4SEC_DES3DES_CONTEXT_OFFSET,
+			.clkctrl_offs	= OMAP4_CM_L4SEC_DES3DES_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+struct omap_hwmod_ocp_if omap44xx_l3_main_2__des = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_des_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/*
  * 'fdif' class
  * face detection hw accelerator module
  */
@@ -4856,6 +4892,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mpu__emif2,
 	&omap44xx_l3_main_2__aes1,
 	&omap44xx_l3_main_2__aes2,
+	&omap44xx_l3_main_2__des,
 	NULL,
 };
 
-- 
2.11.0
