From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v4 8/8] DT:omap3+ads7846: use new common touchscreen bindings
Date: Mon, 17 Oct 2016 15:57:56 +0200
Message-ID: <c6100c315496a5fde69029f7b7b0a5d2c3ffda0a.1476712675.git.hns@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1476712675.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1476712675.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1476712675.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The standard touch screen bindings [1] replace the private ti,swap-xy
with touchscreen-swaped-x-y. And for the Openpandora we use
touchscreen-size etc. to match the LCD screen size.

[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Tested with OpenPandora.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi              |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi          | 17 +++++++++++++----
 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |  3 ++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index fa611a5..b8b3864 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -325,7 +325,7 @@
 		ti,y-max = /bits/ 16 <3600>;
 		ti,x-plate-ohms = /bits/ 16 <80>;
 		ti,pressure-max = /bits/ 16 <255>;
-		ti,swap-xy;
+		touchscreen-swapped-x-y;
 
 		wakeup-source;
 	};
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index b0d1551..d12008a 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -700,10 +700,19 @@
 		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&vaux4>;
 
-		ti,x-min = /bits/ 16 <0>;
-		ti,x-max = /bits/ 16 <8000>;
-		ti,y-min = /bits/ 16 <0>;
-		ti,y-max = /bits/ 16 <4800>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-max-pressure = <1000>;
+		touchscreen-fuzz-x = <16>;
+		touchscreen-fuzz-y = <16>;
+		touchscreen-fuzz-pressure = <10>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+
+		ti,x-min = /bits/ 16 <160>;
+		ti,x-max = /bits/ 16 <3900>;
+		ti,y-min = /bits/ 16 <220>;
+		ti,y-max = /bits/ 16 <3750>;
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
 
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index 157345b..3627a63 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -66,6 +66,7 @@
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
 		ti,swap-xy;
-		wakeup-source;
+		touchscreen-swapped-x-y;
+		linux,wakeup;
 	};
 };
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
