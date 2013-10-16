From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 6/6] ARM: dts: omap4-var-some: fix bus-width
Date: Wed, 16 Oct 2013 20:48:27 +0530
Message-ID: <1381936707-10336-7-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760004Ab3JPPT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Oct 2013 11:19:28 -0400
In-Reply-To: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Balaji T K <balajitk@ti.com>

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

