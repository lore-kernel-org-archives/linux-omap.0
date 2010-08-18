From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 4/7] omap: usb: ehci: IO mux mode settings for omap4
Date: Thu, 19 Aug 2010 05:19:34 +0530
Message-ID: <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282175377-2784-4-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds mux-mode settings for EHCI pads on OMAP4.
This is a hack for now, 
This code be replaced when the mux framework is introduced for OMAP4.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-ehci.c |  109 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/usb-ehci.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-ehci.c
+++ linux-2.6/arch/arm/mach-omap2/usb-ehci.c
@@ -214,6 +214,115 @@ static void setup_ehci_io_mux(const enum
 	return;
 }
 
+static void setup_4430ehci_io_mux(const enum ehci_hcd_omap_mode *port_mode)
+{
+	/*
+	 * FIXME: This funtion should use mux framework functions;
+	 * For now, we are hardcoding this.
+	 */
+	switch (port_mode[0]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+
+		/* HUSB1_PHY CLK , INPUT ENABLED, PULLDOWN  */
+		omap_writew(0x010C, 0x4A1000C2);
+
+		/* HUSB1 STP */
+		omap_writew(0x0004, 0x4A1000C4);
+
+		/* HUSB1_DIR */
+		omap_writew(0x010C, 0x4A1000C6);
+
+		/* HUSB1_NXT */
+		omap_writew(0x010C, 0x4A1000C8);
+
+		/* HUSB1_DATA0 */
+		omap_writew(0x010C, 0x4A1000CA);
+
+		/* HUSB1_DATA1 */
+		omap_writew(0x010C, 0x4A1000CC);
+
+		/* HUSB1_DATA2 */
+		omap_writew(0x010C, 0x4A1000CE);
+
+		/* HUSB1_DATA3 */
+		omap_writew(0x010C, 0x4A1000D0);
+
+		/* HUSB1_DATA4 */
+		omap_writew(0x010C, 0x4A1000D2);
+
+		/* HUSB1_DATA5 */
+		omap_writew(0x010C, 0x4A1000D4);
+
+		/* HUSB1_DATA6 */
+		omap_writew(0x010C, 0x4A1000D6);
+
+		/* HUSB1_DATA7 */
+		omap_writew(0x010C, 0x4A1000D8);
+
+		break;
+
+	case EHCI_HCD_OMAP_MODE_TLL:
+		/* TODO */
+
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
+	switch (port_mode[1]) {
+	case EHCI_HCD_OMAP_MODE_PHY:
+		/* HUSB2_PHY CLK , INPUT PULLDOWN ENABLED  */
+		omap_writew(0x010C, 0x4A100160);
+
+		/* HUSB2 STP */
+		omap_writew(0x0002, 0x4A100162);
+
+		/* HUSB2_DIR */
+		omap_writew(0x010A, 0x4A100164);
+
+		/* HUSB2_NXT */
+		omap_writew(0x010A, 0x4A100166);
+
+		/* HUSB2_DATA0 */
+		omap_writew(0x010A, 0x4A100168);
+
+		/* HUSB2_DATA1 */
+		omap_writew(0x010A, 0x4A10016A);
+
+		/* HUSB2_DATA2 */
+		omap_writew(0x010A, 0x4A10016C);
+
+		/* HUSB2_DATA3 */
+		omap_writew(0x010A, 0x4A10016E);
+
+		/* HUSB2_DATA4 */
+		omap_writew(0x010A, 0x4A100170);
+
+		/* HUSB2_DATA5 */
+		omap_writew(0x010A, 0x4A100172);
+
+		/* HUSB2_DATA6 */
+		omap_writew(0x010A, 0x4A100174);
+
+		/* HUSB2_DATA7 */
+		omap_writew(0x010A, 0x4A100176);
+
+		break;
+
+	case EHCI_HCD_OMAP_MODE_TLL:
+		/* TODO */
+
+		break;
+	case EHCI_HCD_OMAP_MODE_UNKNOWN:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+	return;
+}
+
 void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 {
 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
