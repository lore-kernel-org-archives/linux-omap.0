From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v4 3/3] ARM: OMAP: Beagle: no gpio_wp pin connection on xM
Date: Mon, 16 Aug 2010 09:36:43 -0500
Message-ID: <1281969403-28312-3-git-send-email-robertcnelson@gmail.com>
References: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41810 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab0HPOhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 10:37:23 -0400
Received: by ywh1 with SMTP id 1so1888268ywh.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 07:37:22 -0700 (PDT)
In-Reply-To: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>

The omap3630 based BeagleBoard xM uses a MicroSD card slot with
no write protection.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 08fa68f..449a776 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -244,7 +244,9 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if ((get_omap3_beagle_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
+	if (get_omap3_beagle_rev() == OMAP3BEAGLE_BOARD_XM) {
+		mmc[0].gpio_wp = -EINVAL;
+	} else if ((get_omap3_beagle_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
 		(get_omap3_beagle_rev() == OMAP3BEAGLE_BOARD_C4)) {
 		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
-- 
1.7.0.4

