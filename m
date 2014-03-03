From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 1/7] ARM: dts: omap3-tobi: Add missing pinctrl
Date: Mon,  3 Mar 2014 10:34:01 +0100
Message-ID: <1393839247-6516-2-git-send-email-florian.vaussard@epfl.ch>
References: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:41437 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbaCCJe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 04:34:26 -0500
In-Reply-To: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

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
1.8.3.2

