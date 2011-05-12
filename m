From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] omap: rx51: Don't power up speaker amplifier at bootup
Date: Thu, 12 May 2011 14:30:58 +0300
Message-ID: <1305199858-32643-2-git-send-email-jhnikula@gmail.com>
References: <1305199858-32643-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42821 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab1ELLaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 07:30:07 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so389368ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 04:30:06 -0700 (PDT)
In-Reply-To: <1305199858-32643-1-git-send-email-jhnikula@gmail.com>
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
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8242e99..0374562 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -561,7 +561,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	gpio_request(gpio + 6, "backlight_pwm");
 	gpio_direction_output(gpio + 6, 0);
 	gpio_request(gpio + 7, "speaker_en");
-	gpio_direction_output(gpio + 7, 1);
+	gpio_direction_output(gpio + 7, 0);
 
 	return 0;
 }
-- 
1.7.4.4

