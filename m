From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: Fix compile for omap_hsmmc.c (Re: New build error?)
Date: Tue, 7 Apr 2009 17:13:27 -0700
Message-ID: <20090408001325.GG23823@atomide.com>
References: <20090407195524.GA10619@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56323 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760403AbZDHANn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 20:13:43 -0400
Content-Disposition: inline
In-Reply-To: <20090407195524.GA10619@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Pierre Ossman <drzeus@drzeus.cx>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090407 12:55]:
> Caused by: 4a694dc915c9a223044ce21fc0d99e63facd1d64
> 
>     omap_hsmmc: Fix response type for busy after response
> 
> Error:
> 
> drivers/mmc/host/omap_hsmmc.c: In function 'mmc_omap_xfer_done':
> drivers/mmc/host/omap_hsmmc.c:301: error: implicit declaration of function 'mmc_omap_fclk_lazy_disable'
> 
> Please submit a fix to Pierre for this, thanks.

Thanks for notifying about this. Pierre, here's a fix for this.

Tony

--X1bOJ3K7DJ5YkBrT
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-fix-compile.patch"

>From 880d2674e036b566f5596bef1b45911508cd37a1 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 7 Apr 2009 17:04:33 -0700
Subject: [PATCH] mmc: Fix compile for omap_hsmmc.c

This fixes the issue noted by Russell King:

drivers/mmc/host/omap_hsmmc.c: In function 'mmc_omap_xfer_done':
drivers/mmc/host/omap_hsmmc.c:301: error: implicit declaration of function 'mmc_omap_fclk_lazy_disable'

This got broken by 4a694dc915c9a223044ce21fc0d99e63facd1d64.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a752788..d765df2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -298,7 +298,6 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 		struct mmc_request *mrq = host->mrq;
 
 		host->mrq = NULL;
-		mmc_omap_fclk_lazy_disable(host);
 		mmc_request_done(host->mmc, mrq);
 		return;
 	}

--X1bOJ3K7DJ5YkBrT--
