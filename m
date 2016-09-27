From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/3] DT: EVM: add EEPROM
Date: Tue, 27 Sep 2016 07:26:08 +0200
Message-ID: <6b0afcb1db269e9dc183a7e6a242ee808ccde1c6.1474953969.git.hns@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474953969.git.hns@goldelico.com>
In-Reply-To: <cover.1474953969.git.hns@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 36ff7c3..be659e8 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -23,6 +23,13 @@
 	vdda-supply = <&ldo4_reg>;
 };
 
+&i2c1 {
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+};
+
 &i2c5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c5_pins>;
-- 
2.7.3
