From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 10/11] ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for usb2_phy1 and usb2_phy2
Date: Fri, 29 Sep 2017 11:44:28 -0500
Message-ID: <20170929164429.780-11-afd@ti.com>
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
 arch/arm/boot/dts/am43x-epos-evm.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index ce7a44daf839..e745a038c222 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -470,6 +470,30 @@
 			>;
 		};
 
+		usb2_phy1_default: usb2_phy1_default {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0xac0, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			>;
+		};
+
+		usb2_phy1_sleep: usb2_phy1_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0xac0, DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
+		usb2_phy2_default: usb2_phy2_default {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0xac4, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			>;
+		};
+
+		usb2_phy2_sleep: usb2_phy2_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0xac4, DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
 		mcasp1_pins: mcasp1_pins {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x9a0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_ACLKR/MCASP1_ACLKX */
@@ -791,6 +815,9 @@
 
 &usb2_phy1 {
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usb2_phy1_default>;
+	pinctrl-1 = <&usb2_phy1_sleep>;
 };
 
 &usb1 {
@@ -800,6 +827,9 @@
 
 &usb2_phy2 {
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usb2_phy2_default>;
+	pinctrl-1 = <&usb2_phy2_sleep>;
 };
 
 &usb2 {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
