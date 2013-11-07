From: Eric Witcher <ewitcher@mindspring.com>
Subject: [RESEND][PATCH] ARM: OMAP: devicetree: fix SPI node compatible property syntax items
Date: Thu,  7 Nov 2013 08:45:38 -0500
Message-ID: <1383831938-9402-1-git-send-email-ewitcher@mindspring.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:42209 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859Ab3KHBqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 20:46:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robherring2@gmail.com, bcousson@baylibre.com, matt.porter@linaro.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Correct the SPI node compatible property items to match example code and
match current DTS usage.

Signed-off-by: Eric Witcher <ewitcher@mindspring.com>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 4c85c4c..2ba5f9c 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -2,8 +2,8 @@ OMAP2+ McSPI device
 
 Required properties:
 - compatible :
-  - "ti,omap2-spi" for OMAP2 & OMAP3.
-  - "ti,omap4-spi" for OMAP4+.
+  - "ti,omap2-mcspi" for OMAP2 & OMAP3.
+  - "ti,omap4-mcspi" for OMAP4+.
 - ti,spi-num-cs : Number of chipselect supported  by the instance.
 - ti,hwmods: Name of the hwmod associated to the McSPI
 - ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
-- 
1.7.11.7

