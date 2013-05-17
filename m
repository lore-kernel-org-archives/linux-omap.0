From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] ARM: OMAP2+: Remove omap4 pdata for USB
Date: Fri, 17 May 2013 12:18:01 -0700
Message-ID: <20130517191801.468.56731.stgit@localhost>
References: <20130517191304.468.73487.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21755 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab3EQTSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 15:18:03 -0400
In-Reply-To: <20130517191304.468.73487.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is no longer needed as omap4 is now booted
using device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c  |   45 ---------
 arch/arm/mach-omap2/usb-host.c |  194 ----------------------------------------
 arch/arm/mach-omap2/usb-musb.c |    3 -
 3 files changed, 242 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 4269fc1..0fd3834 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,7 +20,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
 #include <linux/platform_data/omap_ocp2scp.h>
-#include <linux/usb/omap_control_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -253,49 +252,6 @@ static inline void omap_init_camera(void)
 #endif
 }
 
-#if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)
-static struct omap_control_usb_platform_data omap4_control_usb_pdata = {
-	.type = 1,
-};
-
-struct resource omap4_control_usb_res[] = {
-	{
-		.name	= "control_dev_conf",
-		.start	= 0x4a002300,
-		.end	= 0x4a002303,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "otghs_control",
-		.start	= 0x4a00233c,
-		.end	= 0x4a00233f,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap4_control_usb = {
-	.name = "omap-control-usb",
-	.id = -1,
-	.dev = {
-		.platform_data = &omap4_control_usb_pdata,
-	},
-	.num_resources = 2,
-	.resource = omap4_control_usb_res,
-};
-
-static inline void __init omap_init_control_usb(void)
-{
-	if (!cpu_is_omap44xx())
-		return;
-
-	if (platform_device_register(&omap4_control_usb))
-		pr_err("Error registering omap_control_usb device\n");
-}
-
-#else
-static inline void omap_init_control_usb(void) { }
-#endif /* CONFIG_OMAP_CONTROL_USB */
-
 int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 			*sdp4430_keypad_data, struct omap_board_data *bdata)
 {
@@ -651,7 +607,6 @@ static int __init omap2_init_devices(void)
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
-		omap_init_control_usb();
 		omap_init_dmic();
 		omap_init_mcpdm();
 		omap_init_mcspi();
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index aa27d7f..544c92b 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -188,125 +188,6 @@ static void __init setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	return;
 }
 
-static
-void __init setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
-{
-	switch (port_mode[0]) {
-	case OMAP_EHCI_PORT_MODE_PHY:
-		omap_mux_init_signal("usbb1_ulpiphy_stp",
-			OMAP_PIN_OUTPUT);
-		omap_mux_init_signal("usbb1_ulpiphy_clk",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dir",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_nxt",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat0",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat1",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat2",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat3",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat4",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat5",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat6",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpiphy_dat7",
-			OMAP_PIN_INPUT_PULLDOWN);
-			break;
-	case OMAP_EHCI_PORT_MODE_TLL:
-		omap_mux_init_signal("usbb1_ulpitll_stp",
-			OMAP_PIN_INPUT_PULLUP);
-		omap_mux_init_signal("usbb1_ulpitll_clk",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dir",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_nxt",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat0",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat1",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat2",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat3",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat4",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat5",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat6",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_ulpitll_dat7",
-			OMAP_PIN_INPUT_PULLDOWN);
-			break;
-	case OMAP_USBHS_PORT_MODE_UNUSED:
-	default:
-			break;
-	}
-	switch (port_mode[1]) {
-	case OMAP_EHCI_PORT_MODE_PHY:
-		omap_mux_init_signal("usbb2_ulpiphy_stp",
-			OMAP_PIN_OUTPUT);
-		omap_mux_init_signal("usbb2_ulpiphy_clk",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dir",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_nxt",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat0",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat1",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat2",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat3",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat4",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat5",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat6",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpiphy_dat7",
-			OMAP_PIN_INPUT_PULLDOWN);
-			break;
-	case OMAP_EHCI_PORT_MODE_TLL:
-		omap_mux_init_signal("usbb2_ulpitll_stp",
-			OMAP_PIN_INPUT_PULLUP);
-		omap_mux_init_signal("usbb2_ulpitll_clk",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dir",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_nxt",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat0",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat1",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat2",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat3",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat4",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat5",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat6",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_ulpitll_dat7",
-			OMAP_PIN_INPUT_PULLDOWN);
-			break;
-	case OMAP_USBHS_PORT_MODE_UNUSED:
-	default:
-			break;
-	}
-}
-
 static void __init setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
@@ -404,78 +285,6 @@ static void __init setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	}
 }
 
-static
-void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
-{
-	switch (port_mode[0]) {
-	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
-	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
-		omap_mux_init_signal("usbb1_mm_rxdp",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_mm_rxdm",
-			OMAP_PIN_INPUT_PULLDOWN);
-
-	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
-	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
-		omap_mux_init_signal("usbb1_mm_rxrcv",
-			OMAP_PIN_INPUT_PULLDOWN);
-
-	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
-		omap_mux_init_signal("usbb1_mm_txen",
-			OMAP_PIN_INPUT_PULLDOWN);
-
-
-	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
-		omap_mux_init_signal("usbb1_mm_txdat",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb1_mm_txse0",
-			OMAP_PIN_INPUT_PULLDOWN);
-		break;
-
-	case OMAP_USBHS_PORT_MODE_UNUSED:
-	default:
-		break;
-	}
-
-	switch (port_mode[1]) {
-	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
-	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
-		omap_mux_init_signal("usbb2_mm_rxdp",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_mm_rxdm",
-			OMAP_PIN_INPUT_PULLDOWN);
-
-	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
-	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
-		omap_mux_init_signal("usbb2_mm_rxrcv",
-			OMAP_PIN_INPUT_PULLDOWN);
-
-	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
-		omap_mux_init_signal("usbb2_mm_txen",
-			OMAP_PIN_INPUT_PULLDOWN);
-
-
-	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
-	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
-		omap_mux_init_signal("usbb2_mm_txdat",
-			OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usbb2_mm_txse0",
-			OMAP_PIN_INPUT_PULLDOWN);
-		break;
-
-	case OMAP_USBHS_PORT_MODE_UNUSED:
-	default:
-		break;
-	}
-}
-
 void __init usbhs_init(struct usbhs_omap_platform_data *pdata)
 {
 	struct omap_hwmod	*uhh_hwm, *tll_hwm;
@@ -489,9 +298,6 @@ void __init usbhs_init(struct usbhs_omap_platform_data *pdata)
 		if (omap_rev() <= OMAP3430_REV_ES2_1)
 			pdata->single_ulpi_bypass = true;
 
-	} else if (cpu_is_omap44xx()) {
-		setup_4430ehci_io_mux(pdata->port_mode);
-		setup_4430ohci_io_mux(pdata->port_mode);
 	}
 
 	uhh_hwm = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3242a55..8c4de270 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -85,9 +85,6 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap44xx())
-		musb_plat.has_mailbox = true;
-
 	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";

