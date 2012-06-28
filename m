From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: GPMC: Show correct frequency for OneNAND devices using async mode
Date: Thu, 28 Jun 2012 13:41:30 -0500
Message-ID: <1340908890-28612-3-git-send-email-jon-hunter@ti.com>
References: <1340908890-28612-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2F1Slg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 14:41:36 -0400
In-Reply-To: <1340908890-28612-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Boards that have OneNAND devices but only support the async read and write modes
show that the OneNAND operating frequency is 0 MHz on boot. For example, the
OMAP3430 SDP shows the following:

omap2-onenand: initializing on CS2, phys base 0x20000000, virtual base c88c0000, freq 0 MHz

This is because the frequency is only queried when setting up synchronous
timings for boards using sync read and/or write modes. This is purely a cosmetic
fix to show the correct frequency on boot because currently the async timing are
set independently of the OneNAND frequency. However, this would need to be
changed to support different OneNAND devices using different async timings.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 0f3b5b9..62cfc93 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -348,17 +348,11 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	return 0;
 }
 
-static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
+static int omap2_onenand_setup_sync(void __iomem *onenand_base, int freq)
 {
-	int ret, freq = *freq_ptr;
+	int ret;
 	struct gpmc_timings t;
 
-	if (!freq) {
-		/* Very first call freq is not known */
-		freq = omap2_onenand_get_freq(gpmc_onenand_data, onenand_base);
-		set_onenand_cfg(onenand_base);
-	}
-
 	t = omap2_onenand_calc_sync_timings(gpmc_onenand_data, freq);
 
 	ret = gpmc_set_sync_mode(gpmc_onenand_data->cs, &t);
@@ -367,8 +361,6 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 
 	set_onenand_cfg(onenand_base);
 
-	*freq_ptr = freq;
-
 	return 0;
 }
 
@@ -384,10 +376,12 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 		return ret;
 	}
 
+	*freq_ptr = omap2_onenand_get_freq(gpmc_onenand_data, onenand_base);
+
 	if (!(gpmc_onenand_data->flags & l))
 		return 0;
 
-	ret = omap2_onenand_setup_sync(onenand_base, freq_ptr);
+	ret = omap2_onenand_setup_sync(onenand_base, *freq_ptr);
 	if (ret)
 		dev_err(dev, "unable to set to sync mode\n");
 	return ret;
-- 
1.7.9.5

