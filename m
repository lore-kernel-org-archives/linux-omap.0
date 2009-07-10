From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 24/32] omap_hsmmc: clear interrupt status after init sequence
Date: Fri, 10 Jul 2009 15:42:55 +0300
Message-ID: <20090710124255.1262.32284.sendpatchset@ahunter-tower>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37198 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbZGJMjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 08:39:33 -0400
In-Reply-To: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 5fffc71c4b754453a286bec4c461ca6897941ad1 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 09:35:17 +0300
Subject: [PATCH] omap_hsmmc: clear interrupt status after init sequence

Clear the interrupt status after sending the initialization sequence,
as specified in the TRM.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 743c07a..315d1df 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -358,6 +358,10 @@ static void send_init_stream(struct mmc_omap_host *host)
 
 	OMAP_HSMMC_WRITE(host->base, CON,
 		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
+
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	OMAP_HSMMC_READ(host->base, STAT);
+
 	enable_irq(host->irq);
 }
 
-- 
1.5.6.3

