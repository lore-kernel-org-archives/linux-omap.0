From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 14/14] DTS: TWL4030: Add power button support
Date: Wed, 23 Oct 2013 00:49:43 +0200
Message-ID: <1382482183-14426-15-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Enable support for the power button.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index cb5afcd..af7fa40 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -133,4 +133,9 @@
 		compatible = "ti,twl4030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	twl_pwrbutton: pwrbutton {
+		compatible = "ti,twl4030-pwrbutton";
+		interrupts = <8>;
+	};
 };
-- 
1.8.4.rc3
