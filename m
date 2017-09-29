From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/11] ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for uart0
Date: Fri, 29 Sep 2017 11:44:27 -0500
Message-ID: <20170929164429.780-10-afd@ti.com>
References: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929164429.780-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 569c9ac200c8..ce7a44daf839 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -452,6 +452,24 @@
 			>;
 		};
 
+		uart0_pins_default: uart0_pins_default {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0) /* uart0_ctsn.uart0_ctsn */
+				AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0) /* uart0_rtsn.uart0_rtsn */
+				AM4372_IOPAD(0x970, PIN_INPUT_PULLUP | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				AM4372_IOPAD(0x974, PIN_INPUT | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			>;
+		};
+
+		uart0_pins_sleep: uart0_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x970, PIN_INPUT_PULLUP | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0)
+				AM4372_IOPAD(0x974, PIN_INPUT | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0)
+			>;
+		};
+
 		mcasp1_pins: mcasp1_pins {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x9a0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_ACLKR/MCASP1_ACLKX */
@@ -879,6 +897,13 @@
 	};
 };
 
+&uart0 {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&uart0_pins_default>;
+	pinctrl-1 = <&uart0_pins_sleep>;
+};
+
 &mcasp1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default", "sleep";
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
