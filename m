From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/4] ARM: dts: igep00x0: Specify the device to be used for boot console output.
Date: Sat, 16 Jan 2016 11:51:10 +0100
Message-ID: <1452941473-6349-2-git-send-email-enric.balletbo@collabora.com>
References: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Pau Pajuel <ppajuel@gmail.com>
List-Id: linux-omap@vger.kernel.org

UART3 device is the device to be used for boot console output.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 3caf062..4fc7e0f 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -18,6 +18,10 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	sound {
 		compatible = "ti,omap-twl4030";
 		ti,model = "igep2";
-- 
2.1.0
