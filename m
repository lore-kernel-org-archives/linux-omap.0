From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 3/4] Documentation: dt: add bindings for TI Wakeup M3 processor
Date: Fri, 22 May 2015 15:45:29 -0500
Message-ID: <1432327530-48032-4-git-send-email-d-gerlach@ti.com>
References: <1432327530-48032-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432327530-48032-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings document for the TI Wakeup M3 remote
processor devices on AM33xx and AM43xx SoCs. These devices are used
to offload low-level power management functionality, and are handled
by the wkup_m3 remoteproc driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
v3->v4: No changes to patch, just added Tony's Ack.

 .../bindings/remoteproc/wkup_m3_rproc.txt          | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt b/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
new file mode 100644
index 0000000..3a70073
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
@@ -0,0 +1,52 @@
+TI Wakeup M3 Remoteproc Driver
+==============================
+
+The TI AM33xx and AM43xx family of devices use a small Cortex M3 co-processor
+(commonly referred to as Wakeup M3 or CM3) to help with various low power tasks
+that cannot be controlled from the MPU. This CM3 processor requires a firmware
+binary to accomplish this. The wkup_m3 remoteproc driver handles the loading of
+the firmware and booting of the CM3.
+
+Wkup M3 Device Node:
+====================
+A wkup_m3 device node is used to represent the Wakeup M3 processor instance
+within the SoC. It is added as a child node of the parent interconnect bus
+(l4_wkup) through which it is accessible to the MPU.
+
+Required properties:
+--------------------
+- compatible:		Should be one of,
+				"ti,am3352-wkup-m3" for AM33xx SoCs
+				"ti,am4372-wkup-m3" for AM43xx SoCs
+- reg:			Should contain the address ranges for the two internal
+			memory regions, UMEM and DMEM. The parent node should
+			provide an appropriate ranges property for properly
+			translating these into bus addresses.
+- reg-names:		Contains the corresponding names for the two memory
+			regions. These should be named "umem" & "dmem".
+- ti,hwmods:		Name of the hwmod associated with the wkupm3 device.
+- ti,pm-firmware:	Name of firmware file to be used for loading and
+			booting the wkup_m3 remote processor.
+
+Example:
+--------
+/* AM33xx */
+ocp {
+	 l4_wkup: l4_wkup@44c00000 {
+		compatible = "am335-l4-wkup", "simple-bus";
+		ranges = <0 0x44c00000 0x400000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		wkup_m3: wkup_m3@100000 {
+			compatible = "ti,am3352-wkup-m3";
+			reg = <0x100000 0x4000>,
+			      <0x180000 0x2000>;
+			reg-names = "umem", "dmem";
+			ti,hwmods = "wkup_m3";
+			ti,pm-firmware = "am335x-pm-firmware.elf";
+		};
+	};
+
+	...
+};
-- 
2.4.1
