From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 2/2] omap: pm: opp: twl: use DIV_ROUND_UP
Date: Tue, 20 Apr 2010 14:49:54 -0500
Message-ID: <1271792994-31816-3-git-send-email-nm@ti.com>
References: <1271792994-31816-1-git-send-email-nm@ti.com>
 <1271792994-31816-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0DTTuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 15:50:09 -0400
In-Reply-To: <1271792994-31816-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

kernel.h provides a function for DIV_ROUND_UP which should be used
instead of replicating it in code.

Cc: Ambresh K <ambresh@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 arch/arm/plat-omap/opp_twl_tps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index 468fb97..112f106 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -37,5 +37,5 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
 	/* Round up to higher voltage */
-	return (((uv + 99) / 100 - 6000) + 124) / 125;
+	return DIV_ROUND_UP(uv - 600000, 12500);
 }
-- 
1.6.3.3

