From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 4/4] arm: dts: dra7-evm: Add UART pinctrl data
Date: Fri, 19 Jul 2013 21:54:10 +0530
Message-ID: <1374251050-10033-5-git-send-email-sourav.poddar@ti.com>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42407 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760794Ab3GSQYd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Jul 2013 12:24:33 -0400
In-Reply-To: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sourav Poddar <sourav.poddar@ti.com>

Add pin control datas for uart1, uart2 and uart3.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |   43 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d8b0da9..8f3be53 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -61,6 +61,31 @@
 			0x3cc 0xe0000	/* spi2_cs0 */
 		>;
 	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x3e0 0xe0000	/* uart1_rxd */
+			0x3e4 0xe0000	/* uart1_txd */
+			0x3e8 0x60003	/* uart1_ctsn */
+			0x3ec 0x60003	/* uart1_rtsn */
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			0x3f0 0x60000 /* uart2_rxd */
+			0x3f4 0x60000 /* uart2_txd */
+			0x3f8 0x60000 /* uart2_ctsn */
+			0x3fc 0x60000 /* uart2_rtsn */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x248 0xc0000 /* uart3_rxd */
+			0x24c 0xc0000 /* uart3_txd */
+		>;
+	};
 };
 
 &i2c1 {
@@ -98,3 +123,21 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi2_pins>;
 };
+
+&uart1 {
+	status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart1_pins>;
+};
+
+&uart2 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart2_pins>;
+};
+
+&uart3 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart3_pins>;
+};
-- 
1.7.1

