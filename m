From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/9] ARM: DTS: omap4-panda-common: Move audio related pinmux to respective nodes
Date: Fri, 24 Jan 2014 10:18:59 +0200
Message-ID: <1390551547-12406-2-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaAXITg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2014 03:19:36 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Attach the pinctrl nodes to their respective device node:
mcbsp1, mcpdm and twl6040.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 88c6a05cab41..9067d4c0148d 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -109,9 +109,6 @@
 &omap4_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&twl6040_pins
-			&mcpdm_pins
-			&mcbsp1_pins
 			&dss_dpi_pins
 			&tfp410_pins
 			&dss_hdmi_pins
@@ -300,6 +297,10 @@
 	twl6040: twl@4b {
 		compatible = "ti,twl6040";
 		reg = <0x4b>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&twl6040_pins>;
+
 		/* IRQ# = 119 */
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
 		interrupt-parent = <&gic>;
@@ -380,6 +381,12 @@
 	device-handle = <&elpida_ECB240ABACN>;
 };
 
+&mcbsp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+	status = "okay";
+};
+
 &mcbsp2 {
 	status = "disabled";
 };
@@ -392,6 +399,12 @@
 	status = "disabled";
 };
 
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

