From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 22/32] omap_hsmmc: fix NULL pointer dereference
Date: Fri, 10 Jul 2009 15:42:41 +0300
Message-ID: <20090710124241.1262.79000.sendpatchset@ahunter-tower>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35036 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbZGJMja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 08:39:30 -0400
In-Reply-To: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From ece776be05f73787dad93802000f2d04218197d0 Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Tue, 12 May 2009 19:46:14 +0300
Subject: [PATCH] omap_hsmmc: fix NULL pointer dereference

Do not call 'mmc_omap_xfer_done()' if the request is
already done.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 41c330d..fe46234 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -670,7 +670,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 
 	if (end_cmd || ((status & CC) && host->cmd))
 		mmc_omap_cmd_done(host, host->cmd);
-	if (end_trans || (status & TC))
+	if ((end_trans || (status & TC)) && host->mrq)
 		mmc_omap_xfer_done(host, data);
 
 	return IRQ_HANDLED;
-- 
1.5.6.3

