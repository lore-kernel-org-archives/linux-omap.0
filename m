From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 7/9] ASoC: omap-mcbsp: Remove cpu_is_omap* checks from the code
Date: Thu, 16 Aug 2012 16:41:06 +0300
Message-ID: <1345124468-8876-8-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:44166 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753853Ab2HPNlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 09:41:20 -0400
Received: by obc16 with SMTP id 16so3905990obc.34
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 06:41:19 -0700 (PDT)
In-Reply-To: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

We can use the has_ccr flag to replace the cpu_is_omap* checks.
This provides future proof implementation and we do not need to update the
code if new OMAP revision starts to use the McBSP driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
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

