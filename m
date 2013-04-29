From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/10] OMAPDSS: Makefile: move omapfb after panels
Date: Mon, 29 Apr 2013 13:22:28 +0300
Message-ID: <1367230957-32337-2-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3D2KXD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:03 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb requires the panels to have been probed before omapfb's probe. We
currently manage that by having omapfb in late initcall level. However,
a much simpler way is to just change the makefile so that omapfb is
after the panel drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/Makefile b/drivers/video/omap2/Makefile
index 5ea7cb9..296e5c5 100644
--- a/drivers/video/omap2/Makefile
+++ b/drivers/video/omap2/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 
 obj-$(CONFIG_OMAP2_DSS) += dss/
-obj-$(CONFIG_FB_OMAP2) += omapfb/
 obj-y += displays/
+obj-$(CONFIG_FB_OMAP2) += omapfb/
-- 
1.7.10.4

