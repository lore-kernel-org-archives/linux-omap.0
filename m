From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] ARM: OMAP3: igep0020: default boot status LED to On instead of Heartbeat
Date: Sat, 24 Nov 2012 09:29:31 +0100
Message-ID: <1353745771-29983-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42273 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2KXI3r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Nov 2012 03:29:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 board uses an green GPIO LED to inform the user
that the kernel could boot.

The green status GPIO LED was default to Heartbeat but On
is better to signal that is running correctly.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/board-igep0020.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0f24cb8..e526228 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -313,7 +313,7 @@ static struct gpio_led igep_gpio_leds[] = {
 	},
 	[3] = {
 		.name			= "gpio-led:green:d1",
-		.default_trigger	= "heartbeat",
+		.default_trigger	= "default-on",
 		.gpio			= -EINVAL, /* gets replaced */
 		.active_low		= 1,
 	},
-- 
1.7.7.6

