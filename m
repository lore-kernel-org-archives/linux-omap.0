From: Enrico <ebutera@users.sourceforge.net>
Subject: [PATCH] OMAP: igep0020: fix smsc911x dummy regulator id
Date: Mon, 30 Apr 2012 19:20:08 +0200
Message-ID: <1335806408-614-1-git-send-email-ebutera@users.sourceforge.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61592 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab2D3RUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 13:20:18 -0400
Received: by wgbdr13 with SMTP id dr13so746335wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 10:20:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enrico Butera <ebutera@users.berlios.de>

From: Enrico Butera <ebutera@users.berlios.de>

Using id 0 causes errors at boot:

WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
sysfs: cannot create duplicate filename '/devices/platform/reg-fixed-voltage.0'

Fix it by using a random (not-already-used) id, as suggested
by Tony Lindgren.

Signed-off-by: Enrico Butera <ebutera@users.berlios.de>
---
 arch/arm/mach-omap2/board-igep0020.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 930c0d3..1ce2ba4 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -641,7 +641,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 
 static void __init igep_init(void)
 {
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed(40, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	/* Get IGEP2 hardware revision */
-- 
1.7.5.4

