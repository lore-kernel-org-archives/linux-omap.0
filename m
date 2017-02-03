From: Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 1/2] DTS: dra7: Replace obsolete "operating-points" property with "operating-points-v2"
Date: Fri,  3 Feb 2017 16:24:50 +0100
Message-ID: <1486135491-14223-1-git-send-email-lukma@denx.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The "operating-points" property have been replaced with
"operating-points-v2". Only entries with the same frequencies have
been added, so no reqression should be introduced.

Signed-off-by: Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3c228f9..a860a56 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -80,11 +80,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 
-			operating-points = <
-				/* kHz    uV */
-				1000000	1060000
-				1176000	1160000
-				>;
+			operating-points-v2 = <&cpu0_opp_table>;
 
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
@@ -98,6 +94,22 @@
 		};
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp_nom@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1060000 850000 1150000>;
+			opp-suspend;
+		};
+
+		opp_od@1176000000 {
+			opp-hz = /bits/ 64 <1176000000>;
+			opp-microvolt = <1160000 885000 1160000>;
+		};
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
