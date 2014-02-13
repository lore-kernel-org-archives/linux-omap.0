From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 4/4] Documentation: dt: OMAP: Update Overo/Tobi
Date: Thu, 13 Feb 2014 11:25:16 +0100
Message-ID: <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:46963 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbaBMKZh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 05:25:37 -0500
In-Reply-To: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Update the compatible string for Overo/Tobi to reflect the latest
changes.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 34dc40c..af9b4a0 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -91,7 +91,7 @@ Boards:
   compatible = "ti,omap3-beagle", "ti,omap3"
 
 - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
-  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
+  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
 
 - OMAP4 SDP : Software Development Board
   compatible = "ti,omap4-sdp", "ti,omap4430"
-- 
1.8.1.2

