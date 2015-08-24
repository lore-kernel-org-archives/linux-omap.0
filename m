From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/11] ARM: DTS: dra7-evm: Add fixed regulator to be used by aic3106's DVDD
Date: Mon, 24 Aug 2015 10:20:00 +0300
Message-ID: <1440400807-32274-5-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

TPS77018DBVT is used to create 1.8V from avm_3v3_sw's 3.3V connected to
aic3106's DVDD.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index de02cf5853a9..add77ac4f302 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -35,6 +35,15 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	aic_dvdd: fixedregulator-aic_dvdd {
+		/* TPS77018DBVT */
+		compatible = "regulator-fixed";
+		regulator-name = "aic_dvdd";
+		vin-supply = <&evm_3v3_sw>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	extcon_usb1: extcon_usb1 {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 1 GPIO_ACTIVE_HIGH>;
-- 
2.5.0
