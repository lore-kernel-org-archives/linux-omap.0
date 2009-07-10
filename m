From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 25/32] omap_hsmmc: cater for weird CMD6 behaviour
Date: Fri, 10 Jul 2009 15:43:02 +0300
Message-ID: <20090710124302.1262.37406.sendpatchset@ahunter-tower>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19562 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbZGJMjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 08:39:39 -0400
In-Reply-To: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

>From 4ad1f699fad1f7132e5a6a7ad1a2a433accb88d4 Mon Sep 17 00:00:00 2001
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
index 315d1df..28563d6 100644
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

