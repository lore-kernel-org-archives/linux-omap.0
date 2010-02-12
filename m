From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/19] omap: Reconnect hsmmc context loss count
Date: Thu, 11 Feb 2010 16:51:18 -0800
Message-ID: <20100212005118.24958.4280.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51224 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712Ab0BLAug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:36 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Call the PM context-loss count function, now that there
is a prototype for it.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 2ba0d55..cc7e77f 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -16,6 +16,7 @@
 #include <mach/hardware.h>
 #include <plat/control.h>
 #include <plat/mmc.h>
+#include <plat/omap-pm.h>
 
 #include "hsmmc.h"
 
@@ -34,8 +35,7 @@ static struct hsmmc_controller {
 
 static int hsmmc_get_context_loss(struct device *dev)
 {
-	/* FIXME: PM DPS not implemented yet */
-	return 0;
+	return omap_pm_get_dev_context_loss_count(dev);
 }
 
 #else

