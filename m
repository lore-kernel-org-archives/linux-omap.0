From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] ARM: dts: igep00x0: Add SD card-detect.
Date: Fri,  6 May 2016 23:02:33 +0200
Message-ID: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

Fix SD card remove/insert detection by adding the correct card-detect
pin. All IGEP OMAP3 based boards use the same card-detect pin.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 41f5d38..f4f2ce4 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -188,6 +188,7 @@
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
 	bus-width = <4>;
+	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
 };
 
 &mmc3 {
-- 
2.1.0
