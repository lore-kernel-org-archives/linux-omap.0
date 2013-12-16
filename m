From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 17/27] ARM: omap3-tobi.dts: add lcd (TEST)
Date: Mon, 16 Dec 2013 16:56:24 +0200
Message-ID: <1387205794-32246-18-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I used
it as a test.

Not to be merged.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-tobi.dts | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 7e4ad2aec37a..3baf3a286435 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -81,3 +81,50 @@
 &mmc3 {
 	status = "disabled";
 };
+
+&dss {
+	/* XXX add pinctrl */
+	/*
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+	*/
+
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&lcd_in>;
+		data-lines = <24>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display@0 {
+		compatible = "samsung,lte430wq-f0c", "panel-dpi";
+		label = "lcd";
+
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+
+		panel-timing {
+			clock-frequency = <9200000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <8>;
+			hback-porch = <4>;
+			hsync-len = <41>;
+			vback-porch = <2>;
+			vfront-porch = <4>;
+			vsync-len = <10>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
