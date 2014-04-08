From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] ARM: OMAP2+: N900: remove omapdss init for DT boot
Date: Tue,  8 Apr 2014 22:51:18 +0200
Message-ID: <1396990278-16706-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:50223 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756975AbaDHUvX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Apr 2014 16:51:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

Do not try to initialize display for DT boot, since omapdss
is now initialized via Device Tree. Without this patch the
display subsystem does not properly come up.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Hi,

This patch should be added to 3.15-rc to make display initialization via DT
possible. Sorry for not noticing earlier, that this was missing in Tomi's
patchset.

-- Sebastian
---
 arch/arm/mach-omap2/board-rx51-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 43a90c8..9cfebc5 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -48,7 +48,7 @@ static struct omap_dss_board_info rx51_dss_board_info = {
 
 static int __init rx51_video_init(void)
 {
-	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
+	if (!machine_is_nokia_rx51())
 		return 0;
 
 	if (omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT)) {
-- 
1.9.1

