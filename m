From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 4/4] arm: omap2+: Add hwmod spinbox support for dm816x
Date: Fri, 13 Nov 2015 17:30:10 +0100
Message-ID: <56461012.8090700@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

Add dm81xx hwmod data entries for dm816x spinbox support.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 6256052..275b16c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -1036,6 +1036,40 @@ static struct omap_hwmod_ocp_if dm81xx_l4_ls__mailbox = {
 	.user		= OCP_USER_MPU,
 };

+static struct omap_hwmod_class_sysconfig dm81xx_spinbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class dm81xx_spinbox_hwmod_class = {
+	.name = "spinbox",
+	.sysc = &dm81xx_spinbox_sysc,
+};
+
+static struct omap_hwmod dm81xx_spinbox_hwmod = {
+	.name		= "spinbox",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.class		= &dm81xx_spinbox_hwmod_class,
+	.main_clk	= "sysclk6_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM81XX_CM_ALWON_SPINBOX_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__spinbox = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_spinbox_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_class dm81xx_tpcc_hwmod_class = {
 	.name		= "tpcc",
 };
@@ -1298,6 +1332,7 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm816x_l4_ls__timer7,
 	&dm81xx_l4_ls__mcspi1,
 	&dm81xx_l4_ls__mailbox,
+	&dm81xx_l4_ls__spinbox,
 	&dm81xx_l4_hs__emac0,
 	&dm81xx_emac0__mdio,
 	&dm816x_l4_hs__emac1,
-- 
1.9.1
