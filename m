From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 1/2] ARM: dts: doc: Document missing binding for omap5-mpu
Date: Fri, 8 Nov 2013 16:08:48 +0530
Message-ID: <1383907129-7325-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, santosh.shilimkar@ti.com, r.sricharan@ti.com
List-Id: linux-omap@vger.kernel.org

The binding and support for omap5-mpu which has a cortex-a15
smp core, gic and integrated L2 cache has been existing for sometime.
So Documenting the missing binding here.

Cc: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/mpu.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/mpu.txt b/Documentation/devicetree/bindings/arm/omap/mpu.txt
index 1a5a42c..83f405b 100644
--- a/Documentation/devicetree/bindings/arm/omap/mpu.txt
+++ b/Documentation/devicetree/bindings/arm/omap/mpu.txt
@@ -7,10 +7,18 @@ The MPU contain CPUs, GIC, L2 cache and a local PRCM.
 Required properties:
 - compatible : Should be "ti,omap3-mpu" for OMAP3
                Should be "ti,omap4-mpu" for OMAP4
+	       Should be "ti,omap5-mpu" for OMAP5
 - ti,hwmods: "mpu"
 
 Examples:
 
+- For an OMAP5 SMP system:
+
+mpu {
+    compatible = "ti,omap5-mpu";
+    ti,hwmods = "mpu"
+};
+
 - For an OMAP4 SMP system:
 
 mpu {
-- 
1.7.9.5

