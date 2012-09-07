From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
Date: Fri, 7 Sep 2012 17:25:24 +0200
Message-ID: <504A11E4.6000406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Thanks to Vaibhav <hvaibhav-l0cyMroinI0@public.gmane.org> omap_device fix
(ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
we can now specify reg and interrupts using standard device tree
attributes.

Update the OMAP4 dtsi file with missing reg and interrupts attributes.

Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---

Hi Tony,

This is the first step toward reduction of the hwmod data inside mach-omap2.
OMAP2/3/4 data still need to be there for legacy boards, but it will allow
OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.

DMA is still missing, but I hope that the discussion that happened during
LPC will fixed that soon.

Regards,
Benoit


 arch/arm/boot/dts/omap4.dtsi |   55 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 9f851df..75095e3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -97,6 +97,8 @@
 
 		gpio1: gpio@4a310000 {
 			compatible = "ti,omap4-gpio";
+			reg = <0x4a310000 0x200>;
+			interrupts = <0 29 0x4>;
 			ti,hwmods = "gpio1";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -106,6 +108,8 @@
 
 		gpio2: gpio@48055000 {
 			compatible = "ti,omap4-gpio";
+			reg = <0x48055000 0x200>;
+			interrupts = <0 30 0x4>;
 			ti,hwmods = "gpio2";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -115,6 +119,8 @@
 
 		gpio3: gpio@48057000 {
 			compatible = "ti,omap4-gpio";
+			reg = <0x48057000 0x200>;
+			interrupts = <0 31 0x4>;
 			ti,hwmods = "gpio3";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -124,6 +130,8 @@
 
 		gpio4: gpio@48059000 {
 			compatible = "ti,omap4-gpio";
+			reg = <0x48059000 0x200>;
+			interrupts = <0 32 0x4>;
 			ti,hwmods = "gpio4";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -133,6 +141,8 @@
 
 		gpio5: gpio@4805b000 {
 			compatible = "ti,omap4-gpio";
+			reg = <0x4805b000 0x200>;
+			interrupts = <0 33 0x4>;
 			ti,hwmods = "gpio5";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -142,6 +152,8 @@
 
 		gpio6: gpio@4805d000 {
 			compatible = "ti,omap4-gpio";
+			reg = <0x4805d000 0x200>;
+			interrupts = <0 34 0x4>;
 			ti,hwmods = "gpio6";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -151,30 +163,40 @@
 
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x4806a000 0x100>;
+			interrupts = <0 72 0x4>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x4806c000 0x100>;
+			interrupts = <0 73 0x4>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x48020000 0x100>;
+			interrupts = <0 74 0x4>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
 		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x4806e000 0x100>;
+			interrupts = <0 70 0x4>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
 
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap4-i2c";
+			reg = <0x48070000 0x100>;
+			interrupts = <0 56 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
@@ -182,6 +204,8 @@
 
 		i2c2: i2c@48072000 {
 			compatible = "ti,omap4-i2c";
+			reg = <0x48072000 0x100>;
+			interrupts = <0 57 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
@@ -189,6 +213,8 @@
 
 		i2c3: i2c@48060000 {
 			compatible = "ti,omap4-i2c";
+			reg = <0x48060000 0x100>;
+			interrupts = <0 61 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
@@ -196,6 +222,8 @@
 
 		i2c4: i2c@48350000 {
 			compatible = "ti,omap4-i2c";
+			reg = <0x48350000 0x100>;
+			interrupts = <0 62 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
@@ -203,6 +231,8 @@
 
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap4-mcspi";
+			reg = <0x48098000 0x200>;
+			interrupts = <0 65 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
@@ -211,6 +241,8 @@
 
 		mcspi2: spi@4809a000 {
 			compatible = "ti,omap4-mcspi";
+			reg = <0x4809a000 0x200>;
+			interrupts = <0 66 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
@@ -219,6 +251,8 @@
 
 		mcspi3: spi@480b8000 {
 			compatible = "ti,omap4-mcspi";
+			reg = <0x480b8000 0x200>;
+			interrupts = <0 91 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
@@ -227,6 +261,8 @@
 
 		mcspi4: spi@480ba000 {
 			compatible = "ti,omap4-mcspi";
+			reg = <0x480ba000 0x200>;
+			interrupts = <0 48 0x4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
@@ -235,6 +271,8 @@
 
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x4809c000 0x400>;
+			interrupts = <0 83 0x4>;
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
@@ -242,30 +280,40 @@
 
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480b4000 0x400>;
+			interrupts = <0 86 0x4>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
 		};
 
 		mmc3: mmc@480ad000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480ad000 0x400>;
+			interrupts = <0 94 0x4>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
 		};
 
 		mmc4: mmc@480d1000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d1000 0x400>;
+			interrupts = <0 96 0x4>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
 		};
 
 		mmc5: mmc@480d5000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d5000 0x400>;
+			interrupts = <0 59 0x4>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
 
 		wdt2: wdt@4a314000 {
 			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
+			reg = <0x4a314000 0x80>;
+			interrupts = <0 80 0x4>;
 			ti,hwmods = "wd_timer2";
 		};
 
@@ -338,11 +386,16 @@
 
 		keypad: keypad@4a31c000 {
 			compatible = "ti,omap4-keypad";
+			reg = <0x4a31c000 0x80>;
+			interrupts = <0 120 0x4>;
+			reg-names = "mpu";
 			ti,hwmods = "kbd";
 		};
 
 		emif1: emif@4c000000 {
 			compatible = "ti,emif-4d";
+			reg = <0x4c000000 0x100>;
+			interrupts = <0 110 0x4>;
 			ti,hwmods = "emif1";
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
@@ -352,6 +405,8 @@
 
 		emif2: emif@4d000000 {
 			compatible = "ti,emif-4d";
+			reg = <0x4d000000 0x100>;
+			interrupts = <0 111 0x4>;
 			ti,hwmods = "emif2";
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
-- 
1.7.0.4
