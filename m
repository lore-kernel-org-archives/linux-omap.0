From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: [PATCH v5 11/12] ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
Date: Tue, 27 Nov 2012 14:18:16 +0530
Message-ID: <1354006097-25895-12-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@avionic-design.de, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com
Cc: hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com, "Philip, Avinash" <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

PWM output from ecap0 uses as backlight source. Also adds low threshold
value to have a uniform divisions in brightness-levels scales.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes since v4:
	- Replaced usage of tab with space in compatible field

Changes since v3:
	- Add epwmss parent status="okay" field.

 arch/arm/boot/dts/am335x-evm.dts |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9f65f17..73a035b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -44,6 +44,12 @@
 				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
 			>;
 		};
+
+		ecap0_pins: backlight_pins {
+			pinctrl-single,pins = <
+				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			>;
+		};
 	};
 
 	ocp {
@@ -102,6 +108,16 @@
 				reg = <0x48>;
 			};
 		};
+
+		epwmss0: epwmss@48300000 {
+			status = "okay";
+
+			ecap0: ecap@48300100 {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&ecap0_pins>;
+			};
+		};
 	};
 
 	vbat: fixedregulator@0 {
@@ -158,6 +174,13 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 0>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.0.4
