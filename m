From: Romit Dasgupta <romit@ti.com>
Subject: [PM-WIP-OPP] [PATCH] cleaner ceil function for uv to vsel
 conversion
Date: Mon, 11 Jan 2010 11:23:38 +0530
Message-ID: <1263189218.16324.3.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50330 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab0AKFxr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 00:53:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

Cleaner ceil function.
Signed-off-by: Romit Dasgupta <romit@ti.com>
---
diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index e0db39b..1caa414 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -36,14 +36,7 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
  */
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
-	u8 vsel;
 
-	vsel = ((uv / 100) - 6000) / 125;
+	return (((uv + 99) / 100 - 6000) + 124) / 125;
 
-	/* round off to higher voltage */
-	/* XXX Surely not the best way to handle this. */
-	if (uv > omap_twl_vsel_to_uv(vsel))
-		vsel++;
-
-	return vsel;
 }


