From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 3/9] pinctrl: am43xx: dt-bindings: add MUX_MODE8
Date: Thu, 19 Dec 2013 18:03:35 +0530
Message-ID: <1387456421-21379-4-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58724 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757008Ab3LSMeH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 07:34:07 -0500
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Darren Etheridge <detheridge@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

From: Darren Etheridge <detheridge@ti.com>

AM43xx devices have an extra MUX_MODE for certain pins.
Updating dt include to have MUX_MODE8 which maps to 0x8.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 include/dt-bindings/pinctrl/am43xx.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-bindings/pinctrl/am43xx.h
index eb6c366a..9c2e4f8 100644
--- a/include/dt-bindings/pinctrl/am43xx.h
+++ b/include/dt-bindings/pinctrl/am43xx.h
@@ -13,6 +13,7 @@
 #define MUX_MODE5	5
 #define MUX_MODE6	6
 #define MUX_MODE7	7
+#define MUX_MODE8	8
 
 #define PULL_DISABLE		(1 << 16)
 #define PULL_UP			(1 << 17)
-- 
1.7.9.5

