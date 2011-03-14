From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] omap: zoom: host should not pull up wl1271's irq line
Date: Mon, 14 Mar 2011 16:24:25 +0200
Message-ID: <1300112665-6253-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47752 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab1CNObf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 10:31:35 -0400
Received: by wwa36 with SMTP id 36so5723163wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 07:31:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>

The wl1271's irq line is completely controlled by the 1271 device, and
the host does not not need to pull it up.

While there's no functional effect, letting the host pull this line up is
just redundant, and wastes power.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/board-zoom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index e26754c..c59d07b 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -49,7 +49,7 @@ static void __init omap_zoom_init_irq(void)
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* WLAN IRQ - GPIO 162 */
-	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 	/* WLAN POWER ENABLE - GPIO 101 */
 	OMAP3_MUX(CAM_D2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	/* WLAN SDIO: MMC3 CMD */
-- 
1.7.1

