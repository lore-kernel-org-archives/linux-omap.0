From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 4/4] RX51: Fix SDRAM RFR timings calculation
Date: Mon, 26 Oct 2009 18:15:26 +0200
Message-ID: <1256573726-29800-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
 <1256573726-29800-2-git-send-email-tero.kristo@nokia.com>
 <1256573726-29800-3-git-send-email-tero.kristo@nokia.com>
 <1256573726-29800-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54269 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbZJZQai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 12:30:38 -0400
In-Reply-To: <1256573726-29800-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

sdrc_ps_to_ticks introduced some unnecessary
rounding error to SDRC_RFR value calculation.
Fixed by adding 10^3 more accuracy before
division and skipping the sdrc_ps_to_ticks call.

Problem-reported-by: Jukka S. Laitinen <jukka.s.laitinen@nokia.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/board-rx51-sdram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/board-rx51-sdram.c
index 237b898..f3b9917 100644
--- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -166,7 +166,7 @@ static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
 
 static int sdrc_timings(int id, long rate)
 {
-	u32 ticks_per_us;
+	u32 ticks_per_ms;
 	u32 rfr, l;
 	u32 actim_ctrla = 0, actim_ctrlb = 0;
 	u32 rfr_ctrl;
@@ -192,8 +192,8 @@ static int sdrc_timings(int id, long rate)
 	SDRC_SET_ONE(&actim_ctrlb,  12,  14, tCKE, l3_rate);
 	SDRC_SET_ONE(&actim_ctrlb,  16,  17, tWTR, l3_rate);
 
-	ticks_per_us = sdrc_ps_to_ticks(1000000, l3_rate);
-	rfr = rx51_timings[0].tREF * ticks_per_us / 1000;
+	ticks_per_ms = l3_rate;
+	rfr = rx51_timings[0].tREF * ticks_per_ms / 1000000;
 	if (rfr > 65535 + 50)
 		rfr = 65535;
 	else
-- 
1.5.4.3

