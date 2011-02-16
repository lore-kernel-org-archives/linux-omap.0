From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/6] cbus: retu: wdt: save dev in retu_wdt_dev
Date: Wed, 16 Feb 2011 22:01:16 +0200
Message-ID: <1297886481-26098-2-git-send-email-balbi@ti.com>
References: <1297886481-26098-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45675 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753135Ab1BPUBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 15:01:30 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so1042836bwz.33
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 12:01:28 -0800 (PST)
In-Reply-To: <1297886481-26098-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

commit 6b8074b00d90b191227dc875b90b272c51f7d6eb
(cbus: Make retu watchdog behave like a standard
Linux watchdog) introduced struct retu_wdt_dev
with a field to save struct device *dev, but never
got the point of saving the pointer into that
structure.

Fix this very old bug so we can actually start
passing child device pointers to retu read/write
operations.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-wdt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 423216c..f6ff9ad 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -258,6 +258,7 @@ static int __init retu_wdt_probe(struct platform_device *pdev)
 	if (!wdev)
 		return -ENOMEM;
 
+	wdev->dev = &pdev->dev;
 	wdev->users = 0;
 
 	ret = device_create_file(&pdev->dev, &dev_attr_period);
-- 
1.7.4.rc2

