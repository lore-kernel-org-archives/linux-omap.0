From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/7] omap4: Workaround for CMD line reset.
Date: Thu,  9 Sep 2010 16:53:14 +0530
Message-ID: <1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-5-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-6-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41357 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0IILXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 07:23:24 -0400
In-Reply-To: <1284031395-25988-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Add a delay after CMD line reset to accomdate the reset to complete.
The SYSCTL seems to reflect SRC immediately which might not really
be indicating the complete of reset. This is observed only with ES2.0
silicon

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4a8776f..1c359f0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -986,6 +986,14 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 		(i++ < limit))
 		cpu_relax();
 
+	/*
+	 * On OMAP4 ES2 the SRC is zero in the first loop itself strangely
+	 * vs on ES1 it takes some time.
+	 * Could be a an issue on ES2 to indicate reset complete even before
+	 * it is complete.
+	 */
+	udelay(500);
+
 	if (OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
 		dev_err(mmc_dev(host->mmc),
 			"Timeout waiting on controller reset in %s\n",
-- 
1.6.0.4

