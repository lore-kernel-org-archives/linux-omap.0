From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/5] ARM: dts: n8x0: remove unneeded unit name for i2c node
Date: Fri,  1 Apr 2016 16:20:19 -0400
Message-ID: <1459542022-17246-3-git-send-email-javier@osg.samsung.com>
References: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"i2c@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 8491f46c61b7..db95aadcca70 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -7,7 +7,7 @@
 	};
 
 	ocp {
-		i2c@0 {
+		i2c0 {
 			compatible = "i2c-cbus-gpio";
 			gpios = <&gpio3 2 GPIO_ACTIVE_HIGH /* gpio66 clk */
 				 &gpio3 1 GPIO_ACTIVE_HIGH /* gpio65 dat */
-- 
2.5.0
