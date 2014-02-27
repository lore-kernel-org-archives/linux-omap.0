From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 1/8] ARM: dts: omap3-tobi: Add missing pinctrl
Date: Thu, 27 Feb 2014 21:30:25 +0100
Message-ID: <1393533032-1619-2-git-send-email-florian.vaussard@epfl.ch>
References: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:39890 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaB0Uas (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 15:30:48 -0500
In-Reply-To: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Add missing pinctrl entries:
- i2c3

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 4edc013..da7d85b 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -35,6 +35,15 @@
 	};
 };
 
+&omap3_pmx_core {
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
+		>;
+	};
+};
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x1000000>;	/* CS5 */
 
@@ -72,6 +81,8 @@
 };
 
 &i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
 	clock-frequency = <100000>;
 };
 
-- 
1.8.5.3

