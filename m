From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 05/10] documentation/dt: Add mpu, dsp and iva bindings
Date: Wed, 24 Aug 2011 15:09:11 +0200
Message-ID: <1314191356-10963-6-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51994 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab1HXNLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 09:11:16 -0400
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Randy Dunlap <rdunlap@xenotime.net>

Add documentation for the OMAP4 processors bindings.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 ++++++++
 Documentation/devicetree/bindings/arm/omap/iva.txt |   18 ++++++++++
 Documentation/devicetree/bindings/arm/omap/mpu.txt |   35 ++++++++++++++++++++
 3 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dsp.txt b/Documentation/devicetree/bindings/arm/omap/dsp.txt
new file mode 100644
index 0000000..8fcd82c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dsp.txt
@@ -0,0 +1,14 @@
+* TI - DSP (Digital Signal Processor)
+
+TI DSP included in OMAP SoC
+
+Required properties:
+- compatible : Should be "ti,c64" for OMAP3 & 4
+- hwmods: "dsp"
+
+Examples:
+
+dsp {
+    compatible = "ti,omap4-c64", "ti,c64";
+    hwmods = "dsp";
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/iva.txt b/Documentation/devicetree/bindings/arm/omap/iva.txt
new file mode 100644
index 0000000..f428e88
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/iva.txt
@@ -0,0 +1,18 @@
+* TI - IVA (Imaging and Video Accelerator) subsystem
+
+The IVA contain various audio, video or imaging HW accelerator
+depending of the version.
+
+Required properties:
+- compatible : Should be:
+  - "ti,ivahd", "ti,iva" for OMAP4
+  - "ti,iva2", "ti,iva" for OMAP3
+  - "ti,iva1", "ti,iva" for OMAP2
+- hwmods: "iva"
+
+Examples:
+
+iva {
+    compatible = "ti,ivahd", "ti,iva";
+    hwmods = "iva";
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/mpu.txt b/Documentation/devicetree/bindings/arm/omap/mpu.txt
new file mode 100644
index 0000000..eadab5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/mpu.txt
@@ -0,0 +1,35 @@
+* TI - MPU (Main Processor Unit) subsystem
+
+The MPU subsystem contain one or several ARM cores
+depending of the version.
+The MPU contain CPUs, GIC, L2 cache and a local PRCM.
+
+Required properties:
+- compatible : Should be "ti,omap4-mpu" for OMAP4
+- hwmods: "mpu"
+
+Examples:
+
+- For an OMAP4 SMP system:
+
+mpu {
+    compatible = "ti,omap4-mpu";
+    hwmods = "mpu";
+    cpu@0 {
+        compatible = "arm,cortex-a9";
+    };
+    cpu@1 {
+        compatible = "arm,cortex-a9";
+    };
+};
+
+
+- For an OMAP3 monocore system:
+
+mpu {
+    compatible = "ti,omap3-mpu";
+    hwmods = "mpu";
+    cpu@0 {
+        compatible = "arm,cortex-a8";
+    };
+};
-- 
1.7.0.4

