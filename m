From: Hema HK <hemahk@ti.com>
Subject: [PATCH 4/6 v8] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 12:07:20 +0530
Message-ID: <1297924642-3791-5-git-send-email-hemahk@ti.com>
References: <1297924642-3791-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab1BQGhh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 01:37:37 -0500
In-Reply-To: <1297924642-3791-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

OMAP4 hwmod data structures are populated with base address, L3 and L4
interface clocks, IRQs and sysconfig register details.

As per OMAP USBOTG specification, need to configure the USBOTG
to smart idle/standby or no idle/standby during data transfer and
force idle/standby when not in use to support retention and offmode.
By setting HWMOD_SWSUP_SIDLE and HWMOD_SWSUP_MSTANDBY flags,framework
will take care of configuring to no idle/standby when module is enabled
and force idle/standby when idled.

Signed-off-by: Cousson, Benoit <b-cousson@ti.com>
Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   93 +++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ linux-2.6/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -55,6 +55,7 @@ static struct omap_hwmod omap44xx_l4_per
 static struct omap_hwmod omap44xx_l4_wkup_hwmod;
 static struct omap_hwmod omap44xx_mpu_hwmod;
 static struct omap_hwmod omap44xx_mpu_private_hwmod;
+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
 
 /*
  * Interconnects omap_hwmod structures
@@ -286,12 +287,21 @@ static struct omap_hwmod_ocp_if omap44xx
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* usb_otg_hs -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs__l3_main_2 = {
+	.master		= &omap44xx_usb_otg_hs_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_iva__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
+	&omap44xx_usb_otg_hs__l3_main_2,
 };
 
 static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
@@ -2001,6 +2011,87 @@ static struct omap_hwmod omap44xx_wd_tim
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'usb_otg_hs' class
+ * high-speed on-the-go universal serial bus (usb_otg_hs) controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
+	.rev_offs	= 0x0400,
+	.sysc_offs	= 0x0404,
+	.syss_offs	= 0x0408,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
+			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			  SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
+	.name = "usb_otg_hs",
+	.sysc = &omap44xx_usb_otg_hs_sysc,
+};
+
+/* usb_otg_hs */
+static struct omap_hwmod_irq_info omap44xx_usb_otg_hs_irqs[] = {
+	{ .name = "mc", .irq = 92 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dma", .irq = 93 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* usb_otg_hs master ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_masters[] = {
+	&omap44xx_usb_otg_hs__l3_main_2,
+};
+
+static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
+	{
+		.pa_start	= OMAP44XX_HSUSB_OTG_BASE,
+		.pa_end		= OMAP44XX_HSUSB_OTG_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> usb_otg_hs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_otg_hs = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_usb_otg_hs_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_usb_otg_hs_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_otg_hs slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_slaves[] = {
+	&omap44xx_l4_cfg__usb_otg_hs,
+};
+
+static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
+	{ .role = "xclk", .clk = "otg_60m_gfclk_ck" },
+};
+
+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
+	.name		= "usb_otg_hs",
+	.class		= &omap44xx_usb_otg_hs_hwmod_class,
+	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_irqs),
+	.main_clk	= "usb_otg_hs_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+		},
+	},
+	.opt_clks	= usb_otg_hs_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(usb_otg_hs_opt_clks),
+	.slaves		= omap44xx_usb_otg_hs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
+	.masters	= omap44xx_usb_otg_hs_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_masters),
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* dmm class */
@@ -2068,6 +2159,8 @@ static __initdata struct omap_hwmod *oma
 	&omap44xx_wd_timer2_hwmod,
 	&omap44xx_wd_timer3_hwmod,
 
+	/* hsusb otg class */
+	&omap44xx_usb_otg_hs_hwmod,
 	NULL,
 };
 
