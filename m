From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/5] dt-bindings: clock: ti: add latching support to mux and divider clocks
Date: Thu, 15 Feb 2018 14:49:47 +0200
Message-ID: <1518698991-10099-2-git-send-email-t-kristo@ti.com>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Certain hardware configurations, like dra76x, have some of the clock
registers partitioned in a funky manner that requires the clock
control setup to be latched for PRCM to be notified of the change. This
is accomplished with a separate control bit under the register. Add
support for this clock latching support to divider and mux clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/clock/ti/divider.txt | 3 +++
 Documentation/devicetree/bindings/clock/ti/mux.txt     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti/divider.txt b/Documentation/devicetree/bindings/clock/ti/divider.txt
index 35a6f5c..9b13b32 100644
--- a/Documentation/devicetree/bindings/clock/ti/divider.txt
+++ b/Documentation/devicetree/bindings/clock/ti/divider.txt
@@ -75,6 +75,9 @@ Optional properties:
 - ti,invert-autoidle-bit : autoidle is enabled by setting the bit to 0,
   see [2]
 - ti,set-rate-parent : clk_set_rate is propagated to parent
+- ti,latch-bit : latch the divider value to HW, only needed if the register
+  access requires this. As an example dra76x DPLL_GMAC H14 divider implements
+  such behavior.
 
 Examples:
 dpll_usb_m2_ck: dpll_usb_m2_ck@4a008190 {
diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documentation/devicetree/bindings/clock/ti/mux.txt
index 2d0d170..eec8994 100644
--- a/Documentation/devicetree/bindings/clock/ti/mux.txt
+++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
@@ -48,6 +48,9 @@ Optional properties:
   zero
 - ti,set-rate-parent : clk_set_rate is propagated to parent clock,
   not supported by the composite-mux-clock subtype
+- ti,latch-bit : latch the mux value to HW, only needed if the register
+  access requires this. As an example, dra7x DPLL_GMAC H14 muxing
+  implements such behavior.
 
 Examples:
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
