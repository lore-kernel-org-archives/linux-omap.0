From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 06/10] cbus: switch to kzalloc
Date: Thu,  3 Dec 2009 00:28:28 +0200
Message-ID: <1259792912-11328-7-git-send-email-felipe.balbi@nokia.com>
References: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47905 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbZLBW2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:28:53 -0500
In-Reply-To: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

change kmalloc() + memset() to kzalloc(), no functional
changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index c80cede..0bcc211 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -224,12 +224,10 @@ int __init cbus_bus_init(void)
 	struct cbus_host *chost;
 	int ret;
 
-	chost = kmalloc(sizeof (*chost), GFP_KERNEL);
+	chost = kzalloc(sizeof (*chost), GFP_KERNEL);
 	if (chost == NULL)
 		return -ENOMEM;
 
-	memset(chost, 0, sizeof (*chost));
-
 	spin_lock_init(&chost->lock);
 
 	/* REVISIT: Pass these from board-*.c files in platform_data */
-- 
1.6.6.rc0

