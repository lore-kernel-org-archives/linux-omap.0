From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 6/6] cbus: no ternary on return
Date: Wed, 16 Dec 2009 01:44:13 +0200
Message-ID: <1260920653-18503-7-git-send-email-felipe.balbi@nokia.com>
References: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19913 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760760AbZLOXqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:46:46 -0500
In-Reply-To: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

data is reset to 0 if is_read is true. No need
to use ternary operator before returning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 615f447..35f7c71 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -121,7 +121,7 @@ static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	return is_read ? data : 0;
+	return data;
 }
 
 /*
-- 
1.6.6.rc0

