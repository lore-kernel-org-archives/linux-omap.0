From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 4/4] ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
Date: Mon, 17 Sep 2012 12:53:22 +0530
Message-ID: <1347866602-2088-5-git-send-email-anilkumar@ti.com>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33498 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab2IQHYT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 03:24:19 -0400
In-Reply-To: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, greg@kroah.com, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Add lis331dlh device tree data to am335x-evm.dts. In AM335x EVM
lis331dlh accelerometer is connected to I2C2 bus. So this patch
change the status of I2C2 node to "okay" to use I2C2 bus. Also
added all the required platform data to am335x-evm.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9fb59c5..be309df 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -47,6 +47,39 @@
 			};
 		};
 
+		i2c2: i2c@4802a000 {
+			status = "okay";
+			clock-frequency = <400000>;
+
+			lis331dlh: lis331dlh@18 {
+				compatible = "st,lis331dlh", "st,lis3lv02d";
+				reg = <0x18>;
+				Vdd-supply = <&lis3_reg>;
+				Vdd_IO-supply = <&lis3_reg>;
+
+				st,click-single-x;
+				st,click-single-y;
+				st,click-single-z;
+				st,click-thresh-x = <10>;
+				st,click-thresh-y = <10>;
+				st,click-thresh-z = <10>;
+				st,irq1-click;
+				st,irq2-click;
+				st,wakeup-x-lo;
+				st,wakeup-x-hi;
+				st,wakeup-y-lo;
+				st,wakeup-y-hi;
+				st,wakeup-z-lo;
+				st,wakeup-z-hi;
+				st,min-limit-x = <120>;
+				st,min-limit-y = <120>;
+				st,min-limit-z = <140>;
+				st,max-limit-x = <550>;
+				st,max-limit-y = <550>;
+				st,max-limit-z = <750>;
+			};
+		};
+
 		dcan1: d_can@481d0000 {
 			status = "okay";
 			pinctrl-names = "default";
@@ -61,6 +94,12 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 	};
+
+	lis3_reg: fixedregulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "lis3_reg";
+		regulator-boot-on;
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5

