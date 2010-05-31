From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC PATCH 3/5] OMAP3: McBSP: Use the port's buffer_size when calculating tx delay
Date: Mon, 31 May 2010 11:16:48 +0300
Message-ID: <1275293810-31984-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52970 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab0EaIRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 04:17:03 -0400
In-Reply-To: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Sicne the platform data's buffer_size now holds the full size
of the FIFO, there is no longer need to handle the ports
differently.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6462968..f8ffeee 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -575,8 +575,6 @@ u16 omap_mcbsp_get_fifo_size(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_fifo_size);
 
-#define MCBSP2_FIFO_SIZE	0x500 /* 1024 + 256 locations */
-#define MCBSP1345_FIFO_SIZE	0x80  /* 128 locations */
 /*
  * omap_mcbsp_get_tx_delay returns the number of used slots in the McBSP FIFO
  */
@@ -595,10 +593,7 @@ u16 omap_mcbsp_get_tx_delay(unsigned int id)
 	buffstat = MCBSP_READ(mcbsp, XBUFFSTAT);
 
 	/* Number of slots are different in McBSP ports */
-	if (mcbsp->id == 2)
-		return MCBSP2_FIFO_SIZE - buffstat;
-	else
-		return MCBSP1345_FIFO_SIZE - buffstat;
+	return mcbsp->pdata->buffer_size - buffstat;
 }
 EXPORT_SYMBOL(omap_mcbsp_get_tx_delay);
 
-- 
1.7.1

