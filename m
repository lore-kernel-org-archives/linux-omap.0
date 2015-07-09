From: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] ARM: dts: configure regulators for Gumstix Pepper
Date: Thu,  9 Jul 2015 15:37:57 -0700
Message-ID: <1436481477-18002-1-git-send-email-adam.yh.lee@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ashcharles-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org, arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Boot process is halting in midway because some of the necessary voltage
regulators are deemed unused and subsequently powered off, leading to
a completely unresponsive system.

Most of the device nodes had correct voltage regulator attachments.
Yet these nodes had to set stricter enforcement on them through
'regulator-boot-on' and 'regulator-always-on' to function correctly.

The consumers of the regulators this commit affect are the followings:

	DCDC1: vdd_1v8 system supply, USB-PHY, and ADC
	DCDC2: Core domain
	DCDC3: MPU core domain
	 LDO1: RTC
	 LDO2: 3v3 IO domain
	 LDO3: USB-PHY; not a boot-time requirement
	 LDO4: LCD [16:23]

All but LDO3 need to be always-on for the system to be functional.

Additionally regulator-name properties have been added for the kernel to
display the name from the schematic. This will improve diagnostics.

Signed-off-by: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/am335x-pepper.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 0d35ab6..661f835 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -438,6 +438,7 @@
 	regulators {
 		dcdc1_reg: regulator@0 {
 			/* VDD_1V8 system supply */
+			regulator-always-on;
 		};
 
 		dcdc2_reg: regulator@1 {
@@ -446,6 +447,7 @@
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1325000>;
 			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		dcdc3_reg: regulator@2 {
@@ -454,25 +456,32 @@
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1150000>;
 			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		ldo1_reg: regulator@3 {
 			/* VRTC 1.8V always-on supply */
+			regulator-name = "vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator@4 {
 			/* 3.3V rail */
+			regulator-name = "vdd_3v3aux";
+			regulator-always-on;
 		};
 
 		ldo3_reg: regulator@5 {
 			/* VDD_3V3A 3.3V rail */
+			regulator-name = "vdd_3v3a";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
 		ldo4_reg: regulator@6 {
 			/* VDD_3V3B 3.3V rail */
+			regulator-name = "vdd_3v3b";
+			regulator-always-on;
 		};
 	};
 };
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
