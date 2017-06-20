From: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am437x-gp-evm: Add support for buzzer
Date: Tue, 20 Jun 2017 10:39:21 +0530
Message-ID: <1497935361-11019-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add support for onboard gpio buzzer. It works using
the gpio-beeper driver. Pinmux entries for GPIO
controlling the buzzer are also added.

Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 397e98b..24cdf6d 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -149,6 +149,13 @@
 			system-clock-frequency = <12000000>;
 		};
 	};
+
+	beeper: beeper {
+		compatible = "gpio-beeper";
+		pinctrl-names = "default";
+		pinctrl-0 = <&beeper_pins>;
+		gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &am43xx_pinmux {
@@ -510,6 +517,13 @@
 			AM4372_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
+
+	beeper_pins: beeper_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x9e0, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* cam1_field.gpio4_12 */
+		>;
+	};
+
 };
 
 &uart0 {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
