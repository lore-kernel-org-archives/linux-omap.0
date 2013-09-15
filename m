From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
Date: Sun, 15 Sep 2013 22:44:16 +0200
Message-ID: <1379277856-24571-4-git-send-email-sre@debian.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379277856-24571-1-git-send-email-sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add SSI device tree data for OMAP34xx and Nokia N900.

Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/hsi/omap_ssi.txt | 73 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n900.dts                   |  8 +++
 arch/arm/boot/dts/omap34xx.dtsi                    | 49 +++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hsi/omap_ssi.txt

diff --git a/Documentation/devicetree/bindings/hsi/omap_ssi.txt b/Documentation/devicetree/bindings/hsi/omap_ssi.txt
new file mode 100644
index 0000000..e3597eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/omap_ssi.txt
@@ -0,0 +1,73 @@
+OMAP SSI controller bindings
+
+Required properties:
+- compatible:		Should be set to the following value
+                        ti,omap3-ssi (applicable to OMAP34xx devices)
+- ti,hwmods:		Name of the hwmod associated to the controller, which
+			is "ssi".
+- reg:			Contains SSI register address range (base address and
+			length).
+- reg-names:		Contains the names of the address ranges. It's
+                        expected, that "sys" and "gdd" address ranges are
+			provided.
+- interrupts: 		Contains the interrupt information for the controller.
+- interrupt-names:      Contains the names of the interrupts. It's expected,
+			that "gdd_mpu" is provided.
+- ranges		Required as an empty node
+- #address-cells	Should be set to <1>
+- #size-cells		Should be set to <1>
+
+Each port is represented as a sub-node of the ti,omap3-ssi device.
+
+Required Port sub-node properties:
+- compatible:		Should be set to the following value
+                        ti,omap3-ssi-port (applicable to OMAP34xx devices)
+- reg:			Contains port's register address range (base address
+			and length).
+- reg-names:		Contains the names of the address ranges. It's
+                        expected, that "tx" and "rx" address ranges are
+			provided.
+- interrupt-parent	Should be a phandle for the interrupt controller
+- interrupts:		Contains the interrupt information for the port.
+- interrupt-names:	Contains the names of the interrupts. It's expected,
+			that "mpu_irq0" and "mpu_irq1" are provided.
+- ti,ssi-cawake-gpio:	Defines which GPIO pin is used to signify CAWAKE
+			events for the port. This is an optional board-specific
+			property. If it's missing the port will not be
+			enabled.
+
+Example for Nokia N900:
+
+ssi-controller@48058000 {
+	compatible = "ti,omap3-ssi";
+	ti,hwmods = "ssi";
+
+	reg = <0x48058000 0x1000>,
+	      <0x48059000 0x1000>;
+	reg-names = "sys",
+		    "gdd";
+
+	interrupts = <55>;
+	interrupt-names = "gdd_mpu";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	ssi-port@0 {
+		compatible = "ti,omap3-ssi-port";
+
+		reg = <0x4805a000 0x800>,
+		      <0x4805a800 0x800>;
+		reg-names = "tx",
+			    "rx";
+
+		interrupt-parent = <&intc>;
+		interrupts = <51>,
+			     <52>;
+		interrupt-names = "mpu_irq0",
+				  "mpu_irq1";
+
+		ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+	}
+}
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 0582356..cc4a3e2 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -186,6 +186,14 @@
 	power = <50>;
 };
 
+&ssi_port1 {
+	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+};
+
+&ssi_port2 {
+	status = "disabled";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 5355d61..393b7a7 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -25,4 +25,53 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
+
+	ocp {
+		ssi: ssi-controller@48058000 {
+			compatible = "ti,omap3-ssi";
+			ti,hwmods = "ssi";
+
+			reg = <0x48058000 0x1000>,
+			      <0x48059000 0x1000>;
+			reg-names = "sys",
+				    "gdd";
+
+			interrupts = <55>;
+			interrupt-names = "gdd_mpu";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			ssi_port1: ssi-port@0 {
+				compatible = "ti,omap3-ssi-port";
+
+				reg = <0x4805a000 0x800>,
+				      <0x4805a800 0x800>;
+				reg-names = "tx",
+					    "rx";
+
+				interrupt-parent = <&intc>;
+				interrupts = <51>,
+					     <52>;
+				interrupt-names = "mpu_irq0",
+						  "mpu_irq1";
+			};
+
+			ssi_port2: ssi-port@1 {
+				compatible = "ti,omap3-ssi-port";
+
+				reg = <0x4805b000 0x800>,
+				      <0x4805b800 0x800>;
+				reg-names = "tx",
+					    "rx";
+
+				interrupt-parent = <&intc>;
+				interrupts = <53>,
+					     <54>;
+				interrupt-names = "mpu_irq0",
+						  "mpu_irq1";
+			};
+		};
+	};
 };
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
