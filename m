From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 2/3] Documentation: dt: add ti,am3353-wkup-m3 bindings
Date: Wed, 4 Mar 2015 21:53:59 -0600
Message-ID: <1425527640-2690-3-git-send-email-d-gerlach@ti.com>
References: <1425527640-2690-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425527640-2690-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings document for ti,am3353-wkup-m3 which is
used by the wkup_m3_rproc driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../bindings/remoteproc/wkup_m3_rproc.txt          | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt b/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
new file mode 100644
index 0000000..995af3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
@@ -0,0 +1,46 @@
+Wakeup M3 Remoteproc Driver
+===========================
+
+TI AMx3 family of devices use a Cortex M3 co-processor to help with various
+low power tasks that cannot be controlled from the MPU. The CM3 requires
+a firmware binary to accomplish this. The wkup_m3 remoteproc driver handles
+the loading of the firmware and booting of the CM3.
+
+Wkup M3 Device Node:
+====================
+A wkup_m3 device node is used to represent a wakeup M3 IP instance within
+a SoC.
+
+Required properties:
+--------------------
+- compatible:		Should be:
+				"ti,am3353-wkup-m3" for AM33xx SoCs
+				"ti,am4372-wkup-m3" for AM43xx SoCs
+- reg:			Contains the wkup_m3 register address ranges for
+			umem and dmem, from the devices address space.
+			NOTE: Parent node must contains ranges specifying
+			      mapping from bus address space to device
+			      address space.
+- ti,hwmods:		Name of the hwmod associated with the mailbox
+- ti,pm-firmware:	Name of firmware file to load for remoteproc.
+
+Example:
+--------
+/* AM33xx */
+soc {
+        compatible = "ti,omap-infra";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0     0x44d00000 0x4000>,
+                 <0x80000 0x44d80000 0x2000>;
+
+	...
+
+	wkup_m3: wkup_m3@44d00000 {
+		compatible = "ti,am3353-wkup-m3";
+		reg = <0x0     0x4000	/* M3 UMEM */
+		       0x80000 0x2000>;	/* M3 DMEM */
+		ti,hwmods = "wkup_m3";
+		ti,pm-firmware = "am335x-pm-firmware.elf";
+	};
+};
-- 
2.3.0
