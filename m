From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 22/32] omap_hsmmc: fix NULL pointer dereference
Date: Tue, 28 Jul 2009 13:41:17 +0300
Message-ID: <20090728104117.2371.98637.sendpatchset@ahunter-laptop>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753401AbZG1Kln@vger.kernel.org>
In-Reply-To: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Matt Fleming <matt@console-pimps.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From 0f00e61d9f963d44771f655deaa8f5f4951606a8 Mon Sep 17 00:00:00 2001
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
index d5fb066..4309031 100644
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
