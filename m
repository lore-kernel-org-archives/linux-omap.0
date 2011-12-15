From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] OMAP4: mcbsp: Enable FIFO usage
Date: Thu, 15 Dec 2011 11:32:26 +0200
Message-ID: <1323941547-7714-2-git-send-email-peter.ujfalusi@ti.com>
References: <1323941547-7714-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:55352 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758727Ab1LOJc4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 04:32:56 -0500
Received: by lagu2 with SMTP id u2so1019562lag.23
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 01:32:53 -0800 (PST)
In-Reply-To: <1323941547-7714-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

All McBSP instances on OMAP4 has 128 word long FIFO

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 292eee3..857860b 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -153,6 +153,9 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		else
 			/* The FIFO has 128 locations */
 			pdata->buffer_size = 0x80;
+	} else if (oh->class->rev == MCBSP_CONFIG_TYPE4) {
+		/* The FIFO has 128 locations for all instances */
+		pdata->buffer_size = 0x80;
 	}
 
 	if (oh->class->rev >= MCBSP_CONFIG_TYPE3)
-- 
1.7.8

