From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] OMAPFB: fix compilation warnings due to missing include
Date: Mon, 14 Nov 2011 17:01:44 +0200
Message-ID: <1321282905-12939-3-git-send-email-tomi.valkeinen@ti.com>
References: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44390 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279Ab1KNPCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 10:02:00 -0500
In-Reply-To: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Fix warnings similar to this by including module.h:

drivers/video/omap/dispc.c:276:1: warning: data definition has no type
or storage class
drivers/video/omap/dispc.c:276:1: warning: type defaults to 'int' in
declaration of 'EXPORT_SYMBOL'

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/dispc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 0ccd7ad..10f8bbe 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -18,7 +18,7 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
-#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
-- 
1.7.4.1

