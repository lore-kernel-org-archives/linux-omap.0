From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/9] ARM: DTS: omap4-sdp: Move audio related pinmux to respective nodes
Date: Fri, 24 Jan 2014 10:19:00 +0200
Message-ID: <1390551547-12406-3-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60976 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaAXITh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2014 03:19:37 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Attach the pinctrl nodes to their respective device node:
mcbsp1, mcbsp2, dmic, mcpdm and twl6040.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index dbc81fb6ef03..513b01774966 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -158,11 +158,6 @@
 &omap4_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&twl6040_pins
-			&mcpdm_pins
-			&dmic_pins
-			&mcbsp1_pins
-			&mcbsp2_pins
 			&dss_hdmi_pins
 			&tpd12s015_pins
 	>;
@@ -326,6 +321,10 @@
 	twl6040: twl@4b {
 		compatible = "ti,twl6040";
 		reg = <0x4b>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&twl6040_pins>;
+
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
@@ -537,10 +536,34 @@
 	pinctrl-0 = <&uart4_pins>;
 };
 
+&mcbsp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+	status = "okay";
+};
+
+&mcbsp2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+	status = "okay";
+};
+
 &mcbsp3 {
 	status = "disabled";
 };
 
+&dmic {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dmic_pins>;
+	status = "okay";
+};
+
+&mcpdm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcpdm_pins>;
+	status = "okay";
+};
+
 &twl_usb_comparator {
 	usb-supply = <&vusb>;
 };
-- 
1.8.5.3

