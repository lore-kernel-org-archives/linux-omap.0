From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/4] ARM: dts: am335x-sl50: Specify the device to be used for boot console output.
Date: Sat, 16 Jan 2016 11:51:12 +0100
Message-ID: <1452941473-6349-4-git-send-email-enric.balletbo@collabora.com>
References: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Pau Pajuel <ppajuel@gmail.com>
List-Id: linux-omap@vger.kernel.org

UART0 device is the device to be used for boot console output.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index d38edfa..9e1dac6 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -19,6 +19,10 @@
 		};
 	};
 
+	chosen {
+		stdout-path = &uart0;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-- 
2.1.0
