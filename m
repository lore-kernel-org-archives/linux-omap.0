From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH] OMAP3 DSS: Fixed FIFO buffer register field sizes
Date: Wed, 22 Oct 2008 09:47:06 +0300
Message-ID: <1224658026-4334-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52414 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYJVGq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 02:46:26 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9M6k8KB009201
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 09:46:23 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

The size status field in DISPC_[GFX | VID1 | VID2]_FIFO_SIZE_STATUS
register is 11 bits wide in OMAP3, but only 9 bits were read. Similarly,
the threshold field in DISPC_[GFX | VID1 | VID2]_FIFO_THRESHOLD register
is 12 bits wide, while only 9 bits were written in it.

This patch extends the bit field sizes used in setup_plane_fifo to
correspond to ones in OMAP3. In OMAP2 the extra bits are reserved, so no
harm should come from extending the bit fields.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 drivers/video/omap/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index beda40b..c140c21 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -290,7 +290,7 @@ static void setup_plane_fifo(int plane, int ext_mode)
 	BUG_ON(plane > 2);
 
 	l = dispc_read_reg(fsz_reg[plane]);
-	l &= FLD_MASK(0, 9);
+	l &= FLD_MASK(0, 11);
 	if (ext_mode) {
 		low = l * 3 / 4;
 		high = l;
@@ -298,7 +298,7 @@ static void setup_plane_fifo(int plane, int ext_mode)
 		low = l / 4;
 		high = l * 3 / 4;
 	}
-	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 9) | FLD_MASK(0, 9),
+	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 12) | FLD_MASK(0, 12),
 			(high << 16) | low);
 }
 
-- 
1.5.4.3

