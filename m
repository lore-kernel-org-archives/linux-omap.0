From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] ARM: dts: Add generic ti,
 sysc compatible in addition to the custom ones
Date: Fri, 15 Dec 2017 10:08:53 -0800
Message-ID: <20171215180900.3243-3-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171215180900.3243-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Otherwise we cannot use generic OF_DEV_AUXDATA match without listing
all the compatibles separately for OF_DEV_AUXDATA. Let's also update the
binding accordingly.

Let's also fix omap4.dtsi to use "ti,sysc-omap4-sr" compatible as we
have documented in the binding. This was not noticed earlier as we're
still probing SmartReflex driver with platform data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 arch/arm/boot/dts/dra7.dtsi                       |  4 ++--
 arch/arm/boot/dts/omap4.dtsi                      | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -19,6 +19,7 @@ Required standard properties:
 
 - compatible	shall be one of the following generic types:
 
+		"ti,sysc"
 		"ti,sysc-omap2"
 		"ti,sysc-omap4"
 		"ti,sysc-omap4-simple"
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1498,7 +1498,7 @@
 		};
 
 		target-module@4a0dd000 {
-			compatible = "ti,sysc-omap4-sr";
+			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_core";
 			reg = <0x4a0dd000 0x4>,
 			      <0x4a0dd008 0x4>;
@@ -1511,7 +1511,7 @@
 		};
 
 		target-module@4a0d9000 {
-			compatible = "ti,sysc-omap4-sr";
+			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_mpu";
 			reg = <0x4a0d9000 0x4>,
 			      <0x4a0d9008 0x4>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -383,7 +383,7 @@
 		};
 
 		target-module@48076000 {
-			compatible = "ti,sysc-omap4";
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "slimbus2";
 			reg = <0x48076000 0x4>,
 			      <0x48076010 0x4>;
@@ -456,7 +456,7 @@
 		};
 
 		target-module@4a0db000 {
-			compatible = "ti,sysc-sr";
+			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_iva";
 			reg = <0x4a0db000 0x4>,
 			      <0x4a0db008 0x4>;
@@ -473,7 +473,7 @@
 		};
 
 		target-module@4a0dd000 {
-			compatible = "ti,sysc-sr";
+			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_core";
 			reg = <0x4a0dd000 0x4>,
 			      <0x4a0dd008 0x4>;
@@ -490,7 +490,7 @@
 		};
 
 		target-module@4a0d9000 {
-			compatible = "ti,sysc-sr";
+			compatible = "ti,sysc-omap4-sr", "ti,sysc";
 			ti,hwmods = "smartreflex_mpu";
 			reg = <0x4a0d9000 0x4>,
 			      <0x4a0d9008 0x4>;
@@ -710,7 +710,7 @@
 		};
 
 		target-module@52000000 {
-			compatible = "ti,sysc-omap4";
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "iss";
 			reg = <0x52000000 0x4>,
 			      <0x52000010 0x4>;
@@ -817,7 +817,7 @@
 		};
 
 		target-module@40128000 {
-			compatible = "ti,sysc-mcasp";
+			compatible = "ti,sysc-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp";
 			reg = <0x40128004 0x4>;
 			reg-names = "sysc";
@@ -835,7 +835,7 @@
 		};
 
 		target-module@4012c000 {
-			compatible = "ti,sysc-omap4";
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "slimbus1";
 			reg = <0x4012c000 0x4>,
 			      <0x4012c010 0x4>;
@@ -849,7 +849,7 @@
 		};
 
 		target-module@401f1000 {
-			compatible = "ti,sysc-omap4";
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "aess";
 			reg = <0x401f1000 0x4>,
 			      <0x401f1010 0x4>;
@@ -955,7 +955,7 @@
 		};
 
 		target-module@4a10a000 {
-			compatible = "ti,sysc-omap4";
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "fdif";
 			reg = <0x4a10a000 0x4>,
 			      <0x4a10a010 0x4>;
@@ -1183,7 +1183,7 @@
 		};
 
 		target-module@56000000 {
-			compatible = "ti,sysc-omap4";
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "gpu";
 			reg = <0x5601fc00 0x4>,
 			      <0x5601fc10 0x4>;
-- 
2.15.0
