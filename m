From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 10/10] ARM: dts: am335x-evm: Add DCAN1 details
Date: Tue, 4 Nov 2014 12:48:54 +0200
Message-ID: <1415098134-26405-11-git-send-email-rogerq@ti.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60111 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbaKDKts (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2014 05:49:48 -0500
In-Reply-To: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

DCAN1 is routed to CAN port (J11) when Profile 1 is selected on the
profile selection switch.
Provide information for DCAN1 pins and node but keep it disabled
by default. User has to manually enable it if Profile 1 is chosen.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e2156a5..7b7bd8f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -307,6 +307,13 @@
 			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
+
+	dcan1_pins_default: dcan1_pins_default {
+		pinctrl-single,pins = <
+			0x168 (PIN_OUTPUT | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			0x16c (PIN_INPUT_PULLDOWN | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+		>;
+	};
 };
 
 &uart0 {
@@ -664,3 +671,9 @@
 &aes {
 	status = "okay";
 };
+
+&dcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins_default>;
+	status = "disabled";	/* Enable only if Profile 1 is selected */
+};
-- 
1.8.3.2

