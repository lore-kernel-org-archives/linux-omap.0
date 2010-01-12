From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH v3] pm: opp: twl/tps: optimize uv to vsel function
Date: Tue, 12 Jan 2010 08:39:35 -0600
Message-ID: <1263307175-7493-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab0ALOjk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jan 2010 09:39:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Romit Dasgupta <romit@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Romit Dasgupta <romit@ti.com>

For integer values x and y; int div x / y causes truncation. Current
omap_twl_uv_to_vsel function implements an equivalent of ceil which
is based on an if condition to check truncation and round up. We can
do this in a more optimal manner without the if condition. The round
up is handled by adding the round off factor prior to truncation as:
(x + (y - 1)) / y

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Nishanth Menon <nm@ti.com>

Signed-off-by: Romit Dasgupta <romit@ti.com>
---
Discussions:
v2: http://marc.info/?t=126318930800001&r=1&w=2
v1: http://marc.info/?t=126226623800006&r=1&w=2

 arch/arm/plat-omap/opp_twl_tps.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index e0db39b..468fb97 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -36,14 +36,6 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
  */
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
-	u8 vsel;
-
-	vsel = ((uv / 100) - 6000) / 125;
-
-	/* round off to higher voltage */
-	/* XXX Surely not the best way to handle this. */
-	if (uv > omap_twl_vsel_to_uv(vsel))
-		vsel++;
-
-	return vsel;
+	/* Round up to higher voltage */
+	return (((uv + 99) / 100 - 6000) + 124) / 125;
 }
-- 
1.6.3.3

