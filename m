From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: Fix omap l4per idling with wlcore edge sensitive interrupt
Date: Fri, 13 Oct 2017 12:32:43 -0700
Message-ID: <20171013193243.11633-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The wl1835mod.pdf data sheet says this pretty clearly for WL_IRQ line:

"WLAN SDIO out-of-band interrupt line. Set to rising edge (active high)
by default."

And it seems this interrupt can be optionally configured to use falling
edge too since commit bd763482c82e ("wl18xx: wlan_irq: support platform
dependent interrupt types").

On omaps, if the wlcore interrupt is configured as level instead of edge,
L4PER will stop doing hardware based idling after ifconfig wlan0 down is
done and the WL_EN line is pulled down.

The symptoms show up with L4PER status registers no longer showing the
IDLEST bits as 2 but as 0 for all the active GPIO banks and for
L4PER_CLKCTRL. Also the l4per_pwrdm RET count stops increasing in
the /sys/kernel/debug/pm_debug/count.

Fix the issue for all omap boards with wlcore interrupt set as level.

Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-baltos.dtsi           | 2 +-
 arch/arm/boot/dts/am335x-evm.dts               | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts             | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts            | 2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi          | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts           | 2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts           | 2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi        | 2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts     | 2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts     | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts              | 2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts       | 2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi      | 2 +-
 arch/arm/boot/dts/omap4-sdp.dts                | 2 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi | 2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi      | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -396,7 +396,7 @@
 		compatible = "ti,wl1835";
 		reg = <2>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -771,7 +771,7 @@
 		compatible = "ti,wl1835";
 		reg = <2>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -682,7 +682,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <31 IRQ_TYPE_LEVEL_HIGH>; /* gpio 31 */
+		interrupts = <31 IRQ_TYPE_EDGE_RISING>; /* gpio 31 */
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -788,7 +788,7 @@
 		compatible = "ti,wl1835";
 		reg = <2>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <23 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -133,7 +133,7 @@
 		compatible = "ti,wl1273";
 		reg = <2>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>; /* gpio 152 */
+		interrupts = <24 IRQ_TYPE_EDGE_RISING>; /* gpio 152 */
 		ref-clock-frequency = <26000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -152,7 +152,7 @@
 		compatible = "ti,wl1283";
 		reg = <2>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>; /* gpio 152 */
+		interrupts = <24 IRQ_TYPE_EDGE_RISING>; /* gpio 152 */
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -140,7 +140,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>; /* gpio 145 */
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* gpio 145 */
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -80,7 +80,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* gpio 136 */
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>; /* gpio 136 */
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -131,7 +131,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>; /* gpio 149 */
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 149 */
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -49,6 +49,6 @@
 		compatible = "ti,wl1835";
 		reg = <2>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>; /* gpio 177 */
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* gpio 177 */
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -71,6 +71,6 @@
 		compatible = "ti,wl1835";
 		reg = <2>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* gpio 136 */
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>; /* gpio 136 */
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -202,7 +202,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>; /* gpio 162 */
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>; /* gpio 162 */
 		ref-clock-frequency = <26000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -365,7 +365,7 @@
 		compatible = "ti,wl1285", "ti,wl1283";
 		reg = <2>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>; /* gpio100 */
+		interrupts = <4 IRQ_TYPE_EDGE_RISING>; /* gpio100 */
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -463,7 +463,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>; /* gpio 53 */
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 53 */
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -493,7 +493,7 @@
 		compatible = "ti,wl1281";
 		reg = <2>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>; /* gpio 53 */
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 53 */
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
diff --git a/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi b/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
--- a/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
@@ -72,7 +72,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>; /* gpio 41 */
+		interrupts = <9 IRQ_TYPE_EDGE_RISING>; /* gpio 41 */
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -370,7 +370,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&wlcore_irq_pin>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;	/* gpio 14 */
+		interrupts = <14 IRQ_TYPE_EDGE_RISING>;	/* gpio 14 */
 		ref-clock-frequency = <26000000>;
 	};
 };
-- 
2.14.2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
