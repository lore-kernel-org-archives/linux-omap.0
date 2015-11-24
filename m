From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 07/14] ARM: am437x: cm-t43: dts: add USB support
Date: Tue, 24 Nov 2015 15:19:08 +0200
Message-ID: <1448371155-17307-8-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448371155-17307-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add USB support for CompuLab sbc-t43 single board computer,
defaulting to host mode.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
 arch/arm/boot/dts/am437x-cm-t43.dts  | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts | 22 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 856b2ce..70d5c20 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -327,6 +327,36 @@
 	dual_emac_res_vlan = <2>;
 };
 
+&dwc3_1 {
+	status = "okay";
+};
+
+&usb2_phy1 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&dwc3_2 {
+	status = "okay";
+};
+
+&usb2_phy2 {
+	status = "okay";
+};
+
+&usb2 {
+	dr_mode = "host";
+	status = "okay";
+	interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "peripheral", "host", "otg";
+};
+
 &elm {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index f3cd76b..5d2919e 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -36,6 +36,18 @@
 			AM4372_IOPAD(0x97c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE3)  /* uart1_rtsn.i2c2_scl */
 		>;
 	};
+
+	usb2_phy1_default: usb2_phy1_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0xac0, DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	usb2_phy2_default: usb2_phy2_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0xac4, DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
 };
 
 &i2c1 {
@@ -55,3 +67,13 @@
 	pinctrl-0 = <&uart0_pins_default>;
 };
 
+&dwc3_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_phy1_default>;
+};
+
+&dwc3_2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_phy2_default>;
+};
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
