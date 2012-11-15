From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] ARM/dts: omap4-panda: Add USB Host support
Date: Thu, 15 Nov 2012 16:56:35 +0200
Message-ID: <1352991396-19589-4-git-send-email-rogerq@ti.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352991396-19589-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Get USB Host working. On Panda, two GPIOs are used, one for
HUB/PHY reset and other for Hub power. We model them as fixed
regulators. The regulator for RESET is made to depend on regulator
for Hub power so that the Hub power is enabled by the regulator
framework before RESET is removed.

Tested on Panda ES B1.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi      |    5 +++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 6811b37..f67a65a 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -57,6 +57,27 @@
 			"AFML", "Line In",
 			"AFMR", "Line In";
 	};
+
+	hubpower: fixedregulator@0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vhub0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 1 0>;		/* gpio 1 : HUB Power */
+			startup-delay-us = <70000>;
+			enable-active-high;
+	};
+
+	hubreset: fixedregulator@1 {
+			compatible = "regulator-fixed";
+			regulator-name = "hsusb0";	/* tag to associate with PORT 1 */
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 30 0>;	/* gpio 62 : HUB & PHY Reset */
+			startup-delay-us = <70000>;
+			enable-active-high;
+			vin-supply = "vhub0"; /* Makes regulator f/w enable power before reset */
+	};
 };
 
 &omap4_pmx_core {
@@ -136,6 +157,21 @@
 	};
 };
 
+
+&usbhost {
+	port@0 {
+		mode = <1>;		/* PHY mode */
+		clk = "auxclk3_ck";	/* PHY clock on FREF_CLK3_OUT */
+		clkrate = <19200000>;
+	};
+	port@1 {
+		mode = <0>;
+	};
+	port@2 {
+		mode = <0>;
+	};
+};
+
 /include/ "twl6030.dtsi"
 
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3883f94..0062c59 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -438,5 +438,10 @@
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
 		};
+
+		usbhost: usb-host {
+			compatible = "ti,usb-host";
+			num_ports = <2>;
+		};
 	};
 };
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
