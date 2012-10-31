From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RESEND PATCH 02/11] ARM: OMAP4: USB: Host: Panda board specific device tree node
Date: Wed, 31 Oct 2012 19:56:43 +0530
Message-ID: <1351693612-23314-3-git-send-email-keshava_mgowda@ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35307 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757618Ab2JaO1G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 10:27:06 -0400
In-Reply-To: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, b-cousson@ti.com

OMAP4 panda board specific device tree node is included.

In OMAP4 panda board, the port 1 is used in ULPI PHY mode.
The port 1 is connected to a on board hub with ethernet
interface.

TODO:
   The clock bindings are not yet avilable for OMAP4.
   hence , USB hub specific clocks are exported as device tree string
   paramters.
   Will be changed to use the clock bindings later

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index e8f927c..dad0df6 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -184,3 +184,36 @@
 &dmic {
 	status = "disabled";
 };
+
+&usbhs {
+	/*
+	 * Maximum fill 3 port info.
+	 * port configured can be any one of the following values
+	 * OMAP_USBHS_PORT_MODE_UNUSED			= 0,
+	 * OMAP_EHCI_PORT_MODE_PHY				= 1,
+	 * OMAP_EHCI_PORT_MODE_TLL				= 2,
+	 * OMAP_EHCI_PORT_MODE_HSIC				= 3,
+	 * OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0	= 4,
+	 * OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM	= 5,
+	 * OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0	= 6,
+	 * OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM	= 7,
+	 * OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0	= 8,
+	 * OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM	= 9,
+	 * OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0	= 10,
+	 * OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM	= 11,
+	 * OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0	= 12,
+	 * OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM	= 13,
+	 */
+	port-0 = <1>;
+	port-1 = <0>;
+	port-2 = <0>;
+
+	/*
+	 * In some boards, the controller is always connected to hub
+	 * the pandboard always has the hub connect to port0 of usbhs controller
+	 */
+	hub-power-gpio = <&gpio1 1 0>;
+	hub-reset-gpio = <&gpio2 30 0>;  /* gpio 62 */
+	hub-clk = "auxclk3_ck";
+	hub-clkrate = <19200000>;
+};
-- 
1.7.9.5

