From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH v2 06/13] dt: omap3: add omap-device compatible property
Date: Tue, 23 Aug 2011 10:03:34 +0500
Message-ID: <1314074021-25186-7-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Add "omap-device" to the i2c controllers compatible property.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 9ea8257..f64c63d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -31,7 +31,7 @@
 		i2c1: i2c@70000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "ti,omap-i2c";
+			compatible = "ti,omap-i2c", "ti,omap-device";
 			reg = <0x70000 0x100>;
 			interrupts = < 88 >;
 		};
@@ -39,7 +39,7 @@
 		i2c2: i2c@72000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "ti,omap-i2c";
+			compatible = "ti,omap-i2c", "ti,omap-device";
 			reg = <0x72000 0x100>;
 			interrupts = < 89 >;
 		};
@@ -47,7 +47,7 @@
 		i2c3: i2c@60000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "ti,omap-i2c";
+			compatible = "ti,omap-i2c", "ti,omap-device";
 			reg = <0x60000 0x100>;
 			interrupts = < 93 >;
 		};
-- 
1.7.4.1
