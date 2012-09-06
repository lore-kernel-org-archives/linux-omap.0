From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] arm/dts: Mux uart pins for omap4-sdp
Date: Thu, 06 Sep 2012 11:58:30 -0700
Message-ID: <20120906185830.1172.67360.stgit@muffinssi.local>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51159 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933001Ab2IFS6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 14:58:31 -0400
In-Reply-To: <20120906185615.1172.23588.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Mux uart pins for the serial ports.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index dbcdc4a..00edbe6 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -115,6 +115,33 @@
 	};
 };
 
+&omap4_pmx_core {
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			0xd8 0x118	/* uart2_cts.uart2_cts INPUT_PULLUP | MODE0 */
+			0xda 0		/* uart2_rts.uart2_rts OUTPUT | MODE0 */
+			0xdc 0x118	/* uart2_rx.uart2_rx INPUT_PULLUP | MODE0 */
+			0xde 0		/* uart2_tx.uart2_tx OUTPUT | MODE0 */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x100 0x118	/* uart3_cts_rctx.uart3_cts_rctx INPUT_PULLUP | MODE0 */
+			0x102 0		/* uart3_rts_sd.uart3_rts_sd OUTPUT | MODE0 */
+			0x104 0x100	/* uart3_rx_irrx.uart3_rx_irrx INPUT | MODE0 */
+			0x106 0		/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+		>;
+	};
+
+	uart4_pins: pinmux_uart4_pins {
+		pinctrl-single,pins = <
+			0x11c 0x100	/* uart4_rx.uart4_rx INPUT | MODE0 */
+			0x11e 0		/* uart4_tx.uart4_tx OUTPUT | MODE0 */
+		>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 
@@ -226,3 +253,18 @@
 	bus-width = <4>;
 	ti,non-removable;
 };
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+};

