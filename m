From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/4] ARM: dts: imx6: RDU2: Use new CODEC reset pin name
Date: Fri, 29 Mar 2019 13:13:10 -0500
Message-ID: <20190329181313.21009-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", the driver now accepts this name, use it here.

Note the GPIO polarity in the driver was ignored before and always
assumed to be active low, when all the DTs are fixed we will start
respecting the specified polarity. Switch polarity in DT to the
currently assumed one, this way when the driver changes the
behavior will not change.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 69942c7ff89d..cbf7c9cae565 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -384,7 +384,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 	};
 
 	accel@1c {
@@ -572,7 +572,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	};
 
 	touchscreen@20 {
-- 
2.21.0
