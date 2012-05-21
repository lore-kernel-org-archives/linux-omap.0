From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 12:41:17 +0300
Message-ID: <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:51656 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757425Ab2EUJla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:41:30 -0400
Received: by lbok6 with SMTP id k6so4468218lbo.18
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:41:27 -0700 (PDT)
In-Reply-To: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
remove custom PD GPIO handling for DVI output") moved TFP410 chip's
powerdown-gpio handling from the board files to the tfp410 driver. One
gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
the Beagle board file. This causes the tfp410 driver to fail to request
the gpio on Beagle, causing the driver to fail and thus the DVI output
doesn't work.

This patch removes the gpio_request_one() from the board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 8ede8d2..72ad1f6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 
+	/* DVI power down GPIO */
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
 
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-- 
1.7.9.5

