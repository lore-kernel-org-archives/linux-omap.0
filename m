From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/8] ARM: dts: am437x-gp-evm: Add regulator-always-on and regulator-boot-on for RTC DCDCs
Date: Wed, 5 Aug 2015 16:19:46 +0530
Message-ID: <1438771792-12604-3-git-send-email-j-keerthy@ti.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438771792-12604-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

DCDC5 and DCDC6 supply rtc and need to be on for accessing the module.

On A1 revision of the TPS65218, FSEAL bit would be undefined without
coin-cell present which in many cases led to it being set, causing DCDC5
and DCDC6 to stay active, but also leading to unexplained failures when
it was not. On B1 revision, FSEAL is always 0 when no coin-cell is present
so this patch is required on boards with B1 revision to ever work. This
implementation works on boards with either A1 or B1 revision and makes
sure that DCDC5 and DCDC6 always stay active.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c..816027b 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -455,6 +455,8 @@
 			regulator-name = "v1_0bat";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		dcdc6: regulator-dcdc6 {
@@ -462,6 +464,8 @@
 			regulator-name = "v1_8bat";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		ldo1: regulator-ldo1 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
