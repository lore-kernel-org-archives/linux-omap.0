From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 10/10] ARM: dts: am335x-evm: Add DCAN1 details
Date: Thu, 13 Nov 2014 14:22:51 +0200
Message-ID: <1415881371-4982-11-git-send-email-rogerq@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46227 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbaKMMXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2014 07:23:48 -0500
In-Reply-To: <1415881371-4982-1-git-send-email-rogerq@ti.com>
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
index e2156a5..e3d0b39 100644
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
+	status = "disabled";	/* Enable only if Profile 1 is selected */
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins_default>;
+};
-- 
1.8.3.2

