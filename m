From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH] ARM: dts: omap4-droid4: Fix WLAN compatible
Date: Thu,  8 Jun 2017 23:16:08 +0200
Message-ID: <20170608211608.9051-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Motorola Droid 4 uses a WL1285C, so use proper compatible value.
To avoid regressions while support for the new compatible value
is added to the Linux kernel, the old compatible value is preserved
as fallback.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Hi,

The patch adding ti,wl1285 support to wlcore has been send separately.
Due to the fallback compatible value there is no dependency between
the patches.

-- Sebastian
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 13f8d8640208..caf320ea5b4f 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -301,7 +301,7 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
-		compatible = "ti,wl1283";
+		compatible = "ti,wl1285", "ti,wl1283";
 		reg = <2>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>; /* gpio100 */
-- 
2.11.0
