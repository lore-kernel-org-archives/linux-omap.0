From: George Cherian <george.cherian@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: Add USB hwmod data for AM437x.
Date: Mon, 14 Oct 2013 18:06:24 +0530
Message-ID: <1381754184-11180-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955Ab3JNMhC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Oct 2013 08:37:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, bcousson@baylibre.com, nsekhar@ti.com, afzal@ti.com, George Cherian <george.cherian@ti.com>

Add hwmod for USBSS and the OCP2SCP for AM437x.
AM437x has got 2 instances of USBSS.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
This was tested on AM437x EPOS EVM with Afzal's v6 of AM43x PRCM basic support 
and Tero's DT clock Series 

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 105 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |   4 ++
 2 files changed, 109 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 6500d43..a58024d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -316,6 +316,79 @@ static struct omap_hwmod am43xx_gpio5_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 };
 
+static struct omap_hwmod_class am43xx_ocp2scp_hwmod_class = {
+	.name	= "ocp2scp",
+};
+
+static struct omap_hwmod am43xx_ocp2scp0_hwmod = {
+	.name		= "ocp2scp0",
+	.class		= &am43xx_ocp2scp_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_ocp2scp1_hwmod = {
+	.name		= "ocp2scp1",
+	.class		= &am43xx_ocp2scp_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs	= AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_usb_otg_ss_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_DMADISABLE | SYSC_HAS_MIDLEMODE |
+				SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP | MSTANDBY_FORCE |
+				MSTANDBY_NO | MSTANDBY_SMART |
+				MSTANDBY_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class am43xx_usb_otg_ss_hwmod_class = {
+	.name	= "usb_otg_ss",
+	.sysc	= &am43xx_usb_otg_ss_sysc,
+};
+
+static struct omap_hwmod am43xx_usb_otg_ss0_hwmod = {
+	.name		= "usb_otg_ss0",
+	.class		= &am43xx_usb_otg_ss_hwmod_class,
+	.clkdm_name	= "l3s_clkdm",
+	.main_clk	= "l3s_gclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs	= AM43XX_CM_PER_USB_OTG_SS0_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod am43xx_usb_otg_ss1_hwmod = {
+	.name		= "usb_otg_ss1",
+	.class		= &am43xx_usb_otg_ss_hwmod_class,
+	.clkdm_name	= "l3s_clkdm",
+	.main_clk	= "l3s_gclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs	= AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -520,6 +593,34 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l4_ls__ocp2scp0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_ocp2scp0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__ocp2scp1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_ocp2scp1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l3_s__usbotgss0 = {
+	.master         = &am33xx_l3_s_hwmod,
+	.slave          = &am43xx_usb_otg_ss0_hwmod,
+	.clk            = "l3s_gclk",
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l3_s__usbotgss1 = {
+	.master         = &am33xx_l3_s_hwmod,
+	.slave          = &am43xx_usb_otg_ss1_hwmod,
+	.clk            = "l3s_gclk",
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -608,6 +709,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_cpgmac0__mdio,
 	&am33xx_l3_main__sha0,
 	&am33xx_l3_main__aes0,
+	&am43xx_l4_ls__ocp2scp0,
+	&am43xx_l4_ls__ocp2scp1,
+	&am43xx_l3_s__usbotgss0,
+	&am43xx_l3_s__usbotgss1,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index f0636ec..0d66a6e 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -137,5 +137,9 @@
 #define AM43XX_CM_PER_SPI4_CLKCTRL_OFFSET		0x0520
 #define AM43XX_CM_PER_GPIO4_CLKCTRL_OFFSET		0x0490
 #define AM43XX_CM_PER_GPIO5_CLKCTRL_OFFSET		0x0498
+#define AM43XX_CM_PER_USB_OTG_SS0_CLKCTRL_OFFSET	0x0260
+#define AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET	0x05B8
+#define AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET        0x0268
+#define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
 
 #endif
-- 
1.8.1

