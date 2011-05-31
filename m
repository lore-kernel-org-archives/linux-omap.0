From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 2/2] omap: rx51: Don't power up speaker amplifier at bootup
Date: Tue, 31 May 2011 11:27:01 +0300
Message-ID: <1306830421-25727-2-git-send-email-jhnikula@gmail.com>
References: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42430 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab1EaI1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 04:27:00 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1571860eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 01:27:00 -0700 (PDT)
In-Reply-To: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

Speaker amplifier is accidentally powered up in early TWL gpio setup. This
causes a few mA of needless battery current consumption. Without this patch
the amplifier can be shutdown only by having one active audio playback and
shutdown cycle to speaker output.

Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
v2. Updated on top of commit bc593f5 ("arm: omap2plus: GPIO cleanup").
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 02a6587..9903667 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -583,7 +583,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 {
 	/* FIXME this gpio setup is just a placeholder for now */
 	gpio_request_one(gpio + 6, GPIOF_OUT_INIT_LOW, "backlight_pwm");
-	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_HIGH, "speaker_en");
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "speaker_en");
 
 	return 0;
 }
-- 
1.7.4.4

