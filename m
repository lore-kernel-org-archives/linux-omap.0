From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] omapfb: fix broken build on OMAP1
Date: Mon,  4 Mar 2013 23:03:19 +0200
Message-ID: <1362431000-15141-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:42480 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758775Ab3CDVEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 16:04:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Fix the following build regression in 3.9-rc1 by including
<mach/hardware.h>:

drivers/video/omap/omapfb_main.c: In function 'set_fb_var':
drivers/video/omap/omapfb_main.c:505:3: error: implicit declaration of function 'cpu_is_omap15xx' [-Werror=implicit-function-declaration]

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap/omapfb_main.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index e31f5b3..d40612c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -32,6 +32,8 @@
 
 #include <linux/omap-dma.h>
 
+#include <mach/hardware.h>
+
 #include "omapfb.h"
 #include "lcdc.h"
 
-- 
1.7.10.4

