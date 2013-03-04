From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] gpio: omap: dts: Move interrupt-controller from #interrupt-cells description
Date: Mon,  4 Mar 2013 19:35:57 +0100
Message-ID: <1362422157-32196-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:53578 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214Ab3CDSgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:36:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Landley <rob@landley.net>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Jon Hunter <jon-hunter@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The binding documentation for the OMAP GPIO controller has the description
for the "#interrupt-cells" property after the "interrupt-controller"
definition. This is confusing so is better to move "interrupt-controller"
after the "#interrupt-cells" description.

Reported-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 .../devicetree/bindings/gpio/gpio-omap.txt         |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
index bff51a2..8b9914c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -10,7 +10,6 @@ Required properties:
   - second cell is used to specify optional parameters (unused)
 - gpio-controller : Marks the device node as a GPIO controller.
 - #interrupt-cells : Should be 2.
-- interrupt-controller: Mark the device node as an interrupt controller
   The first cell is the GPIO number.
   The second cell is used to specify flags:
     bits[3:0] trigger type and level flags:
@@ -18,6 +17,7 @@ Required properties:
       2 = high-to-low edge triggered.
       4 = active high level-sensitive.
       8 = active low level-sensitive.
+- interrupt-controller: Mark the device node as an interrupt controller.
 
 OMAP specific properties:
 - ti,hwmods: Name of the hwmod associated to the GPIO:
-- 
1.7.7.6

