From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 14/15] ARM: DRA7: hwmod: Add ocp2scp3 and sata hwmods
Date: Thu, 19 Sep 2013 16:24:05 +0300
Message-ID: <1379597045-15368-1-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com
Cc: balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Nikhil Devshatwar <nikhil.nd@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Nikhil Devshatwar <nikhil.nd@ti.com>

Add hwmods for ocp2scp3 and sata modules.

[Roger Q] Clean up.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   40 +++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index f647998b..4d7d70f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1215,6 +1215,40 @@ static struct omap_hwmod dra7xx_ocp2scp1_hwmod = {
 	},
 };
 
+/* ocp2scp3 */
+static struct omap_hwmod dra7xx_ocp2scp3_hwmod;
+static struct omap_hwmod_addr_space dra7xx_ocp2scp3_addrs[] = {
+	{
+		.name		= "ocp2scp3",
+		.pa_start	= 0x4a090000,
+		.pa_end		= 0x4a09001f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ocp2scp3 */
+static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp3 = {
+	.master		= &dra7xx_l4_cfg_hwmod,
+	.slave		= &dra7xx_ocp2scp3_hwmod,
+	.clk		= "l4_root_clk_div",
+	.addr		= dra7xx_ocp2scp3_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
+	.name		= "ocp2scp3",
+	.class		= &dra7xx_ocp2scp_hwmod_class,
+	.clkdm_name	= "l3init_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
 /*
  * 'qspi' class
  *
@@ -1268,9 +1302,6 @@ static struct omap_hwmod_class dra7xx_sata_hwmod_class = {
 };
 
 /* sata */
-static struct omap_hwmod_opt_clk sata_opt_clks[] = {
-	{ .role = "ref_clk", .clk = "sata_ref_clk" },
-};
 
 static struct omap_hwmod dra7xx_sata_hwmod = {
 	.name		= "sata",
@@ -1285,8 +1316,6 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= sata_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(sata_opt_clks),
 };
 
 /*
@@ -2683,6 +2712,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__mmc4,
 	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l4_cfg__ocp2scp1,
+	&dra7xx_l4_cfg__ocp2scp3,
 	&dra7xx_l3_main_1__qspi,
 	&dra7xx_l4_cfg__sata,
 	&dra7xx_l4_cfg__smartreflex_core,
-- 
1.7.4.1
