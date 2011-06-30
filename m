From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 2/5] OMAP4:I2C: Add device tree nodes for panda board
Date: Thu, 30 Jun 2011 15:07:24 +0500
Message-ID: <1309426647-31587-3-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
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
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Add I2C and it's child device nodes for beagle board.
The I2C1 controller child devices are not populated and it
should be handled along with OMAP clock changes.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   57 +++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 58909e9..f9af72f 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,4 +8,61 @@
 / {
 	model = "TI OMAP4 PandaBoard";
 	compatible = "ti,omap4-panda", "ti,omap4430";
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller@48241000 {
+		compatible = "ti,omap-gic", "arm,gic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x48241000 0x1000>,
+		      <0X48240100 0x0200>;
+	};
+
+	i2c@48070000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48070000 0x100>;
+		interrupts = < 88 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <400>;
+		status = "disabled";
+	};
+
+	i2c@48072000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48072000 0x100>;
+		interrupts = < 89 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <400>;
+		status = "ok";
+	};
+
+	i2c@48060000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48060000 0x100>;
+		interrupts = < 93 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <100>;
+		status = "ok";
+		eeprom@50 {
+			compatible = "at,at24c01";
+			reg = < 0x50 >;
+		};
+	};
+
+	i2c@48350000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48350000 0x100>;
+		interrupts = < 94 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <400>;
+		status = "ok";
+	};
 };
-- 
1.7.4.1
