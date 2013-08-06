From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2] ARM: OMAP: rx51: change musb mode to OTG
Date: Tue,  6 Aug 2013 20:06:16 +0300
Message-ID: <1375808776-14975-3-git-send-email-aaro.koskinen@iki.fi>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:48693 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082Ab3HFRG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 13:06:28 -0400
In-Reply-To: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
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

