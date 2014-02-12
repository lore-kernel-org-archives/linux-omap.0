From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 12/12] usb: omap: dts: Update DT binding example usage
Date: Wed, 12 Feb 2014 12:18:53 +0200
Message-ID: <1392200333-28397-13-git-send-email-rogerq@ti.com>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbaBLKUU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Feb 2014 05:20:20 -0500
In-Reply-To: <1392200333-28397-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com, lee.jones@linaro.org
Cc: balbi@ti.com, nm@ti.com, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Alan Stern <stern@rowland.harvard.edu>

Remove non-compatible id from examples.

CC: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/usb/ehci-omap.txt  | 2 +-
 Documentation/devicetree/bindings/usb/ohci-omap3.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ehci-omap.txt b/Documentation/devicetree/bindings/usb/ehci-omap.txt
index 485a9a1..3dc231c 100644
--- a/Documentation/devicetree/bindings/usb/ehci-omap.txt
+++ b/Documentation/devicetree/bindings/usb/ehci-omap.txt
@@ -21,7 +21,7 @@ Documentation/devicetree/bindings/mfd/omap-usb-host.txt
 Example for OMAP4:
 
 usbhsehci: ehci@4a064c00 {
-	compatible = "ti,ehci-omap", "usb-ehci";
+	compatible = "ti,ehci-omap";
 	reg = <0x4a064c00 0x400>;
 	interrupts = <0 77 0x4>;
 };
diff --git a/Documentation/devicetree/bindings/usb/ohci-omap3.txt b/Documentation/devicetree/bindings/usb/ohci-omap3.txt
index 14ab428..ce8c47cff 100644
--- a/Documentation/devicetree/bindings/usb/ohci-omap3.txt
+++ b/Documentation/devicetree/bindings/usb/ohci-omap3.txt
@@ -9,7 +9,7 @@ Required properties:
 Example for OMAP4:
 
 usbhsohci: ohci@4a064800 {
-	compatible = "ti,ohci-omap3", "usb-ohci";
+	compatible = "ti,ohci-omap3";
 	reg = <0x4a064800 0x400>;
 	interrupts = <0 76 0x4>;
 };
-- 
1.8.3.2

