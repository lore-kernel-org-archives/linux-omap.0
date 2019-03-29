From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/4] ARM: dts: imx: Use new CODEC reset pin name
Date: Fri, 29 Mar 2019 13:13:11 -0500
Message-ID: <20190329181313.21009-2-afd@ti.com>
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
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 9cb9a7439121..aee9221f0f29 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -311,7 +311,7 @@
 	tlv320aic3105: codec@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio5 17 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		ai3x-micbias-vg = <2>; /* MICBIAS_2_5V */
 		/* Regulators */
-- 
2.21.0
