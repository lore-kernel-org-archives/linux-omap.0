From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 6/6] ARM: dts: am335x-sl50: Enable the Ambient Light Sensor.
Date: Mon, 16 Jan 2017 17:57:36 +0100
Message-ID: <20170116165736.17197-7-enric.balletbo@collabora.com>
References: <20170116165736.17197-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116165736.17197-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add support for the ISL29023 ALS connected via the I2C bus.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 010c99e..c5d2589 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -337,6 +337,12 @@
 		DRVDD-supply = <&ldo4_reg>;
 		DVDD-supply = <&ldo3_reg>;
 	};
+
+	/* Ambient Light Sensor */
+	als: isl29023@44 {
+		compatible = "isil,isl29023";
+		reg = <0x44>;
+	};
 };
 
 &rtc {
-- 
2.9.3
