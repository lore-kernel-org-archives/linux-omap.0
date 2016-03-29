From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 4/5] ARM: dts: omap4-kc1: LEDs support
Date: Tue, 29 Mar 2016 21:28:26 +0200
Message-ID: <1459279707-17611-6-git-send-email-contact@paulk.fr>
References: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This adds support for the Kindle Fire (first generation) power button LEDs, that
are wired to the TWL6030 PWM outputs.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap4-kc1.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-kc1.dts b/arch/arm/boot/dts/omap4-kc1.dts
index 0d08f9f..3681414 100644
--- a/arch/arm/boot/dts/omap4-kc1.dts
+++ b/arch/arm/boot/dts/omap4-kc1.dts
@@ -17,6 +17,22 @@
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
+
+	pwmleds {
+		compatible = "pwm-leds";
+
+		green {
+			label = "green";
+			pwms = <&twl_pwm 0 7812500>;
+			max-brightness = <127>;
+		};
+
+		orange {
+			label = "orange";
+			pwms = <&twl_pwm 1 7812500>;
+			max-brightness = <127>;
+		};
+	};
 };
 
 &omap4_pmx_core {
-- 
2.7.4
