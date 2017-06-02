From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: Remove min and max voltage values for dcdc3
Date: Fri, 2 Jun 2017 14:51:48 +0530
Message-ID: <1496395308-29471-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: j-keerthy-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

dcdc3 supplies to DDR on AM43x series. When we set both
min and max values to the same value. The regulator framework
sets that particular voltage. This is bad as we are changing
the ddr voltage when executing from ddr. Hence remove the min and
max values. The ddr supply voltage shall be set from bootloader
when not executing from ddr and not while executing from kernel.

The previous discussion can be found here:

http://www.spinics.net/lists/devicetree/msg56399.html

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 --
 arch/arm/boot/dts/am437x-sk-evm.dts  | 2 --
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 397e98b..29a538e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -549,8 +549,6 @@
 
 		dcdc3: regulator-dcdc3 {
 			regulator-name = "vdcdc3";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 			regulator-state-mem {
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index a62e158..2c6bf06 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -451,8 +451,6 @@
 
 		dcdc3: regulator-dcdc3 {
 			regulator-name = "vdds_ddr";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 			regulator-state-mem {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index f6648ab..54f40f3 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -442,8 +442,6 @@
 
 		dcdc3: regulator-dcdc3 {
 			regulator-name = "vdcdc3";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
