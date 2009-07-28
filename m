From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 24/32] omap_hsmmc: clear interrupt status after init sequence
Date: Tue, 28 Jul 2009 13:41:31 +0300
Message-ID: <20090728104131.2371.37074.sendpatchset@ahunter-laptop>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753411AbZG1Klu@vger.kernel.org>
In-Reply-To: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Matt Fleming <matt@console-pimps.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From 1aa0e844f89f4349a6e940079343efbf9e8130d6 Mon Sep 17 00:00:00 2001
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
index 0373bdd..c7a6d88 100644
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
