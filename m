From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v5 3/5] OMAP3: McBSP: Use the port's buffer_size when calculating tx delay
Date: Thu,  3 Jun 2010 07:39:34 +0300
Message-ID: <1275539976-2075-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1275539976-2075-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25992 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab0FCEkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 00:40:03 -0400
In-Reply-To: <1275539976-2075-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, tony@atomide.com
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Sicne the platform data's buffer_size now holds the full size
of the FIFO, there is no longer need to handle the ports
differently.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Mark Brown <broonie@opensource.wolsfonmicro.com>
---
 arch/arm/plat-omap/mcbsp.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index d883bbf..ac09c79 100644
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

