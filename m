From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] ASoC: omap-mcbsp: Support SND_SOC_DAIFMT_CBM_CFS for omap3/4
Date: Sun, 21 Jul 2013 18:24:01 +0200
Message-ID: <20130721162400.GA17491@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:43913 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584Ab3GUQYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Jul 2013 12:24:08 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so3382308eek.9
        for <linux-omap@vger.kernel.org>; Sun, 21 Jul 2013 09:24:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Add SND_SOC_DAIFMT_CBM_CFS support for omap3/omap4. The patch was tested on
a pandaboard-es board connected to the pcm1792a codec. mcbspx_fsx must
configured as output and mcbspx_clkx must be configured as input.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7483efb..6c19bba 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -433,6 +433,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* Sample rate generator drives the FS */
 		regs->srgr2	|= FSGM;
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		/* McBSP slave. FS clock as output */
+		regs->srgr2	|= FSGM;
+		regs->pcr0	|= FSXM;
+		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* McBSP slave */
 		break;
-- 
1.7.9.5

