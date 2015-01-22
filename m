From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 08/13] ARM: dts: omap3-gta04: add comments about gpios
Date: Thu, 22 Jan 2015 21:38:14 +0100
Message-ID: <1421959099-28319-9-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421959099-28319-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, neilb-l3A5Bk7waGM@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>

Add comments to state which GPIO is used for some interrupts.

Signed-off-by: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 6f5fcbb..b65b5ed 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -229,7 +229,7 @@
 		compatible = "bosch,bmp085";
 		reg = <0x77>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* GPIO_113 */
 	};
 
 	/* accelerometer */
@@ -237,7 +237,7 @@
 		compatible = "bosch,bma180";
 		reg = <0x41>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>; /* GPIO_115 */
 	};
 
 	/* leds */
@@ -288,7 +288,7 @@
 		compatible = "ti,tsc2007";
 		reg = <0x48>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>; /* GPIO_160 */
 		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <600>;
 	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
