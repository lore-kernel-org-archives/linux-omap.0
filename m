From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 3/4] ARM: OMAP: rx51: DT boot: disable legacy dss init
Date: Fri, 13 Dec 2013 19:17:29 +0100
Message-ID: <1386958650-2404-4-git-send-email-sre@debian.org>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:59923 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab3LMSSP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 13:18:15 -0500
In-Reply-To: <1386958650-2404-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This disables legacy initialization of the
omapdss, if the N900 is booted via DT.

Signed-off-by: Sebastian Reichel <sre@debian.org>
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
1.8.5.1

