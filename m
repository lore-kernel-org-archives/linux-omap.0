From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] arm: omap5: hwmod: add missing ocp2scp hwmod data
Date: Mon, 15 Jul 2013 18:33:41 +0300
Message-ID: <1373902423-28654-3-git-send-email-balbi@ti.com>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49340 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab3GOPed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 11:34:33 -0400
In-Reply-To: <1373902423-28654-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, Felipe Balbi <balbi@ti.com>

From: Benoit Cousson <benoit.cousson@linaro.org>

without that hwmod data, USB3 will not in OMAP5 boards.

While at that, also fix DTS data to pass reg property,
otherwise driver won't probe.

Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi               |  3 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5c99f19..4e41409 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -652,10 +652,11 @@
 			};
 		};
 
-		ocp2scp {
+		ocp2scp@4a080000 {
 			compatible = "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			reg = <0x4a080000 0x20>;
 			ranges;
 			ti,hwmods = "ocp2scp1";
 			usb2_phy: usb2phy@4a084000 {
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index f37ae96..542eddd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1114,6 +1114,42 @@ static struct omap_hwmod omap54xx_mpu_hwmod = {
 };
 
 /*
+ * 'ocp2scp' class
+ * bridge to transform ocp interface protocol to scp (serial control port)
+ * protocol
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_ocp2scp_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap54xx_ocp2scp_hwmod_class = {
+	.name	= "ocp2scp",
+	.sysc	= &omap54xx_ocp2scp_sysc,
+};
+
+/* ocp2scp1 */
+static struct omap_hwmod omap54xx_ocp2scp1_hwmod = {
+	.name		= "ocp2scp1",
+	.class		= &omap54xx_ocp2scp_hwmod_class,
+	.clkdm_name	= "l3init_clkdm",
+	.main_clk	= "l4_root_clk_div",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_L3INIT_OCP2SCP1_CLKCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_L3INIT_OCP2SCP1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'timer' class
  * general purpose timer module with accurate 1ms tick
  * This class contains several variants: ['timer_1ms', 'timer']
@@ -1919,6 +1955,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_cfg -> ocp2scp1 */
+static struct omap_hwmod_ocp_if omap54xx_l4_cfg__ocp2scp1 = {
+	.master		= &omap54xx_l4_cfg_hwmod,
+	.slave		= &omap54xx_ocp2scp1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap54xx_l4_wkup__timer1 = {
 	.master		= &omap54xx_l4_wkup_hwmod,
@@ -2121,6 +2165,7 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_per__mmc4,
 	&omap54xx_l4_per__mmc5,
 	&omap54xx_l4_cfg__mpu,
+	&omap54xx_l4_cfg__ocp2scp1,
 	&omap54xx_l4_wkup__timer1,
 	&omap54xx_l4_per__timer2,
 	&omap54xx_l4_per__timer3,
-- 
1.8.2.1

