From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 2/6] ARM: dts: am437x/am33xx: Remove eCAP and ePWM hwmod properties
Date: Mon,  7 Mar 2016 19:23:40 -0600
Message-ID: <1457400224-24797-3-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457400224-24797-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ECAP and ePWM do not have OCP integration registers, have L3/L4 ports, etc.
Therefore, they shouldn't be using hwmod at all. Remove their hwmod
properties.

For ePWM add the tbclk to the node rather than depending on hwmod to do so.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 12 ++++++------
 arch/arm/boot/dts/am4372.dtsi | 21 ++++++++++++---------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 82c0976..1dd6c78 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -682,7 +682,6 @@
 				reg = <0x48300100 0x80>;
 				interrupts = <31>;
 				interrupt-names = "ecap0";
-				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
 
@@ -690,7 +689,8 @@
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
-				ti,hwmods = "ehrpwm0";
+				clocks = <&ehrpwm0_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -710,7 +710,6 @@
 				reg = <0x48302100 0x80>;
 				interrupts = <47>;
 				interrupt-names = "ecap1";
-				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
 
@@ -718,7 +717,8 @@
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
-				ti,hwmods = "ehrpwm1";
+				clocks = <&ehrpwm1_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -738,7 +738,6 @@
 				reg = <0x48304100 0x80>;
 				interrupts = <61>;
 				interrupt-names = "ecap2";
-				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
@@ -746,7 +745,8 @@
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
-				ti,hwmods = "ehrpwm2";
+				clocks = <&ehrpwm2_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 33f417c..685c8db 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -675,7 +675,6 @@
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
-				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
 
@@ -683,7 +682,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
-				ti,hwmods = "ehrpwm0";
+				clocks = <&ehrpwm0_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -701,7 +701,6 @@
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
-				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
 
@@ -709,7 +708,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
-				ti,hwmods = "ehrpwm1";
+				clocks = <&ehrpwm1_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -727,7 +727,6 @@
 				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
-				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
@@ -735,7 +734,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
-				ti,hwmods = "ehrpwm2";
+				clocks = <&ehrpwm2_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -753,7 +753,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
-				ti,hwmods = "ehrpwm3";
+				clocks = <&ehrpwm3_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -771,7 +772,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
-				ti,hwmods = "ehrpwm4";
+				clocks = <&ehrpwm4_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
@@ -789,7 +791,8 @@
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x4830a200 0x80>;
-				ti,hwmods = "ehrpwm5";
+				clocks = <&ehrpwm5_tbclk>;
+				clock-names = "tbclk";
 				status = "disabled";
 			};
 		};
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
