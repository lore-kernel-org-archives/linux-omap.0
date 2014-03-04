From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 06/14] CLK: TI: gate: fixed DT binding documentation bugs
Date: Tue, 4 Mar 2014 11:18:12 +0200
Message-ID: <1393924700-6510-7-git-send-email-t-kristo@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57675 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742AbaCDJTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 04:19:34 -0500
In-Reply-To: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti,composite-gate-clock documentation was missing, also the register
offset examples were wrong.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/gate.txt          |   29 +++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
index 125281a..03f8fde 100644
--- a/Documentation/devicetree/bindings/clock/ti/gate.txt
+++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
@@ -25,6 +25,11 @@ Required properties:
 			  to map clockdomains properly
   "ti,hsdiv-gate-clock" - gate clock with OMAP36xx specific hardware handling,
 			  required for a hardware errata
+  "ti,composite-gate-clock" - composite gate clock, to be part of composite
+			      clock
+  "ti,composite-no-wait-gate-clock" - composite gate clock that does not wait
+				      for clock to be active before returning
+				      from clk_enable()
 - #clock-cells : from common clock binding; shall be set to 0
 - clocks : link to phandle of parent clock
 - reg : offset for register controlling adjustable gate, not needed for
@@ -41,7 +46,7 @@ Examples:
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&core_96m_fck>;
-		reg = <0x48004a00 0x4>;
+		reg = <0x0a00>;
 		ti,bit-shift = <25>;
 	};
 
@@ -57,7 +62,7 @@ Examples:
 		#clock-cells = <0>;
 		compatible = "ti,dss-gate-clock";
 		clocks = <&dpll4_m4x2_ck>;
-		reg = <0x48004e00 0x4>;
+		reg = <0x0e00>;
 		ti,bit-shift = <0>;
 	};
 
@@ -65,7 +70,7 @@ Examples:
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
-		reg = <0x4800259c 0x4>;
+		reg = <0x059c>;
 		ti,bit-shift = <1>;
 	};
 
@@ -80,6 +85,22 @@ Examples:
 		compatible = "ti,hsdiv-gate-clock";
 		clocks = <&dpll4_m2x2_mul_ck>;
 		ti,bit-shift = <0x1b>;
-		reg = <0x48004d00 0x4>;
+		reg = <0x0d00>;
 		ti,set-bit-to-disable;
 	};
+
+	vlynq_gate_fck: vlynq_gate_fck {
+		#clock-cells = <0>;
+		compatible = "ti,composite-gate-clock";
+		clocks = <&core_ck>;
+		ti,bit-shift = <3>;
+		reg = <0x0200>;
+	};
+
+	sys_clkout2_src_gate: sys_clkout2_src_gate {
+		#clock-cells = <0>;
+		compatible = "ti,composite-no-wait-gate-clock";
+		clocks = <&core_ck>;
+		ti,bit-shift = <15>;
+		reg = <0x0070>;
+	};
-- 
1.7.9.5

