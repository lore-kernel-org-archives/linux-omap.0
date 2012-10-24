From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/20] OMAPDSS: remove dispc_irq_handler declaration
Date: Wed, 24 Oct 2012 12:28:54 +0300
Message-ID: <1351070951-18616-4-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35461 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338Ab2JXJ3a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:30 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss.h contains dispc_irq_handler declaration, even if the function is
dispc.c internal. Remove the declaration.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index fb89165..00e0a36 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -398,7 +398,6 @@ void dpi_uninit_platform_driver(void) __exit;
 int dispc_init_platform_driver(void) __init;
 void dispc_uninit_platform_driver(void) __exit;
 void dispc_dump_clocks(struct seq_file *s);
-void dispc_irq_handler(void);
 
 int dispc_runtime_get(void);
 void dispc_runtime_put(void);
-- 
1.7.9.5

