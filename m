From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 2/4] arm: dts: dra7-evm: Add I2C pinctrl data
Date: Fri, 19 Jul 2013 21:54:08 +0530
Message-ID: <1374251050-10033-3-git-send-email-sourav.poddar@ti.com>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60722 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760794Ab3GSQY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 12:24:26 -0400
In-Reply-To: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sourav Poddar <sourav.poddar@ti.com>

Add pin control data for i2c1, i2c2 and i2c3.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |   47 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 9c568b6..5591db2 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -18,3 +18,50 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 };
+
+&dra7_pmx_core {
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x400 0x60000	/* i2c1_sda */
+			0x404 0x60000	/* i2c1_scl */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x408 0x60000	/* i2c2_sda */
+			0x40c 0x60000	/* i2c2_scl */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x410 0x60000	/* i2c3_sda */
+			0x414 0x60000	/* i2c3_scl */
+		>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <400000>;
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	clock-frequency = <3400000>;
+};
-- 
1.7.1

