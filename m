From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/4] ARM: dts: dra72-evm: Enable USB support for dra72-evm.
Date: Tue, 21 Oct 2014 13:41:19 +0300
Message-ID: <1413888080-2669-4-git-send-email-rogerq@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978AbaJUKlz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 06:41:55 -0400
In-Reply-To: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, nsekhar@ti.com, george.cherian@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

From: George Cherian <george.cherian@ti.com>

Add USB data and pinctrl for USB.

Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6f5417a..ad6ec4a 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -53,6 +53,18 @@
 			0xd8	(PIN_INPUT  | MUX_MODE0) /* gpmc_wait0 */
 		>;
 	};
+
+	usb1_pins: pinmux_usb1_pins {
+		pinctrl-single,pins = <
+			0x280 (PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+		>;
+	};
+
+	usb2_pins: pinmux_usb2_pins {
+		pinctrl-single,pins = <
+			0x284 (PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
+		>;
+	};
 };
 
 &i2c1 {
@@ -257,3 +269,15 @@
 		};
 	};
 };
+
+&usb1 {
+	dr_mode = "peripheral";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+};
+
+&usb2 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_pins>;
+};
-- 
1.8.3.2

