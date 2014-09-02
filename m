From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] video: fix composite video connector compatible string
Date: Tue, 2 Sep 2014 10:35:46 +0300
Message-ID: <1409643346-8656-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbaIBHf7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 03:35:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The quite-recently-added analog-tv-connector bindings say that the
compatible string for composite video connector is
"composite-connector". That string is also used in the omap3-n900.dts
file. However, the connector driver uses "composite-video-connector", so
this has never worked.

While changing the driver's compatible string to "composite-connector"
would be safer, as published DT bindings should not be changed, I'd
rather fix the bindings in this case for two reasons:

* composite-connector is a bit too generic name, as it doesn't even hint
  at video.
* it's clear that this has never worked, which means no one has used
  those bindings, which should make it safe to change this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/video/analog-tv-connector.txt | 4 ++--
 arch/arm/boot/dts/omap3-n900.dts                                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/analog-tv-connector.txt b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
index 0218fcdc1299..0c0970c210ab 100644
--- a/Documentation/devicetree/bindings/video/analog-tv-connector.txt
+++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
@@ -2,7 +2,7 @@ Analog TV Connector
 ===================
 
 Required properties:
-- compatible: "composite-connector" or "svideo-connector"
+- compatible: "composite-video-connector" or "svideo-connector"
 
 Optional properties:
 - label: a symbolic name for the connector
@@ -14,7 +14,7 @@ Example
 -------
 
 tv: connector {
-	compatible = "composite-connector";
+	compatible = "composite-video-connector";
 	label = "tv";
 
 	port {
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 1fe45d1f75ec..4361777a08d8 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -93,7 +93,7 @@
 	};
 
 	tv: connector {
-		compatible = "composite-connector";
+		compatible = "composite-video-connector";
 		label = "tv";
 
 		port {
-- 
1.9.1

