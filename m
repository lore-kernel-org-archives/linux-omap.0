From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 6/6] ARM: dts: omap4-var-som: fix bus-width
Date: Mon, 21 Oct 2013 00:19:59 +0530
Message-ID: <1382294999-18790-7-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
 <1382294999-18790-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34733 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab3JTSuj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Oct 2013 14:50:39 -0400
In-Reply-To: <1382294999-18790-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, uri.y@variscite.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

ti,bus-width does not exist, use generic bus-width binding

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap4-var-som.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index b25b9ad..2ae8608 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -75,7 +75,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc>;
-	ti,bus-width = <8>;
+	bus-width = <8>;
 	non-removable;
 };
 
-- 
1.7.5.4

