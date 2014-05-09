From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/5] Doc/DT: hdmi-connector: add HPD GPIO documentation
Date: Fri, 9 May 2014 15:32:07 +0300
Message-ID: <1399638727-23254-5-git-send-email-tomi.valkeinen@ti.com>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbaEIMcd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:32:33 -0400
In-Reply-To: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add binding documentation for HDMI connector's HPD GPIO.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/video/hdmi-connector.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/video/hdmi-connector.txt b/Documentation/devicetree/bindings/video/hdmi-connector.txt
index ccccc19e2573..acd5668b1ce1 100644
--- a/Documentation/devicetree/bindings/video/hdmi-connector.txt
+++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
@@ -7,6 +7,7 @@ Required properties:
 
 Optional properties:
 - label: a symbolic name for the connector
+- hpd-gpios: HPD GPIO number
 
 Required nodes:
 - Video port for HDMI input
-- 
1.9.1

