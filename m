From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 015/199] Video omap lcd_omap3beagle.c: duplicated include
Date: Sun, 23 May 2010 22:10:01 +0200
Message-ID: <1274645401-27734-4-git-send-email-andrea.gelmini@gelma.net>
References: <1274645401-27734-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:27586 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0EWUKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 May 2010 16:10:18 -0400
In-Reply-To: <1274645401-27734-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Koen Kooi <koen@openembedded.org>, David Brownell <dbrownell@users.sourceforge.net>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

drivers/video/omap/lcd_omap3beagle.c: plat/mux.h is included more than once.

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 drivers/video/omap/lcd_omap3beagle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index ca75cc2..ac715f9 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -26,7 +26,6 @@
 #include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
-#include <plat/mux.h>
 #include <asm/mach-types.h>
 
 #include "omapfb.h"
-- 
1.7.1.251.gf80a2

