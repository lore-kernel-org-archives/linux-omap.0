From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: dts: Fix omap l4per idling with wlcore edge
 sensitive interrupt
Date: Thu, 17 May 2018 16:35:40 -0700
Message-ID: <20180517233542.30629-3-tony@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517233542.30629-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Marcel Partap <mpartap@gmx.net>, Dave Gerlach <d-gerlach@ti.com>, Pavel Machek <pavel@ucw.cz>, Keerthy <j-keerthy@ti.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, NeKit <nekit1000@gmail.com>, Eyal Reizer <eyalr@ti.com>, linux-arm-kernel@lists.infradead.org, Michael Scott <hashcode0f@gmail.com>, Kalle Valo <kvalo@codeaurora.org>, Ash Charles <ash@gumstix.com>
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

I'm guessing wlcore was at some point configured to use level interrupts
because of edge handling issues in gpio-omap. However, with the recent
fixes to gpio-omap the edge interrupts seem to be working just fine.

Let's fix the issue for all omap boards with wlcore interrupt set as level.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Eyal Reizer <eyalr@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-baltos.dtsi              | 2 +-
 arch/arm/boot/dts/am335x-evm.dts                  | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               | 2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi             | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts              | 2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts              | 2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts        | 2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts        | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                 | 2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts          | 2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi         | 2 +-
 arch/arm/boot/dts/omap4-sdp.dts                   | 2 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi    | 2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi         | 2 +-
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
@@ -790,7 +790,7 @@
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
@@ -113,7 +113,7 @@
 		compatible = "ti,wl1273";
 		reg = <2>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>; /* gpio 2 */
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>; /* gpio 2 */
 		ref-clock-frequency = <26000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -48,7 +48,7 @@
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
@@ -141,7 +141,7 @@
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
@@ -81,7 +81,7 @@
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
@@ -133,7 +133,7 @@
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
@@ -372,7 +372,7 @@
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
@@ -464,7 +464,7 @@
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
@@ -364,7 +364,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&wlcore_irq_pin>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;	/* gpio 14 */
+		interrupts = <14 IRQ_TYPE_EDGE_RISING>;	/* gpio 14 */
 		ref-clock-frequency = <26000000>;
 	};
 };
-- 
2.17.0
