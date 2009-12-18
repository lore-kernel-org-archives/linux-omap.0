From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH] OMAP: remove duplicated #include
Date: Fri, 18 Dec 2009 23:57:08 +0800
Message-ID: <1261151828-244-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:49147 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZLRP5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 10:57:25 -0500
Received: by pwj9 with SMTP id 9so1982448pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 07:57:23 -0800 (PST)
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
1.6.1.3

