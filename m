From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] dt-bindings: power: Introduce suspend states supported properties
Date: Wed, 12 Sep 2018 09:39:32 +0530
Message-ID: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Introuduce linux generic suspend states supported properties.
It is convenient for the generic suspend path to have
the knowledge of the suspend states supported based on the
device tree properties based on which it can either be suspended
or safely bailed out of suspend if none of the suspend states
are supported.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../devicetree/bindings/power/power-states.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/power-states.txt

diff --git a/Documentation/devicetree/bindings/power/power-states.txt b/Documentation/devicetree/bindings/power/power-states.txt
new file mode 100644
index 0000000..bb80b36
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/power-states.txt
@@ -0,0 +1,22 @@
+* Generic system suspend states support
+
+Most platforms support multiple suspend states. Define system
+suspend states so that one can target appropriate low power
+states based on the SoC capabilities.
+
+linux,suspend-to-memory-supported
+
+Upon suspend to memory the system context is saved to primary memory.
+All the clocks for all the peripherals including CPU are gated.
+
+linux,suspend-power-off-supported
+
+In this case in additon to the clocks all the voltage resources are
+turned off except the ones needed to keep the primary memory
+and a wake up source that can trigger a wakeup event.
+
+linux,suspend-to-disk-supported
+
+Upon suspend to disk that system context is saved to secondary memory.
+All the clocks for all the peripherals including CPU are gated. Even
+the primary memory is turned off.
-- 
1.9.1
