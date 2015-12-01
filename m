From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 07/14] ARM: dts: am437x: cm-t43: add USB support
Date: Tue,  1 Dec 2015 15:55:02 +0200
Message-ID: <1448978109-5614-8-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448978109-5614-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add USB support for CompuLab sbc-t43 single board computer,
defaulting to host mode.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
Changes in V2:
	- No changes.

 arch/arm/boot/dts/am437x-cm-t43.dts  | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts | 22 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index fd97a89..a2893c6 100644
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
index 6ca22b7..3fc824a 100644
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
@@ -54,3 +66,13 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_default>;
 };
+
+&dwc3_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_phy1_default>;
+};
+
+&dwc3_2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_phy2_default>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
