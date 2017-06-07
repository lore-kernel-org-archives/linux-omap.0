From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/4] ARM: dts: tps65217: Add backlight and pmic device
Date: Wed,  7 Jun 2017 12:32:40 +0200
Message-ID: <20170607103242.16008-2-enric.balletbo@collabora.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607103242.16008-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

Support the backlight driver but disable by default and also add the
compatible string for regulators.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 02de56b..233581f 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -16,6 +16,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	backlight {
+		compatible = "ti,tps65217-bl";
+		status = "disabled";
+	};
+
 	charger {
 		compatible = "ti,tps65217-charger";
 		status = "disabled";
@@ -27,6 +32,7 @@
 	};
 
 	regulators {
+		compatible = "ti,tps65217-pmic";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.9.3
