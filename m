From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] Documentation: dt: hwmon: Update for tmp102
Date: Tue, 14 Aug 2012 21:53:32 +0530
Message-ID: <1344961412-13622-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add Documentation for tmp102 temperature sensor.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 Documentation/devicetree/bindings/hwmon/tmp102.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/tmp102.txt

diff --git a/Documentation/devicetree/bindings/hwmon/tmp102.txt b/Documentation/devicetree/bindings/hwmon/tmp102.txt
new file mode 100644
index 0000000..df1342b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/tmp102.txt
@@ -0,0 +1,11 @@
+TMP102 Temperature sensor
+
+Required properties:
+- compatible: ti,tmp102
+
+Example:
+
+tmp102@48 {
+        compatible = "ti,tmp102";
+        reg = <0x48>;
+};
-- 
1.7.1
