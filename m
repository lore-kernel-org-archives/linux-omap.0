From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 5/5] OMAP: remove duplicated #include
Date: Sun, 13 Dec 2009 21:14:33 +0800
Message-ID: <1260710073-4160-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61251 "HELO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752088AbZLMNOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 08:14:44 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1434891pwj.21
        for <linux-omap@vger.kernel.org>; Sun, 13 Dec 2009 05:14:44 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  drivers/video/omap/lcd_omap3beagle.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/video/omap/lcd_omap3beagle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index fc503d8..aea23c3 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -26,7 +26,6 @@
 #include <linux/i2c/twl4030.h>
 
 #include <plat/mux.h>
-#include <plat/mux.h>
 #include <asm/mach-types.h>
 
 #include "omapfb.h"
-- 
1.6.1.3

