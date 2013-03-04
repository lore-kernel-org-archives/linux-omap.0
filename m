From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 1/1] gpio: omap: dts: Move interrupt-controller from #interrupt-cells description
Date: Mon,  4 Mar 2013 21:56:37 +0100
Message-ID: <1362430597-5855-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:53723 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab3CDU6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 15:58:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Landley <rob@landley.net>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Jon Hunter <jon-hunter@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The binding documentation for the OMAP GPIO controller has the description
for the "#interrupt-cells" property after the "interrupt-controller".
This is confusing so is better to move the "interrupt-controller" after
"#interrupt-cells" description.

While being there, change the properties order to be consistent with
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
Documentation/devicetree/bindings/gpio/gpio.txt.

Reported-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Acked-by: Jon Hunter <jon-hunter@ti.com>
---

Changes since v1:
  - Change the properties order to be consistent with the rest of the
    DT bindings docs suggested by Jon Hunter.

 .../devicetree/bindings/gpio/gpio-omap.txt         |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
index bff51a2..a56e3a5 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -5,12 +5,12 @@ Required properties:
   - "ti,omap2-gpio" for OMAP2 controllers
   - "ti,omap3-gpio" for OMAP3 controllers
   - "ti,omap4-gpio" for OMAP4 controllers
+- gpio-controller : Marks the device node as a GPIO controller.
 - #gpio-cells : Should be two.
   - first cell is the pin number
   - second cell is used to specify optional parameters (unused)
-- gpio-controller : Marks the device node as a GPIO controller.
+- interrupt-controller: Mark the device node as an interrupt controller.
 - #interrupt-cells : Should be 2.
-- interrupt-controller: Mark the device node as an interrupt controller
   The first cell is the GPIO number.
   The second cell is used to specify flags:
     bits[3:0] trigger type and level flags:
@@ -29,8 +29,8 @@ Example:
 gpio4: gpio4 {
     compatible = "ti,omap4-gpio";
     ti,hwmods = "gpio4";
-    #gpio-cells = <2>;
     gpio-controller;
-    #interrupt-cells = <2>;
+    #gpio-cells = <2>;
     interrupt-controller;
+    #interrupt-cells = <2>;
 };
-- 
1.7.7.6

