From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 09/35] Documentation: DT: document PRCM compatible strings for dm81x SoCs
Date: Wed, 25 Feb 2015 21:04:19 +0200
Message-ID: <1424891085-10392-10-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37461 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbbBYTFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:00 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

These PRCM nodes were earlier added in patch 7800064ba5 ("ARM: dts: Add
basic dm816x device tree configuration"), but the documentation for
the same wasn't added. Fix this by adding the missing compatible strings
under the generic prcm.txt document.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/prcm.txt          |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index 79074da..68f96f8 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -29,6 +29,10 @@ Required properties:
 		"ti,dra7-prm"
 		"ti,dra7-cm-core-aon"
 		"ti,dra7-cm-core"
+		"ti,dm814-prcm"
+		"ti,dm814-scrm"
+		"ti,dm816-prcm"
+		"ti,dm816-scrm"
 - reg:		Contains PRCM module register address range
 		(base address and length)
 - clocks:	clocks for this module
-- 
1.7.9.5

