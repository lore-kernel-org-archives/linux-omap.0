From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 30/32] ARM: dts: omap3-gta04a5: uses different sensors than gta04a4
Date: Wed, 25 Jul 2018 08:59:02 +0200
Message-ID: <7a93a3e9a1dae7949d14c7a28cd0b5f529786718.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Sensors for acceleration, rotation, magnetic heading and
barometer have been replaced in the A5 variant.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 453a87ebb860..973d07d0b4c8 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -105,3 +105,30 @@
 		ref-clock-frequency = <26000000>;
 	};
 };
+
+&i2c2 {
+	/delete-node/ bmp085@77;
+	/delete-node/ bma180@41;
+	/delete-node/ itg3200@68;
+	/delete-node/ hmc5843@1e;
+
+	bmg160@69 {
+		compatible = "bosch,bmg160";
+		reg = <0x69>;
+	};
+
+	bmc150@10 {
+		compatible = "bosch,bmc150_accel";
+		reg = <0x10>;
+	};
+
+	bmc150@12 {
+		compatible = "bosch,bmc150_magn";
+		reg = <0x12>;
+	};
+
+	bme280@76 {
+		compatible = "bosch,bme280";
+		reg = <0x76>;
+	};
+};
-- 
2.12.2
