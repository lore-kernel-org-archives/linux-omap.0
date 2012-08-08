From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 10/11] ASoC: omap-mcbsp: Remove cpu_is_omap* checks from the code
Date: Wed,  8 Aug 2012 12:11:40 +0300
Message-ID: <1344417101-5015-11-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:56362 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757914Ab2HHJMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:12:31 -0400
Received: by obbta14 with SMTP id ta14so1187441obb.18
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:12:29 -0700 (PDT)
In-Reply-To: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

We can use the has_ccr flag to replace the cpu_is_omap* checks.
This provides future proof implementation and we do not need to update the
code if new OMAP revision starts to use the McBSP driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 5061594..b9770ee 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -398,12 +398,14 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Generic McBSP register settings */
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
-	/* RFIG and XFIG are not defined in 34xx */
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx()) {
+	/* RFIG and XFIG are not defined in 2430 and on OMAP3+ */
+	if (!mcbsp->pdata->has_ccr) {
 		regs->rcr2	|= RFIG;
 		regs->xcr2	|= XFIG;
 	}
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+
+	/* Configure XCCR/RCCR only for revisions which have ccr registers */
+	if (mcbsp->pdata->has_ccr) {
 		regs->xccr = DXENDLY(1) | XDMAEN | XDISABLE;
 		regs->rccr = RFULL_CYCLE | RDMAEN | RDISABLE;
 	}
-- 
1.7.8.6

