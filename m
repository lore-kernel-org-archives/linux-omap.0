From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/6] ARM: dts: am335x-sl50: Enable BQ32000 Real Time Clock.
Date: Mon, 16 Jan 2017 17:57:34 +0100
Message-ID: <20170116165736.17197-5-enric.balletbo@collabora.com>
References: <20170116165736.17197-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116165736.17197-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add support for the BQ32000 Real Time Clock connected to the I2C bus
and disable the AM335x Real Time Clock.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 6f32078..fddef18 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -302,10 +302,18 @@
 		reg = <0x24>;
 	};
 
+	bq32000: rtc@68 {
+		compatible = "ti,bq32000";
+		trickle-resistor-ohms = <1120>;
+		reg = <0x68>;
+	};
+
 	eeprom: eeprom@50 {
 		compatible = "at,24c256";
 		reg = <0x50>;
 	};
+
+
 };
 
 &i2c2 {
@@ -327,6 +335,10 @@
 	};
 };
 
+&rtc {
+	status = "disabled";
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.9.3
