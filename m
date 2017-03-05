From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/6] ARM: dts: omap4-droid4: Add LCD backlight
Date: Sat,  4 Mar 2017 21:43:55 -0800
Message-ID: <20170305054359.8293-3-tony@atomide.com>
References: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TI LMU driver has not yet been merged, but the device
tree binding for TI LMU drivers has been acked already
earlier by Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>. So it should
be safe to apply to cut down the number of pending patches.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -180,6 +180,25 @@
 	};
 };
 
+&i2c1 {
+	lm3532@38 {
+		compatible = "ti,lm3532";
+		reg = <0x38>;
+
+		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+
+		backlight {
+			compatible = "ti,lm3532-backlight";
+
+			lcd {
+				led-sources = <0 1 2>;
+				ramp-up-msec = <1>;
+				ramp-down-msec = <0>;
+			};
+		};
+	};
+};
+
 /*
  * REVISIT: Add gpio173 reset pin handling to the driver, see gpio-hog above.
  * If the GPIO reset is used, we probably need to have /lib/firmware/maxtouch.fw
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
