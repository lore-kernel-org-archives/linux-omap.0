From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RFC] [PATCH 3/5] usb: ohci: omap: IO mux mode settings for omap4
Date: Fri, 20 Aug 2010 00:48:08 +0530
Message-ID: <1282245490-24339-4-git-send-email-keshava_mgowda@ti.com>
References: <1282245490-24339-1-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-2-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-3-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53285 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab0HTHRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 03:17:32 -0400
In-Reply-To: <1282245490-24339-3-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Add mux-mode settings for OHCI pads on OMAP4.
This will be replaced when the mux framework is introduced for OMAP4.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/usb-ehci.c |   85 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/usb-ehci.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-ehci.c
+++ linux-2.6/arch/arm/mach-omap2/usb-ehci.c
@@ -490,6 +490,91 @@ static void setup_ohci_io_mux(const enum
 	}
 }
 
+static void setup_4430ohci_io_mux(const enum ohci_omap3_port_mode *port_mode)
+{
+	/* FIXME: This funtion should use Mux frame work functions;
+	 * for now, we are hardcodeing it
+	 * This function will be later replaced by MUX framework API.
+	 */
+	switch (port_mode[0]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+
+		/* usbb1_mm_rxdp */
+		omap_writew(0x001D, 0x4A1000C4);
+
+		/* usbb1_mm_rxdm */
+		omap_writew(0x001D, 0x4A1000C8);
+
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+
+		/* usbb1_mm_rxrcv */
+		omap_writew(0x001D, 0x4A1000CA);
+
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+
+		/* usbb1_mm_txen */
+		omap_writew(0x001D, 0x4A1000D0);
+
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+
+		/* usbb1_mm_txdat */
+		omap_writew(0x001D, 0x4A1000CE);
+
+		/* usbb1_mm_txse0 */
+		omap_writew(0x001D, 0x4A1000CC);
+		break;
+
+	case OMAP_OHCI_PORT_MODE_UNUSED:
+	default:
+		break;
+	}
+
+	switch (port_mode[1]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+
+		/* usbb2_mm_rxdp */
+		omap_writew(0x010C, 0x4A1000F8);
+
+		/* usbb2_mm_rxdm */
+		omap_writew(0x010C, 0x4A1000F6);
+
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+
+		/* usbb2_mm_rxrcv */
+		omap_writew(0x010C, 0x4A1000FA);
+
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+
+		/* usbb2_mm_txen */
+		omap_writew(0x080C, 0x4A1000FC);
+
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+
+		/* usbb2_mm_txdat */
+		omap_writew(0x000C, 0x4A100112);
+
+		/* usbb2_mm_txse0 */
+		omap_writew(0x000C, 0x4A100110);
+		break;
+
+	case OMAP_OHCI_PORT_MODE_UNUSED:
+	default:
+		break;
+	}
+}
+
 void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata)
 {
 	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
