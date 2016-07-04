From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6 enable during suspend
Date: Mon, 4 Jul 2016 12:04:00 +0530
Message-ID: <1467614042-6838-2-git-send-email-j-keerthy@ti.com>
References: <1467614042-6838-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467614042-6838-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

dcdc3, dcdc5, dcdc6 supply ddr and rtc respectively. These
are required to be on during suspend. Hence set the state accordingly.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 10 ++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 14677d5..fba26c9 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -537,7 +537,11 @@
 			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
+
 		dcdc5: regulator-dcdc5 {
 			compatible = "ti,tps65218-dcdc5";
 			regulator-name = "v1_0bat";
@@ -545,6 +549,9 @@
 			regulator-max-microvolt = <1000000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		dcdc6: regulator-dcdc6 {
@@ -554,6 +561,9 @@
 			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		ldo1: regulator-ldo1 {
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 5687d6b..b5e84e6 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -454,6 +454,9 @@
 			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
 		};
 
 		dcdc4: regulator-dcdc4 {
@@ -465,6 +468,30 @@
 			regulator-always-on;
 		};
 
+		dcdc5: regulator-dcdc5 {
+			compatible = "ti,tps65218-dcdc5";
+			regulator-name = "v1_0bat";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+		};
+
+		dcdc6: regulator-dcdc6 {
+			compatible = "ti,tps65218-dcdc6";
+			regulator-name = "v1_8bat";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+		};
+
 		ldo1: regulator-ldo1 {
 			compatible = "ti,tps65218-ldo1";
 			regulator-name = "v1_8d";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
