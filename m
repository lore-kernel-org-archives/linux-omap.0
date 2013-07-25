From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: rx51: change musb mode to OTG
Date: Thu, 25 Jul 2013 21:15:02 +0300
Message-ID: <1374776102-12120-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:51398 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab3GYSPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jul 2013 14:15:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Peripheral-only mode got broken in v3.11-rc1 because of unknown reasons.
Change the mode to OTG, in practice that should work equally well even
when/if the regression gets fixed.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-rx51.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index d2ea68e..773510556 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -85,7 +85,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_PERIPHERAL,
+	.mode			= MUSB_OTG,
 	.power			= 0,
 };
 
-- 
1.8.3.2

