From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 7/8] ARM: dts: omap4-droid4: Add touchscreen
Date: Thu,  2 Mar 2017 02:08:59 +0100
Message-ID: <20170302010900.28532-8-sre@kernel.org>
References: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302010900.28532-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Droid4's touchscreen can be used with mainline's maxtouch
driver. The touchscreen's lower area is used for four soft
buttons (KEY_MENU, KEY_HOME, KEY_BACK, KEY_SEARCH), but that
is currently not supported by the mainline kernel.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 479cd5e5de83..364e98e66037 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -191,6 +191,20 @@
 	power = <50>;
 };
 
+&i2c2 {
+	atmxt: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>; /* gpio183 */
+
+		reset-gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>; /* gpio173 */
+
+		/* TODO: touchscreen has 4 soft buttons */
+	};
+};
+
 &i2c4 {
 	ak8975: magnetometer@c {
 		compatible = "asahi-kasei,ak8975";
-- 
2.11.0
