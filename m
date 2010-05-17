From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 1/2] omap: opp: make opp_get_opp_id robust
Date: Mon, 17 May 2010 15:11:21 -0500
Message-ID: <1274127082-16288-2-git-send-email-nm@ti.com>
References: <1274127082-16288-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58096 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0EQUL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 16:11:57 -0400
In-Reply-To: <1274127082-16288-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Tony Lindgren <tony@atomide.com>, Vishwanath BS <vishwanath.bs@ti.com>

opp_get_opp_id should handle the error cases that might hit it. check
parameters before using it

Signed-off-by: Nishanth Menon <nm@ti.com>

Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
---
Note: even though this is a deprecated function, it should be robust

 arch/arm/plat-omap/opp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 229960d..0b61325 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -101,6 +101,10 @@ struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_type,
 
 u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
 {
+	if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
+		pr_err("%s: Invalid parameter being passed\n", __func__);
+		return 0;
+	}
 	return opp->opp_id;
 }
 
-- 
1.6.3.3

