From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: OMAP: Beagle: support MMC gpio_wp differences on xM
Date: Tue, 10 Aug 2010 09:40:16 -0500
Message-ID: <1281451216-23725-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47162 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab0HJOkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 10:40:24 -0400
Received: by gwb20 with SMTP id 20so3737991gwb.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 07:40:24 -0700 (PDT)
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
index 87969c7..15929be 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -185,7 +185,9 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+	if (cpu_is_omap3630()) {
+		mmc[0].gpio_wp = -EINVAL;
+	} else if (system_rev >= 0x20 && system_rev <= 0x34301000) {
 		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
 	} else {
-- 
1.7.0.4

