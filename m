From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 11/14] Documentation: dt: binding: omap: am43x timer
Date: Mon, 27 May 2013 20:07:04 +0530
Message-ID: <223d90dc9eeab13d8496690d336cdf0f7d27cd22.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629Ab3E0Ohi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 10:37:38 -0400
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>

AM43x timer bindings.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/timer.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
index d02e27c..70cb398 100644
--- a/Documentation/devicetree/bindings/arm/omap/timer.txt
+++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
@@ -14,6 +14,8 @@ Required properties:
 			ti,omap5430-timer (applicable to OMAP543x devices)
 			ti,am335x-timer	(applicable to AM335x devices)
 			ti,am335x-timer-1ms (applicable to AM335x devices)
+			"ti,am4372-timer-1ms", "ti,am335x-timer-1ms" for AM43x 1ms timer
+			"ti,am4372-timer", "ti,am335x-timer" for AM43x timers other than 1ms one
 
 - reg:			Contains timer register address range (base address and
 			length).
-- 
1.7.12

