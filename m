From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 2/4] arm: omap4: usb: add platform init code for EHCI
Date: Mon, 29 Nov 2010 22:56:10 +0530
Message-ID: <1291051572-24084-3-git-send-email-gadiyar@ti.com>
References: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53638 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869Ab0K2R0T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 12:26:19 -0500
In-Reply-To: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

- Add platform init code for EHCI on OMAP4
- Add pad configuration for PHY and TLL modes

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-ehci.c |  144 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index b11bf38..25eeada 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -34,22 +34,15 @@
 
 static struct resource ehci_resources[] = {
 	{
-		.start	= OMAP34XX_EHCI_BASE,
-		.end	= OMAP34XX_EHCI_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= OMAP34XX_UHH_CONFIG_BASE,
-		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= OMAP34XX_USBTLL_BASE,
-		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{         /* general IRQ */
-		.start   = INT_34XX_EHCI_IRQ,
 		.flags   = IORESOURCE_IRQ,
 	}
 };
@@ -214,13 +207,148 @@ static void setup_ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
 	return;
 }
 
+static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
+{
+	switch (port_mode[0]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		omap_mux_init_signal("usbb1_ulpiphy_stp",
+			OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("usbb1_ulpiphy_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpiphy_dat7",
+			OMAP_PIN_INPUT_PULLDOWN);
+			break;
+	case EHCI_HCD_OMAP_MODE_TLL:
+		omap_mux_init_signal("usbb1_ulpitll_stp",
+			OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("usbb1_ulpitll_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_ulpitll_dat7",
+			OMAP_PIN_INPUT_PULLDOWN);
+			break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	default:
+			break;
+	}
+	switch (port_mode[1]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		omap_mux_init_signal("usbb2_ulpiphy_stp",
+			OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("usbb2_ulpiphy_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpiphy_dat7",
+			OMAP_PIN_INPUT_PULLDOWN);
+			break;
+	case EHCI_HCD_OMAP_MODE_TLL:
+		omap_mux_init_signal("usbb2_ulpitll_stp",
+			OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("usbb2_ulpitll_clk",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dir",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_nxt",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat1",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat2",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat3",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat4",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat5",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat6",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_ulpitll_dat7",
+			OMAP_PIN_INPUT_PULLDOWN);
+			break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+	default:
+			break;
+	}
+}
+
 void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 {
 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
 
 	/* Setup Pin IO MUX for EHCI */
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
+		ehci_resources[0].start	= OMAP34XX_EHCI_BASE;
+		ehci_resources[0].end	= OMAP34XX_EHCI_BASE + SZ_1K - 1;
+		ehci_resources[1].start	= OMAP34XX_UHH_CONFIG_BASE;
+		ehci_resources[1].end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
+		ehci_resources[2].start	= OMAP34XX_USBTLL_BASE;
+		ehci_resources[2].end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1;
+		ehci_resources[3].start = INT_34XX_EHCI_IRQ;
 		setup_ehci_io_mux(pdata->port_mode);
+	} else if (cpu_is_omap44xx()) {
+		ehci_resources[0].start	= OMAP44XX_HSUSB_EHCI_BASE;
+		ehci_resources[0].end	= OMAP44XX_HSUSB_EHCI_BASE + SZ_1K - 1;
+		ehci_resources[1].start	= OMAP44XX_UHH_CONFIG_BASE;
+		ehci_resources[1].end	= OMAP44XX_UHH_CONFIG_BASE + SZ_2K - 1;
+		ehci_resources[2].start	= OMAP44XX_USBTLL_BASE;
+		ehci_resources[2].end	= OMAP44XX_USBTLL_BASE + SZ_4K - 1;
+		ehci_resources[3].start = OMAP44XX_IRQ_EHCI;
+		setup_4430ehci_io_mux(pdata->port_mode);
+	}
 
 	if (platform_device_register(&ehci_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
-- 
1.7.0.4

