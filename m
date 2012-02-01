From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] power: isp1704: fix probe error path
Date: Wed,  1 Feb 2012 03:03:47 +0200
Message-ID: <1328058229-29014-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53180 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752594Ab2BABEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 20:04:42 -0500
Received: by lagu2 with SMTP id u2so370788lag.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 17:04:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Clifton Barnes <cabarnes@indesign-llc.com>, Axel Lin <axel.lin@gmail.com>

We enable power, but don't disable it in case of an error.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/power/isp1704_charger.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index b806667..cce6211 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -470,6 +470,7 @@ fail0:
 
 	dev_err(&pdev->dev, "failed to register isp1704 with error %d\n", ret);
 
+	isp1704_charger_set_power(isp, 0);
 	return ret;
 }
 
-- 
1.7.9

