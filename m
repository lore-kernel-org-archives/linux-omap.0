From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 1/10] OPP layer and additional cleanups.
Date: Thu, 31 Dec 2009 18:59:05 +0530
Message-ID: <1262266145.20175.177.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbZLaN3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Dec 2009 08:29:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Cleaner way to take care of the precision loss during integer division.


diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index e0db39b..43dee2d 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -36,14 +36,7 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
  */
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
-	u8 vsel;
+	/* Takes care of precision loss due to integer division */
+	return (((uv + 99) / 100 - 6000) + 124) / 125;
 
-	vsel = ((uv / 100) - 6000) / 125;
-
-	/* round off to higher voltage */
-	/* XXX Surely not the best way to handle this. */
-	if (uv > omap_twl_vsel_to_uv(vsel))
-		vsel++;
-
-	return vsel;
 }


