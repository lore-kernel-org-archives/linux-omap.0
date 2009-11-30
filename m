From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 01/20] DSPBRIDGE: driver version 0.1
Date: Mon, 30 Nov 2009 15:54:42 -0600
Message-ID: <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbZK3VtC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:49:02 -0500
In-Reply-To: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Prior to any further modification set the driver version to be 0.1

Also in this patch:
- Move author and license macros to end of file
- License to be GPL v2 as stated on the comments

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 65ac1e7..9ddd637 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -188,9 +188,6 @@ MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
 module_param(min_active_opp, ushort, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(min_active_opp, "Minimum ACTIVE VDD1 OPP Level, default = 3");
 
-MODULE_AUTHOR("Texas Instruments");
-MODULE_LICENSE("GPL");
-
 static char *driver_name = DRIVER_NAME;
 
 #ifdef CONFIG_BRIDGE_DEBUG
@@ -731,3 +728,6 @@ static void bridge_destroy_sysfs(void)
 module_init(bridge_init);
 module_exit(bridge_exit);
 
+MODULE_AUTHOR("Texas Instruments");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1");
-- 
1.6.2.4

