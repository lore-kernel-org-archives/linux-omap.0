From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP] [PATCH 1/2] omap3:pm:srf: check if pointer results with IS_ERR
Date: Tue, 16 Feb 2010 02:27:16 -0600
Message-ID: <1266308837-23262-2-git-send-email-nm@ti.com>
References: <1266308837-23262-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40682 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab0BPI1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:27:24 -0500
In-Reply-To: <1266308837-23262-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

if we dont check the pointer returns with IS_ERR, we could
continue on with an error value as a valid pointer..

Cc: Ambresh K <ambresh@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 3604a38..ecc3c68 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -177,7 +177,7 @@ static int __deprecated opp_to_freq(unsigned long *freq, enum opp_t opp_type,
 	BUG_ON(!freq || opp_type >= OPP_TYPES_MAX);
 
 	opp = opp_find_by_opp_id(opp_type, opp_id);
-	if (!opp)
+	if (IS_ERR(opp))
 		return -EINVAL;
 
 	*freq = opp_get_freq(opp);
-- 
1.6.3.3

