From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/4] ARM: dts: imx6qdl: Use new CODEC reset pin name
Date: Fri, 29 Mar 2019 13:13:12 -0500
Message-ID: <20190329181313.21009-3-afd@ti.com>
References: <20190329181313.21009-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329181313.21009-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", the driver now accepts this name, use it here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
index 8752a4961c47..c41cac502bac 100644
--- a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
@@ -183,7 +183,7 @@
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&reg_3p3v>;
 		ai3x-ocmv = <0>;
-		gpio-reset = <&gpio5 5 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.21.0
