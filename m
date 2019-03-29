From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 4/4] ARM: dts: omap2420-n810: Use new CODEC reset pin name
Date: Fri, 29 Mar 2019 13:13:13 -0500
Message-ID: <20190329181313.21009-4-afd@ti.com>
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
 arch/arm/boot/dts/omap2420-n810.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/omap2420-n810.dts
index 96b9913ecc1f..09c1dbc0bb69 100644
--- a/arch/arm/boot/dts/omap2420-n810.dts
+++ b/arch/arm/boot/dts/omap2420-n810.dts
@@ -48,7 +48,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&aic33_pins>;
 
-		gpio-reset = <&gpio4 22 GPIO_ACTIVE_LOW>; /* gpio118 */
+		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>; /* gpio118 */
 
 		ai3x-gpio-func = <
 			10 /* AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK */
-- 
2.21.0
