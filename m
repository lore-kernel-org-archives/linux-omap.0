From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH 1/3] ARM: DTS: OMAP3: beagle/overo: mux console UART, enable wakeup
Date: Fri, 31 May 2013 15:45:55 -0700
Message-ID: <1370040357-25794-2-git-send-email-khilman@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44018 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511Ab3EaWqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 18:46:03 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so2947163pbc.1
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 15:46:03 -0700 (PDT)
In-Reply-To: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Ensure the console uart (UART3) on these boards is mux'd correctly, and
IO ring wakeup is enabled.

This is needed for serial console wakeups when using DT boot.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts    | 12 ++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi    | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 3046d1f..ca067b0 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -126,3 +126,17 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&omap3_pmx_core {
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
+			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+		>;
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 6eec699..b004372 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -95,6 +95,13 @@
 			0x1ae 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat7 INPUT | PULLDOWN */
 		>;
 	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
+			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -142,3 +149,8 @@
 	 */
 	ti,pulldowns = <0x03a1c4>;
 };
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index a626c50..d63ed39 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -77,3 +77,17 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&omap3_pmx_core {
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
+			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
+		>;
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
-- 
1.8.2

