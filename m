From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/20] ARM: dts: dm816x: add fck under timers1/2
Date: Thu, 7 Dec 2017 10:46:40 +0200
Message-ID: <1512636413-25243-8-git-send-email-t-kristo@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512636413-25243-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add the functional clock definition for timers1/2. This is needed so that
the clock rate claculations continue to function properly once dm816x
transitions away from hwmod data and towards the clkctrl clocks.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dm816x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 566b2a8..12edb8f 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -331,6 +331,8 @@
 			interrupts = <67>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			clocks = <&timer1_fck>;
+			clock-names = "fck";
 		};
 
 		timer2: timer@48040000 {
@@ -338,6 +340,8 @@
 			reg = <0x48040000 0x2000>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
+			clocks = <&timer2_fck>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@48042000 {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
