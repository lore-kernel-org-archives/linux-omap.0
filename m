From: felipe.balbi@nokia.com
Subject: [RFC PATCH 06/37] cbus: no ternary on return
Date: Wed,  7 Apr 2010 19:03:57 +0300
Message-ID: <1270656268-7034-7-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62327 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab0DGQFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:16 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G56Au007315
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:16 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

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
1.7.0.rc0.33.g7c3932

