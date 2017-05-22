From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH v4 03/20] ARM: dts: omap: Add generic compatible string for I2C EEPROM
Date: Mon, 22 May 2017 16:01:51 +0200
Message-ID: <20170522140208.24652-4-javier@dowhile0.org>
References: <20170522140208.24652-1-javier@dowhile0.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522140208.24652-1-javier@dowhile0.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Mark Jackson <mpfj@newflow.co.uk>
List-Id: linux-omap@vger.kernel.org

The at24 driver allows to register I2C EEPROM chips using different vendor
and devices, but the I2C subsystem does not take the vendor into account
when matching using the I2C table since it only has device entries.

But when matching using an OF table, both the vendor and device has to be
taken into account so the driver defines only a set of compatible strings
using the "atmel" vendor as a generic fallback for compatible I2C devices.

So add this generic fallback to the device node compatible string to make
the device to match the driver using the OF device ID table.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

---

Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/am335x-baltos.dtsi            |  2 +-
 arch/arm/boot/dts/am335x-base0033.dts           |  2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       | 10 +++++-----
 arch/arm/boot/dts/am335x-nano.dts               |  2 +-
 arch/arm/boot/dts/am335x-pepper.dts             |  2 +-
 arch/arm/boot/dts/am335x-shc.dts                |  2 +-
 arch/arm/boot/dts/am335x-sl50.dts               |  2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |  2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts             |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |  2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |  2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi             |  2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi       |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts              |  2 +-
 arch/arm/boot/dts/omap5-sbc-t54.dts             |  2 +-
 17 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index d42b98f15e8b..ec6052c521ef 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -255,7 +255,7 @@
 	};
 
 	at24@50 {
-		compatible = "at24,24c02";
+		compatible = "atmel,24c02";
 		pagesize = <8>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index c2bee452dab8..29782be07605 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -89,7 +89,7 @@
 
 &i2c0 {
 	eeprom: eeprom@50 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bf6b26abe35b..1d154444dfef 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -232,7 +232,7 @@
 	};
 
 	baseboard_eeprom: baseboard_eeprom@50 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x50>;
 
 		#address-cells = <1>;
@@ -251,7 +251,7 @@
 	clock-frequency = <100000>;
 
 	cape_eeprom0: cape_eeprom0@54 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x54>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -261,7 +261,7 @@
 	};
 
 	cape_eeprom1: cape_eeprom1@55 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x55>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -271,7 +271,7 @@
 	};
 
 	cape_eeprom2: cape_eeprom2@56 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x56>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -281,7 +281,7 @@
 	};
 
 	cape_eeprom3: cape_eeprom3@57 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x57>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 807494bc722b..0efd27dc63e3 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -224,7 +224,7 @@
 	};
 
 	eeprom@53 {
-		compatible = "microchip,24c02";
+		compatible = "atmel,24c02";
 		reg = <0x53>;
 		pagesize = <8>;
 	};
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 30e2f8770aaf..03c7d77023c6 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -67,7 +67,7 @@
 	};
 
 	eeprom: eeprom@50 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index bf8727a19ece..4f6a286ea293 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -188,7 +188,7 @@
 	};
 
 	at24@50 {
-		compatible = "at24,24c32";
+		compatible = "atmel,24c32";
 		pagesize = <32>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index c5d2589c55fc..a82a4042eb9d 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -309,7 +309,7 @@
 	};
 
 	eeprom: eeprom@50 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
 
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index c1f7f9336e64..5e364473067f 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -339,7 +339,7 @@
 	clock-frequency = <400000>;
 
 	at24@50 {
-		compatible = "at24,24c256";
+		compatible = "atmel,24c256";
 		pagesize = <64>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 4dc54bee2f36..a62e1583da04 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -511,7 +511,7 @@
 	};
 
 	at24@50 {
-		compatible = "at24,24c256";
+		compatible = "atmel,24c256";
 		pagesize = <64>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9acd4ccdec4e..f6648ab10d29 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -477,7 +477,7 @@
 	};
 
 	at24@50 {
-		compatible = "at24,24c256";
+		compatible = "atmel,24c256";
 		pagesize = <64>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 585d792a8fdd..fdfe5b16b806 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -388,7 +388,7 @@
 	};
 
 	eeprom: eeprom@50 {
-		compatible = "at,24c32";
+		compatible = "atmel,24c32";
 		reg = <0x50>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 57b9a028a49a..fccd5383243c 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -188,7 +188,7 @@
 	clock-frequency = <400000>;
 
 	at24@50 {
-		compatible = "at24,24c02";
+		compatible = "atmel,24c02";
 		pagesize = <16>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 9ec737069369..4504908c23fe 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -419,7 +419,7 @@
 
 	/* RFID EEPROM */
 	m24lr64@50 {
-		compatible = "at,24c64";
+		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 73643fabde5d..b096b8549413 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -90,7 +90,7 @@
 	clock-frequency = <400000>;
 
 	at24@50 {
-		compatible = "at24,24c02";
+		compatible = "atmel,24c02";
 		pagesize = <16>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
index 758b6eb7ae43..2f8b33434aa1 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -241,7 +241,7 @@
 	};
 
 	eeprom@50 {
-		compatible = "microchip,24c32";
+		compatible = "atmel,24c32";
 		reg = <0x50>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index b153f604932a..78397f66d0b2 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -404,7 +404,7 @@
 	clock-frequency = <400000>;
 
 	at24@50 {
-		compatible = "at24,24c02";
+		compatible = "atmel,24c02";
 		pagesize = <16>;
 		reg = <0x50>;
 	};
diff --git a/arch/arm/boot/dts/omap5-sbc-t54.dts b/arch/arm/boot/dts/omap5-sbc-t54.dts
index 337bbbc01a35..7b8810d13257 100644
--- a/arch/arm/boot/dts/omap5-sbc-t54.dts
+++ b/arch/arm/boot/dts/omap5-sbc-t54.dts
@@ -44,7 +44,7 @@
 	clock-frequency = <400000>;
 
 	at24@50 {
-		compatible = "at24,24c02";
+		compatible = "atmel,24c02";
 		pagesize = <16>;
 		reg = <0x50>;
 	};
-- 
2.9.3
