From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 17/30] dt-bindings: clk: ti: Document module clock type
Date: Mon, 11 Apr 2016 11:19:08 +0300
Message-ID: <1460362761-4842-18-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Document the new TI module clock type, which is intended to replace the
internal clock control handling within omap_hwmod. Module clock is
effectively a gate clock controlling both interface and functional
clocks for a single hardware IP block.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/clock/ti/module.txt        |   59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/module.txt

diff --git a/Documentation/devicetree/bindings/clock/ti/module.txt b/Documentation/devicetree/bindings/clock/ti/module.txt
new file mode 100644
index 0000000..0329667
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/module.txt
@@ -0,0 +1,59 @@
+Binding for Texas Instruments module clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1]. This clock is
+quite much similar to the basic gate-clock [2], however, internally
+it controls an OMAP module clock, which effectively handles
+both interface and functional clocks for a single module. In some
+cases, support for mux clock [3] is composited to the same clock node,
+currently only needed for proper support of timer module clocks.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/ti/gate.txt
+[3] Documentation/devicetree/bindings/clock/ti/mux.txt
+
+Required properties:
+- compatible : shall be one of:
+  "ti,omap4-mod-clock" - basic module clock, no gating supported
+  "ti,omap4-hw-mod-clock" - module clock with hardware gating support
+  "ti,omap4-sw-mod-clock" - module clock with software forced gating support
+  "ti,omap4-sw-no-idlest-mod-clock" - module clock with software forced gating
+				      support, misses idlest
+  "ti,omap4-mux-mod-clock" - composite clock with mux and module clocks, no
+			     gating supported
+  "ti,omap4-hw-mux-mod-clock" - composite clock with mux and module clocks,
+				with hardware gating
+  "ti,omap4-sw-mux-mod-clock" - composite clock with mux and module clocks,
+				with software forced gating
+
+- #clock-cells : from common clock binding; shall be set to 0
+- clocks : link to phandle of parent clock(s)
+- reg : offset for register controlling adjustable gate and optional mux
+
+Optional properties:
+- ti,bit-shift : bit shift for programming the clock mux, only needed for
+		 the nodes of the mux variant
+
+Examples:
+	timer6_mod_ck: timer6_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mux-mod-clock";
+		reg = <0x0570>;
+		clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+		ti,bit-shift = <24>;
+	};
+
+	i2c1_mod_ck: i2c1_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-sw-mod-clock";
+		reg = <0x14a0>;
+		clocks = <&func_96m_fclk>;
+	};
+
+	hsi_mod_ck: hsi_mod_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-hw-mod-clock";
+		reg = <0x1338>;
+		clocks = <&hsi_fck>;
+	};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
