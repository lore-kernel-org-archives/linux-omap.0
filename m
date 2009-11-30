From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 11/20] DSPBRIDGE: checkpatch - struct file_operations should normally be const
Date: Mon, 30 Nov 2009 15:54:52 -0600
Message-ID: <1259618101-8972-12-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45932 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZK3VtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 16:49:00 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn6eO013331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:07 -0600
In-Reply-To: <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

WARNING: struct file_operations should normally be const

Signed-off-by: Omar Ramirez Lua <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f480d22..94f35d1 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -166,7 +166,7 @@ static char *driver_name = DRIVER_NAME;
 static struct GT_Mask driverTrace;
 #endif /* CONFIG_BRIDGE_DEBUG */
 
-static struct file_operations bridge_fops = {
+static const struct file_operations bridge_fops = {
 	.open		= bridge_open,
 	.release	= bridge_release,
 	.unlocked_ioctl	= bridge_ioctl,
-- 
1.6.2.4

