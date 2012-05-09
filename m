From: Enrico Butera <ebutera@users.sourceforge.net>
Subject: [PATCH v2] OMAP: igep0020: fix smsc911x dummy regulator id
Date: Wed,  9 May 2012 11:27:59 +0200
Message-ID: <1336555679-15676-1-git-send-email-ebutera@users.sourceforge.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40330 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2EIJ27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 05:28:59 -0400
Received: by wgbds11 with SMTP id ds11so1430908wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 02:28:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, Enrico Butera <ebutera@users.berlios.de>

From: Enrico Butera <ebutera@users.berlios.de>

id 0 is already used and causes errors at boot:

WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
sysfs: cannot create duplicate filename '/devices/platform/reg-fixed-voltage.0'

Fix it by using the next available one (id=1).

Signed-off-by: Enrico Butera <ebutera@users.berlios.de>
---
 arch/arm/mach-omap2/board-igep0020.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 930c0d3..740cee9 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -641,7 +641,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 
 static void __init igep_init(void)
 {
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed(1, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	/* Get IGEP2 hardware revision */
-- 
1.7.5.4

