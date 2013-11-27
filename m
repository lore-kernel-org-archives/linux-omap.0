From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 3/5] pinctrl: am43xx: dt-bindings: add MUX_MODE8
Date: Wed, 27 Nov 2013 13:00:45 +0530
Message-ID: <1385537447-6922-4-git-send-email-sourav.poddar@ti.com>
References: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49425 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3K0HbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 02:31:09 -0500
In-Reply-To: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, Darren Etheridge <detheridge@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

From: Darren Etheridge <detheridge@ti.com>

AM43xx devices have an extra MUX_MODE for certain pins.
Updating dt include to have MUX_MODE8 which maps to 0x8.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 include/dt-bindings/pinctrl/am43xx.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-bindings/pinctrl/am43xx.h
index eb6c366..9c2e4f8 100644
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
1.7.1

