From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 1/4] ARM: dts: tps65217: Add charger interrupts to the common tps65217.dtsi file
Date: Mon, 12 Jun 2017 23:24:09 +0200
Message-ID: <20170612212412.22719-1-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The interrupt specifiers for USB and AC charger input are static data that
comes from the datasheet, there is no reason to need to define these values
on every board so seem reasonable put this information into the common
tps65217 file.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 --
 arch/arm/boot/dts/am335x-chiliboard.dts   | 2 --
 arch/arm/boot/dts/tps65217.dtsi           | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bf6b26a..bfa4258 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -319,8 +319,6 @@
 	ti,pmic-shutdown-controller;
 
 	charger {
-		interrupts = <0>, <1>;
-		interrupt-names = "USB", "AC";
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index d876979..5c25f3a 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -191,8 +191,6 @@
 	interrupts = <7>; /* NNMI */
 
 	charger {
-		interrupts = <0>, <1>;
-		interrupt-names = "USB", "AC";
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 02de56b..1973159 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -18,6 +18,8 @@
 
 	charger {
 		compatible = "ti,tps65217-charger";
+		interrupts = <0>, <1>;
+		interrupt-names = "USB", "AC";
 		status = "disabled";
 	};
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
