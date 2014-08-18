From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] doc: dt/bindings: input: introduce palmas power button description
Date: Mon, 18 Aug 2014 15:13:29 -0500
Message-ID: <1408392810-16011-2-git-send-email-nm@ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408392810-16011-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Many palmas family of PMICs have support for interrupt based power
button. This allows the device to notify the processor of external
push button events over the shared palmas interrupt.

Document the hardware support for the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/input/ti,palmas-pwrbutton.txt         |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
new file mode 100644
index 0000000..6a89bcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
@@ -0,0 +1,32 @@
+Texas Instruments Palmas family power button module
+
+This module is part of the Palmas family of PMICs. For more details
+about the whole chip see:
+Documentation/devicetree/bindings/mfd/palmas.txt.
+
+This module provides a simple power button event via an Interrupt.
+
+Required properties:
+- compatible: should be one of the following
+   - "ti,palmas-pwrbutton": For Palmas compatible power on button
+- interrupt-parent: Parent interrupt device, must be handle of palmas node.
+- interrupts: Interrupt number of power button submodule on device.
+
+Optional Properties:
+
+- ti,palmas-long-press-seconds: Duration in seconds which the power
+  button should be kept pressed for Palmas to power off automatically.
+  NOTE: This depends on OTP support and POWERHOLD signal configuration
+  on platform.
+
+Example:
+
+&palmas {
+	palmas_pwr_button: pwrbutton {
+		compatible = "ti,palmas-pwrbutton";
+		interrupt-parent = <&tps659038>;
+		interrupts = <1 IRQ_TYPE_NONE>;
+		wakeup-source;
+		ti,palmas-long-press-seconds = <12>;
+	};
+};
-- 
1.7.9.5
