From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/5] ARM: dts: OMAP3-N950-N9: Enable SSI module
Date: Sun, 17 Jan 2016 16:49:06 +0100
Message-ID: <1453045749-22642-3-git-send-email-sre@kernel.org>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453045749-22642-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The Nokia N950 and Nokia N9 have a modem attached to their
first ssi port. This change adds all necessary information
to initialize the SSI module, but does not yet add the
modem information.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index e9ee1df0e467..95893003c67d 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -44,6 +44,19 @@
 			0x132 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3 */
 		>;
 	};
+
+	ssi_pins: pinmux_ssi_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE1)            /* ssi1_dat_tx */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE1)            /* ssi1_flag_tx */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE1)      /* ssi1_rdy_tx */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
+			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT | MUX_MODE1)             /* ssi1_dat_rx */
+			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE1)             /* ssi1_flag_rx */
+			OMAP3_CORE1_IOPAD(0x2188, PIN_OUTPUT | MUX_MODE1)            /* ssi1_rdy_rx */
+			OMAP3_CORE1_IOPAD(0x218a, PIN_OUTPUT | MUX_MODE1)            /* ssi1_wake */
+		>;
+	};
 };
 
 &i2c1 {
@@ -191,3 +204,14 @@
 		};
 	};
 };
+
+&ssi_port1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssi_pins>;
+
+	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+};
+
+&ssi_port2 {
+	status = "disabled";
+};
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
