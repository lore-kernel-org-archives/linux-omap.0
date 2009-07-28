From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 25/32] omap_hsmmc: cater for weird CMD6 behaviour
Date: Tue, 28 Jul 2009 13:41:39 +0300
Message-ID: <20090728104139.2371.70665.sendpatchset@ahunter-laptop>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753489AbZG1Kl4@vger.kernel.org>
In-Reply-To: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Matt Fleming <matt@console-pimps.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From 8520f6fd74c073a76121619403808f1e3da0f587 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 10:05:40 +0300
Subject: [PATCH] omap_hsmmc: cater for weird CMD6 behaviour

Sometimes the controller unexpectedly produces a TC (transfer
complete) interrupt before the CC (command complete) interrupt for
command 6 (SWITCH).  This is a problem because the CC interrupt
can get mixed up with the next request.  Add a hack for CMD6.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c7a6d88..5121277 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -474,6 +474,13 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 	if (!data) {
 		struct mmc_request *mrq = host->mrq;
 
+		/* TC before CC from CMD6 - don't know why, but it happens */
+		if (host->cmd && host->cmd->opcode == 6 &&
+		    host->response_busy) {
+			host->response_busy = 0;
+			return;
+		}
+
 		host->mrq = NULL;
 		mmc_request_done(host->mmc, mrq);
 		return;
-- 
1.5.6.3
