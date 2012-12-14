From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] ARM: OMAP3: igep0020: simplify GPIO LEDs dependencies
Date: Fri, 14 Dec 2012 18:17:08 +0100
Message-ID: <1355505428-24302-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:59080 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab2LNRRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 12:17:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Matthias Brugger <matthias.bgg@googlemail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 board has two user GPIO LEDs and one of them is
default to "on" to tell the user that the board booted correctly.

But to use these LEDs the config options CONFIG_LEDS_GPIO,
CONFIG_LEDS_TRIGGERS and CONFIG_LEDS_TRIGGER_DEFAULT_ON have to
be enabled.

Since only the default-on and default-off triggers were used
anyway, it is better to just use .default_state instead of
.default_trigger and not depend on CONFIG_LEDS_TRIGGER_*

Also, this is consistent with IGEPv2 Device Tree that uses
default-state instead of linux,default-trigger for the leds
device nodes. The LED names also have been updated to use the
same names used on omap3-igep0020.dtb.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/board-igep0020.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0f24cb8..1921541 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -300,20 +300,20 @@ static struct omap2_hsmmc_info mmc[] = {
 
 static struct gpio_led igep_gpio_leds[] = {
 	[0] = {
-		.name			= "gpio-led:red:d0",
-		.default_trigger	= "default-off"
+		.name			= "omap3:red:user0",
+		.default_state		= 0,
 	},
 	[1] = {
-		.name			= "gpio-led:green:d0",
-		.default_trigger	= "default-off",
+		.name			= "omap3:green:boot",
+		.default_state		= 1,
 	},
 	[2] = {
-		.name			= "gpio-led:red:d1",
-		.default_trigger	= "default-off",
+		.name			= "omap3:red:user1",
+		.default_state		= 0,
 	},
 	[3] = {
-		.name			= "gpio-led:green:d1",
-		.default_trigger	= "heartbeat",
+		.name			= "omap3:green:user1",
+		.default_state		= 0,
 		.gpio			= -EINVAL, /* gets replaced */
 		.active_low		= 1,
 	},
-- 
1.7.7.6

