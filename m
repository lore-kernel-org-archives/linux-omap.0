From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 01/13] Documentation: add extcon devicetree bindings
Date: Mon, 14 Apr 2014 13:46:12 +0200
Message-ID: <1397475984-28001-2-git-send-email-r.baldyga@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, m.szyprowski@samsung.com, t.figa@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch adds extcon devicetree bindings. Documentation describes in general
client and provider bindings, and contains detailed desctiprion of bindings
for each extcon provider.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 .../devicetree/bindings/extcon/extcon-adc-jack.txt |   60 +++++++++++++++++++
 .../devicetree/bindings/extcon/extcon-arizona.txt  |   47 +++++++++++++++
 .../devicetree/bindings/extcon/extcon-bindings.txt |   36 +++++++++++
 .../devicetree/bindings/extcon/extcon-gpio.txt     |   63 ++++++++++++++++++++
 .../devicetree/bindings/extcon/extcon-max14577.txt |   49 +++++++++++++++
 .../devicetree/bindings/extcon/extcon-max77693.txt |   56 +++++++++++++++++
 .../devicetree/bindings/extcon/extcon-max8997.txt  |   49 +++++++++++++++
 .../devicetree/bindings/extcon/extcon-palmas.txt   |   37 ++++++++++--
 8 files changed, 393 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-adc-jack.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-bindings.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-max14577.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-max77693.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-max8997.txt

diff --git a/Documentation/devicetree/bindings/extcon/extcon-adc-jack.txt b/Documentation/devicetree/bindings/extcon/extcon-adc-jack.txt
new file mode 100644
index 0000000..6e43891
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-adc-jack.txt
@@ -0,0 +1,60 @@
+* ADC JACK Extcon Controller
+
+ADC JACK extcon controller is responsible for cable detection.
+
+Required Properties:
+
+- compatible: should be "extcon-adc-jack".
+
+- #extcon-cells: should be 1.
+
+- subnode <cables>: node describing list of cables.
+	- subnode <cable>:
+		- cable-name: name of specific cable
+		- adc-min: minimum specific cable ADC values range
+		- adc-max: maximum specific cable ADC values range
+
+Subnodes of node 'cables' describes specific cables with ADC value ranges
+associated with this cables. When measured ADC value will be between min and
+max value for specific cable, clients will be notified about connection of
+this cable. Value ranges for individual cables cannot be overlaping.
+
+Example 1: An example of a extcon controller node is listed below.
+
+	extcon: adc-jack {
+		compatible = "extcon-adc-jack";
+		#extcon-cells = <1>;
+
+		cables {
+			cable@0 {
+				cable-name = "CABLE-0";
+				adc-min = 120;
+				adc-max = 240;
+			}
+			cable@1 {
+				cable-name = "CABLE-1";
+				adc-min = 250;
+				adc-max = 400;
+			}
+			cable@2 {
+				cable-name = "CABLE-2";
+				adc-min = 500;
+				adc-max = 700;
+			};
+		};
+	};
+
+Example 2: USB controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	usb@12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+
+		extcon-cables = <&extcon 0>;
+		extcon-names = "USB";
+
+		status = "okay";
+	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
new file mode 100644
index 0000000..9af4422
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
@@ -0,0 +1,47 @@
+* Wolfson Arizona Extcon Controller
+
+The Wolfson Arizona Extcon Controller is responsible for cable
+detection.
+
+Required Properties:
+
+- compatible: should be "wlf,arizona-extcon".
+
+- #extcon-cells: should be 1.
+
+The following is the list of cables detected by the controller. Each
+cable is assigned an identifier and client nodes use this identifies
+to specify the cable which they are interested in.
+
+  Cable			ID
+  ----------------------------
+
+  Mechanical		0
+  Microphone		1
+  Headphone		2
+  Line-out		3
+
+Example 1: An example of a extcon controller node is listed below.
+
+	extcon: arizona-extcon {
+		compatible = "wlf,arizona-extcon";
+		#extcon-cells = <1>;
+	};
+
+Example 2: Audio controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	audio-controller@b0000 {
+		reg = <0xb0000 0x2210>;
+		interrupts = <19>, <20>;
+
+		extcon-cables = <&extcon 1>, <&extcon 3>;
+		extcon-names = "Microphone", "Line-out";
+
+		clocks = <&gate_clk 12>;
+		clock-names = "internal";
+
+		status = "okay";
+	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-bindings.txt b/Documentation/devicetree/bindings/extcon/extcon-bindings.txt
new file mode 100644
index 0000000..5167f69
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-bindings.txt
@@ -0,0 +1,36 @@
+Extcon controllers can be represented by any node in the device
+tree. Those nodes are designated as extcon cable providers. Extcon
+cable consumer nodes use phandle and cable specifier pair to register
+interest in specific cables.
+
+==Extcon providers==
+
+Required properties:
+#extcon-cells:	Number of cells in extcon specifier.
+		Always should be 1.
+
+For example:
+
+	extcon {
+		#extcon-cells = <1>;
+	};
+
+==Extcon consumers==
+
+Required properties:
+extcon-cables:	List of phandle and cable specifier pairs, one pair
+		for each cable.
+
+Optional properties:
+extcon-names:	List of extcon cable name strings sorted in the same
+		order as the extcon-cables property. Consumers drivers
+		will use extcon-names to match cable names with cable
+		specifiers.
+
+
+For example:
+
+	device {
+		extcon-cables = <&extcon 4>, <&extcon 7>;
+		extcon-names = "USB", "Charger";
+	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-gpio.txt
new file mode 100644
index 0000000..216cc30
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-gpio.txt
@@ -0,0 +1,63 @@
+* GPIO Extcon Controller
+
+The GPIO Extcon Controller is responsible for cable detection.
+
+Required Properties:
+
+- compatible: should be "extcon-gpio".
+
+- #extcon-cells: should be 1.
+
+- gpios: device-tree gpio specification.
+
+- gpio-controller-name: choosen controller name.
+
+- gpio-cable-name: choosen cable name.
+
+Optional Properties:
+
+- gpio-debounce: debounce time value in ms.
+
+- gpio-active-low: indicates that cable is active when gpio state is low.
+
+- gpio-check-on-resume: indicates that state should be checked on resume.
+
+The following is the list of cables detected by the controller. Each
+cable is assigned an identifier and client nodes use this identifies
+to specify the cable which they are interested in.
+
+  Cable			ID
+  ----------------------------
+
+  GPIO			0
+
+Example 1: An example of a extcon controller node is listed below.
+
+	extcon: gpio {
+		compatible = "extcon-gpio";
+		#extcon-cells = <1>;
+
+		gpios = <&gpx1 0 1>;
+
+		gpio-controller-name = "gpio-controller";
+		gpio-cable-name = "gpio-cable";
+
+		gpio-debounce = 15;
+		gpio-active-low;
+		gpio-check-on-resume;
+	};
+
+Example 2: USB controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	usb@12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+
+		extcon-cables = <&extcon 0>;
+		extcon-names = "USB-HOST";
+
+		status = "okay";
+	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-max14577.txt b/Documentation/devicetree/bindings/extcon/extcon-max14577.txt
new file mode 100644
index 0000000..a2b9e9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-max14577.txt
@@ -0,0 +1,49 @@
+* Maxim MAX14577 MUIC Extcon Controller
+
+The MUIC part of MAX14577 IC is responsible for cable detection.
+
+Required Properties:
+
+- compatible: should be "maxim,max14577-muic".
+
+- #extcon-cells: should be 1.
+
+The following is the list of cables detected by the controller. Each
+cable is assigned an identifier and client nodes use this identifies
+to specify the cable which they are interested in.
+
+  Cable			ID
+  ----------------------------
+
+  USB			0
+  TA			1
+  Fast-charger		2
+  Slow-charger		3
+  Charge-downstream	4
+  JIG-USB-ON		5
+  JIG-USB-OFF		6
+  JIG-UART-OFF		7
+  JIG-UART-ON		8
+
+Example 1: An example of a extcon controller node is listed below.
+
+	extcon: max14577-muic {
+		compatible = "maxim,max14577-muic";
+		#extcon-cells = <1>;
+	};
+
+Example 2: USB controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	usb@12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+
+		extcon-cables = <&extcon 0>, <&extcon 1>;
+		extcon-names = "USB", "USB-HOST";
+
+		status = "okay";
+	};
+
diff --git a/Documentation/devicetree/bindings/extcon/extcon-max77693.txt b/Documentation/devicetree/bindings/extcon/extcon-max77693.txt
new file mode 100644
index 0000000..ad6fe05
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-max77693.txt
@@ -0,0 +1,56 @@
+* Maxim MAX77693 MUIC Extcon Controller
+
+The MUIC part of MAX77693 IC is responsible for cable detection.
+
+Required Properties:
+
+- compatible: should be "maxim,max77693-muic".
+
+- #extcon-cells: should be 1.
+
+The following is the list of cables detected by the controller. Each
+cable is assigned an identifier and client nodes use this identifies
+to specify the cable which they are interested in.
+
+  Cable			ID
+  ----------------------------
+
+  USB			0
+  USB-Host		1
+  TA			2
+  Fast-charger		3
+  Slow-charger		4
+  Charge-downstream	5
+  MHL			6
+  MHL_TA		7
+  JIG-USB-ON		8
+  JIG-USB-OFF		9
+  JIG-UART-OFF		10
+  Dock-Car		11
+  Dock-Smart		12
+  Dock-Desk		13
+  Dock-Audio		14
+  Audio-video-load	15
+
+Example 1: An example of a extcon controller node is listed below.
+
+	extcon: max77693-muic {
+		compatible = "maxim,max77693-muic";
+		#extcon-cells = <1>;
+	};
+
+Example 2: USB controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	usb@12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+
+		extcon-cables = <&extcon 0>, <&extcon 1>;
+		extcon-names = "USB", "USB-HOST";
+
+		status = "okay";
+	};
+
diff --git a/Documentation/devicetree/bindings/extcon/extcon-max8997.txt b/Documentation/devicetree/bindings/extcon/extcon-max8997.txt
new file mode 100644
index 0000000..4ca7c5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-max8997.txt
@@ -0,0 +1,49 @@
+* Maxim MAX8997 MUIC Extcon Controller
+
+The MUIC part of MAX8997 IC is responsible for cable detection.
+
+Required Properties:
+
+- compatible: should be "maxim,max8997-muic".
+
+- #extcon-cells: should be 1.
+
+The following is the list of cables detected by the controller. Each
+cable is assigned an identifier and client nodes use this identifies
+to specify the cable which they are interested in.
+
+  Cable			ID
+  ----------------------------
+
+  USB			0
+  USB-Host		1
+  TA			2
+  Fast-charger		3
+  Slow-charger		4
+  Charge-downstream	5
+  MHL			6
+  Dock-Desk		7
+  Dock-Card		8
+  JIG			9
+
+Example 1: An example of a extcon controller node is listed below.
+
+	extcon: max8997-muic {
+		compatible = "maxim,max8997-muic";
+		#extcon-cells = <1>;
+	};
+
+Example 2: USB controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	usb@12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+
+		extcon-cables = <&extcon 0>, <&extcon 1>;
+		extcon-names = "USB", "USB-HOST";
+
+		status = "okay";
+	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
index 45414bb..35adcee 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
@@ -8,12 +8,41 @@ Required Properties:
    * "ti,palmas-usb" (DEPRECATED - use "ti,palmas-usb-vid").
    * "ti,twl6035-usb" (DEPRECATED - use "ti,twl6035-usb-vid").
 
+- #extcon-cells: should be 1.
+
 Optional Properties:
  - ti,wakeup : To enable the wakeup comparator in probe
  - ti,enable-id-detection: Perform ID detection.
  - ti,enable-vbus-detection: Perform VBUS detection.
 
-palmas-usb {
-       compatible = "ti,twl6035-usb", "ti,palmas-usb";
-       ti,wakeup;
-};
+The following is the list of cables detected by the controller. Each
+cable is assigned an identifier and client nodes use this identifies
+to specify the cable which they are interested in.
+
+  Cable                 ID
+  ----------------------------
+  USB			0
+  USB-HOST		1
+
+Example 1: An example of a extcon controller node is listed below.
+
+	palmas-usb {
+		compatible = "ti,twl6035-usb", "ti,palmas-usb";
+		#extcon-cells = <1>;
+		ti,wakeup;
+	};
+
+Example 2: USB controller node that uses cable from the extcon
+	   controller. Refer to the standard extcon bindings for
+	   information about 'extcon-cables' and 'extcon-names'
+	   property.
+
+	usb@12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+
+		extcon-cables = <&extcon 0>, <&extcon 1>;
+		extcon-names = "USB", "USB-HOST";
+
+		status = "okay";
+	};
-- 
1.7.9.5
