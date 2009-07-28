From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 14/32] omap_hsmmc: set open drain bit correctly
Date: Tue, 28 Jul 2009 13:40:18 +0300
Message-ID: <20090728104018.2371.72076.sendpatchset@ahunter-laptop>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753190AbZG1KkG@vger.kernel.org>
In-Reply-To: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Matt Fleming <matt@console-pimps.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From 60dc8abdafb94824a5984f769a05c9b82f784e6b Mon Sep 17 00:00:00 2001
From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Date: Thu, 23 Apr 2009 16:44:58 +0300
Subject: [PATCH] omap_hsmmc: set open drain bit correctly

The code could set the bit to 1 but not reset it to 0.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ac1a3bf..2b242c2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1111,9 +1111,11 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (do_send_init_stream)
 		send_init_stream(host);
 
+	con = OMAP_HSMMC_READ(host->base, CON);
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-		OMAP_HSMMC_WRITE(host->base, CON,
-				OMAP_HSMMC_READ(host->base, CON) | OD);
+		OMAP_HSMMC_WRITE(host->base, CON, con | OD);
+	else
+		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
 
 	mmc_host_lazy_disable(host->mmc);
 }
-- 
1.5.6.3
