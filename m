From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 11/15] video/omap: add __init/__exit macros to drivers/video/omap/lcd_htcherald.c
Date: Fri,  8 Jan 2010 15:22:45 +0200
Message-ID: <1262956969-1664-12-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57083 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab0AHNWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:49 -0500
In-Reply-To: <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>

From: Peter Huewe <peterhuewe@gmx.de>

Trivial patch which adds the __init/__exit macros to the module_init/
module_exit functions of

drivers/video/omap/lcd_htcherald.c

Please have a look at the small patch and either pull it through
your tree, or please ack' it so Jiri can pull it through the trivial
tree.

Patch against linux-next-tree, 22. Dez 08:38:18 CET 2009
but also present in linus tree.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/omap/lcd_htcherald.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/lcd_htcherald.c b/drivers/video/omap/lcd_htcherald.c
index a9007c5..4802419 100644
--- a/drivers/video/omap/lcd_htcherald.c
+++ b/drivers/video/omap/lcd_htcherald.c
@@ -115,12 +115,12 @@ struct platform_driver htcherald_panel_driver = {
 	},
 };
 
-static int htcherald_panel_drv_init(void)
+static int __init htcherald_panel_drv_init(void)
 {
 	return platform_driver_register(&htcherald_panel_driver);
 }
 
-static void htcherald_panel_drv_cleanup(void)
+static void __exit htcherald_panel_drv_cleanup(void)
 {
 	platform_driver_unregister(&htcherald_panel_driver);
 }
-- 
1.6.5

