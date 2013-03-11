From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [Resend/PATCH 5/5] arm: dts: omap5-evm: Add mcspi data
Date: Mon, 11 Mar 2013 19:16:13 +0530
Message-ID: <1363009573-19596-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42109 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab3CKNqr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 09:46:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, santosh.shilimkar@ti.com, b-cousson@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>, Andrew Morton <akpm@osdl.org>

Add mcspi node and pinmux data for omap5 mcspi controller.

Tested on omap5430 evm with 3.9-rc2 custom kernel.

Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |   46 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index a4784be..d0ea53c 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -115,6 +115,33 @@
 			0x186 0x100     /* i2c5_sda INPUTENABLE | MODE0 */
 		>;
 	};
+
+	mcspi2_pins: pinmux_mcspi2_pins {
+		pinctrl-single,pins = <
+			0xbc 0x100	/*  MCSPI2_CLK INPUTENABLE | MODE0 */
+			0xbe 0x100	/*  MCSPI2_SIMO INPUTENABLE | MODE0 */
+			0xc0 0x118	/*  MCSPI2_SOMI PULLUP | INPUTENABLE | MODE0 */
+			0xc2 0x0	/*  MCSPI2_CS MODE0 */
+		>;
+	};
+
+	mcspi3_pins: pinmux_mcspi3_pins {
+		pinctrl-single,pins = <
+			0x78 0x101	/*  MCSPI2_SOMI INPUTENABLE | MODE1 */
+			0x7a 0x101	/*  MCSPI2_CS INPUTENABLE | MODE1 */
+			0x7c 0x101	/*  MCSPI2_SIMO INPUTENABLE | MODE1 */
+			0x7e 0x101	/*  MCSPI2_CLK INPUTENABLE | MODE1 */
+		>;
+	};
+
+	mcspi4_pins: pinmux_mcspi4_pins {
+		pinctrl-single,pins = <
+			0x164 0x101	/*  MCSPI2_CLK INPUTENABLE | MODE1 */
+			0x168 0x101	/*  MCSPI2_SIMO INPUTENABLE | MODE1 */
+			0x16a 0x101	/*  MCSPI2_SOMI INPUTENABLE | MODE1 */
+			0x16c 0x101	/*  MCSPI2_CS INPUTENABLE | MODE1 */
+		>;
+	};
 };
 
 &mmc1 {
@@ -213,3 +240,22 @@
 	cs1-used;
 	device-handle = <&samsung_K3PE0E000B>;
 };
+
+&mcspi1 {
+
+};
+
+&mcspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi2_pins>;
+};
+
+&mcspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi3_pins>;
+};
+
+&mcspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi4_pins>;
+};
-- 
1.7.1

