From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Wed, 3 Jun 2015 17:21:24 +0530
Message-ID: <1433332284-10766-6-git-send-email-vigneshr@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433332284-10766-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add PWMSS device tree nodes for DRA7 SoC family and add documentation
for dt bindings.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  8 +++
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 17 +++++-
 arch/arm/boot/dts/dra7.dtsi                        | 64 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 9c100b2c5b23..25d91ae57de5 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
   for am33xx - compatible = "ti,am33xx-ehrpwm";
   for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+  for dra7xx - compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -27,3 +28,10 @@ ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
 };
+
+ehrpwm0: ehrpwm@0 { /* EHRPWM on dra7xx */
+	compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
+	#pwm-cells = <3>;
+	reg = <0x48440200 0x80>;
+	ti,hwmods = "ehrpwm0";
+};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index f7eae77f8354..9270ce6b2da2 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
@@ -1,7 +1,9 @@
 TI SOC based PWM Subsystem
 
 Required properties:
-- compatible: Must be "ti,am33xx-pwmss";
+- compatible: Must be "ti,<soc>-pwmss".
+  for am33xx - compatible = "ti,am33xx-pwmss"
+  for dra7xx - compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss"
 - reg: physical base address and size of the registers map.
 - address-cells: Specify the number of u32 entries needed in child nodes.
 		  Should set to 1.
@@ -29,3 +31,16 @@ pwmss0: pwmss@48300000 {
 
 	/* child nodes go here */
 };
+
+epwmss0: epwmss@4843e000 { /* On DRA7xx */
+	compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+	reg = <0x4843e000 0x30>;
+	ti,hwmods = "epwmss0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x4843e100  0x4843e100 0x80	/* ECAP */
+		  0x4843e180  0x4843e180 0x80	/* EQEP */
+		  0x4843e200  0x4843e200 0x80>; /* EHRPWM */
+
+	/* child nodes go here */
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 387c76ca41f9..98a9203d6992 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1474,6 +1474,70 @@
 			clocks = <&sys_clkin1>;
 			status = "disabled";
 		};
+
+		epwmss0: epwmss@4843e000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x4843e000 0x30>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges = <0x4843e100  0x4843e100 0x80  /* ECAP */
+				  0x4843e180  0x4843e180 0x80  /* EQEP */
+				  0x4843e200  0x4843e200 0x80>;/* EHRPWM */
+
+			ehrpwm0: ehrpwm@4843e200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x4843e200 0x80>;
+				ti,hwmods = "ehrpwm0";
+				status = "disabled";
+			};
+		};
+
+		epwmss1: epwmss@48440000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48440000 0x30>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges = <0x48440100  0x48440100  0x80   /* ECAP */
+				  0x48440180  0x48440180  0x80   /* EQEP */
+				  0x48440200  0x48440200  0x80>; /* EHRPWM */
+
+			ehrpwm1: ehrpwm@48440200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48440200 0x80>;
+				ti,hwmods = "ehrpwm1";
+				status = "disabled";
+			};
+		};
+
+		epwmss2: epwmss@48442000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48442000 0x30>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			ranges = <0x48442100  0x48442100  0x80   /* ECAP */
+				  0x48442180  0x48442180  0x80   /* EQEP */
+				  0x48442200  0x48442200  0x80>; /* EHRPWM */
+
+			ehrpwm2: ehrpwm@48442200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48442200 0x80>;
+				ti,hwmods = "ehrpwm2";
+				status = "disabled";
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
