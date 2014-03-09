From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv2 6/6] Documentation: DT: omap-ssi binding documentation
Date: Sun,  9 Mar 2014 23:25:56 +0100
Message-ID: <1394403956-17297-7-git-send-email-sre@debian.org>
References: <1393199401-27197-1-git-send-email-sre@debian.org>
 <1394403956-17297-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394403956-17297-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Create device tree binding documentation for
OMAP Synchronous Serial Interface (SSI) device.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 Documentation/devicetree/bindings/hsi/omap-ssi.txt | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hsi/omap-ssi.txt

diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
new file mode 100644
index 0000000..9649582
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
@@ -0,0 +1,82 @@
+OMAP SSI controller bindings
+
+Required properties:
+- compatible:		Should include "ti,omap3-ssi".
+- reg-names:		Contains the values "sys" and "gdd".
+- reg:			Contains a register specifier for each entry in
+			reg-names.
+- interrupt-names:      Contains the value "gdd_mpu".
+- interrupts: 		Contains interrupt information for each entry in
+			interrupt-names.
+- ranges:		Represents the bus address mapping between the main
+			controller node and the child nodes below.
+- clocks:		Contains clock specifiers for each entry in
+                        clock-names.
+- clock-names:		Must include the following entries:
+  "ssi_ssr_fck": The OMAP clock of that name
+  "ssi_sst_fck": The OMAP clock of that name
+  "ssi_ick": The OMAP clock of that name
+- #address-cells:	Should be set to <1>
+- #size-cells:		Should be set to <1>
+
+Each port is represented as a sub-node of the ti,omap3-ssi device.
+
+Required Port sub-node properties:
+- compatible:		Should be set to the following value
+                        ti,omap3-ssi-port (applicable to OMAP34xx devices)
+- reg-names:		Contains the values "rx" and "tx".
+- reg:			Contains a register specifier for each entry in
+			reg-names.
+- interrupt-parent	Should be a phandle for the interrupt controller
+- interrupt-names:	Contains the values "mpu_irq0" and "mpu_irq1".
+- interrupts:		Contains interrupt information for each entry in
+			interrupt-names.
+- ti,ssi-cawake-gpio:	Defines which GPIO pin is used to signify CAWAKE
+			events for the port. This is an optional board-specific
+			property. If it's missing the port will not be
+			enabled.
+
+Example for Nokia N900:
+
+ssi-controller@48058000 {
+	compatible = "ti,omap3-ssi";
+
+	/* needed until hwmod is updated to use the compatible string */
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
+	clocks = <&ssi_ssr_fck>,
+		 <&ssi_sst_fck>,
+		 <&ssi_ick>;
+	clock-names = "ssi_ssr_fck",
+		      "ssi_sst_fck",
+		      "ssi_ick";
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
-- 
1.9.0
