From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 7/7] documentation/dt: Add OMAP bindings
Date: Wed, 24 Aug 2011 12:17:20 +0200
Message-ID: <1314181040-22807-8-git-send-email-b-cousson@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35519 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab1HXKTR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 06:19:17 -0400
In-Reply-To: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Randy Dunlap <rdunlap@xenotime.net>

Add a documentation to capture the specifics OMAP bindings
needed for device-tree support.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/arm/omap/omap.txt          |   38 ++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
new file mode 100644
index 0000000..845f9f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -0,0 +1,38 @@
+* Texas Instruments OMAP
+
+OMAP is currently using a static file per SoC family to describe the
+IPs present in the SoC.
+On top of that an omap_device is created to extend the platform_device
+capabilities and to allow binding with one or several hwmods.
+The hwmods will contain all the information to build the device:
+adresse range, irq lines, dma lines, interconnect, PRCM register,
+clock domain, input clocks.
+For the moment just point to the existing hwmod, the next step will be
+to move data from hwmod to device-tree representation.
+
+
+Required properties:
+- compatible: Every devices present in OMAP SoC should be in the
+  form: "ti,XXX"
+- hwmods: list of hwmods attached to a device. Must contain at least
+  one hwmod.
+
+Optional properties:
+- no_idle_on_suspend: When present, it prevents the PM to idle the module
+  during suspend.
+
+
+Example:
+
+spinlock@1 {
+    compatible = "ti,omap-spinlock";
+    hwmods = "spinlock";
+};
+
+
+Boards:
+- OMAP4 SDP : Software Developement Board
+  compatible = "ti,omap4-sdp", "ti,omap4430"
+
+- OMAP4 PandaBoard : Low cost community board
+  compatible = "ti,omap4-panda", "ti,omap4430"
-- 
1.7.0.4

