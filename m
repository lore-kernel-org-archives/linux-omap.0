From: hvaibhav@ti.com
Subject: [PATCH] OMAP:ls037v7dw01: Included slab.h file required for kzalloc
Date: Tue, 20 Apr 2010 15:14:59 +0530
Message-ID: <1271756699-3161-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50391 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab0DTJpJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 05:45:09 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

With recent kernel changes, without inclusion of slab.h
kernel build fails with,

  CC      drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o
  drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c: In function
  'sharp_ls_panel_probe':
  drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:93: error: implicit
  declaration of function 'kzalloc'
  drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:93: warning:
  assignment makes pointer from integer without a cast
  drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:106: error: implicit
  declaration of function 'kfree'
  make[4]: *** [drivers/video/omap2/displays/panel-sharp-ls037v7dw01.o] Error 1
  make[3]: *** [drivers/video/omap2/displays] Error 2
  make[2]: *** [drivers/video/omap2] Error 2
  make[1]: *** [drivers/video] Error 2
  make: *** [drivers] Error 2


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index d84feb0..7d9eb2b 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -23,6 +23,7 @@
 #include <linux/backlight.h>
 #include <linux/fb.h>
 #include <linux/err.h>
+#include <linux/slab.h>

 #include <plat/display.h>

--
1.6.2.4

