From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2: N800: don't try to initialize OneNAND twice
Date: Fri, 24 Jul 2009 19:24:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907241922450.2700@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57257 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbZGYBY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 21:24:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Valo <kalle.valo@iki.fi>


board-n800.c calls board_onenand_init() twice.  The second time fails 
during boot with:

   kobject (c031e048): tried to init an initialized object,
   something is seriously wrong.

with backtrace, etc.  board_onenand_init() should not be called twice.

Patch tested on N800.

Problem originally found by Kalle Valo <kalle.valo@iki.fi>

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kalle Valo <kalle.valo@iki.fi>
---
 arch/arm/mach-omap2/board-n800.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index fee6c62..bea182d 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -566,7 +566,6 @@ static void __init nokia_n800_init(void)
 
 	n800_ts_set_config();
 	tea5761_dev_init();
-	board_onenand_init();
 }
 
 void __init nokia_n800_map_io(void)
-- 
1.6.3.3.334.g916e1

