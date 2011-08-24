From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 10/10] documentation/dt: Add OMAP GPIO properties
Date: Wed, 24 Aug 2011 15:09:16 +0200
Message-ID: <1314191356-10963-11-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52021 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1HXNL0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 09:11:26 -0400
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Randy Dunlap <rdunlap@xenotime.net>

Add documentation for GPIO properties specific to OMAP.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>
---
 .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
new file mode 100644
index 0000000..692b1c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -0,0 +1,33 @@
+OMAP GPIO controller
+
+Required properties:
+- compatible:
+  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
+  - "ti,omap4-gpio" for OMAP4 controller
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller.
+
+OMAP specific properties:
+- hwmods: Name of the hwmod associated to the GPIO
+- id: 32 bits to identify the id (1 based index)
+- bank_width: number of pin supported by the controller (16 or 32)
+- debounce: set if the controller support the debouce funtionnality
+- bank_count: number of controller support by the SoC. This is a temporary
+  hack until the bank_count is removed from the driver.
+
+
+Example:
+
+gpio4: gpio4 {
+    compatible = "ti,omap4-gpio", "ti,omap-gpio";
+    hwmods = "gpio4";
+    id = <4>;
+    bank_width = <32>;
+    debounce;
+    no_idle_on_suspend;
+    #gpio-cells = <2>;
+    gpio-controller;
+};
+
-- 
1.7.0.4

