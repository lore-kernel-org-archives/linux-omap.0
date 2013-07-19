From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 3/4] arm: dts: dra7-evm: Add SPI pinctrl data
Date: Fri, 19 Jul 2013 21:54:09 +0530
Message-ID: <1374251050-10033-4-git-send-email-sourav.poddar@ti.com>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60730 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760794Ab3GSQY3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 12:24:29 -0400
In-Reply-To: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sourav Poddar <sourav.poddar@ti.com>

Add pin control data for mcspi1 and mcspi2.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5591db2..d8b0da9 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -40,6 +40,27 @@
 			0x414 0x60000	/* i2c3_scl */
 		>;
 	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			0x3a4 0x40000	/* spi2_clk */
+			0x3a8 0x40000	/* spi2_d1 */
+			0x3ac 0x40000	/* spi2_d0 */
+			0x3b0 0xc0000	/* spi2_cs0 */
+			0x3b4 0xc0000	/* spi2_cs1 */
+			0x3b8 0xe0006	/* spi2_cs2 */
+			0x3bc 0xe0006	/* spi2_cs3 */
+		>;
+	};
+
+	mcspi2_pins: pinmux_mcspi2_pins {
+		pinctrl-single,pins = <
+			0x3c0 0x40000	/* spi2_sclk */
+			0x3c4 0xc0000	/* spi2_d1 */
+			0x3c8 0xc0000	/* spi2_d1 */
+			0x3cc 0xe0000	/* spi2_cs0 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -65,3 +86,15 @@
 
 	clock-frequency = <3400000>;
 };
+
+&mcspi1 {
+        status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+};
+
+&mcspi2 {
+        status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi2_pins>;
+};
-- 
1.7.1

