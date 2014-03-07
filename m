From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v4 9/9] ARM: dts: overo: Push uart3 pinmux down to expansion board
Date: Fri,  7 Mar 2014 20:22:19 +0100
Message-ID: <1394220139-1760-10-git-send-email-florian.vaussard@epfl.ch>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45208 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068AbaCGTWh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 14:22:37 -0500
In-Reply-To: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

UART3 is used by expansion boards to get a tty console. Thus, the
pinmux should be defined by expansion boards, instead of being
imposed by the processor board.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi        | 11 -----------
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi | 13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 13d1ad2..d36bf02 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -96,13 +96,6 @@
 		>;
 	};
 
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
-		>;
-	};
-
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)		/* i2c1_scl.i2c1_scl */
@@ -226,7 +219,3 @@
 	pinctrl-0 = <&uart2_pins>;
 };
 
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-};
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 0312d22..384e87d 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -28,6 +28,13 @@
 			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
 		>;
 	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
 };
 
 #include "omap-gpmc-smsc9221.dtsi"
@@ -58,3 +65,9 @@
 &mmc3 {
 	status = "disabled";
 };
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
-- 
1.8.3.2

