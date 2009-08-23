From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] ASoC: OMAP: Fix setup of XCCR and RCCR registers in McBSP DAI
Date: Sun, 23 Aug 2009 12:24:26 +0300
Message-ID: <1251019467-11677-3-git-send-email-jhnikula@gmail.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:32790 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbZHWJXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 05:23:22 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so1640891ewy.18
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 02:23:24 -0700 (PDT)
In-Reply-To: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, tony@atomide.com, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Commit ca6e2ce08679c094878d7f39a0349a7db1d13675 is setting up few XCCR and
RCCR bits for I2S and DPS_A formats. Part of the bits are already set
for all formats and I believe that XDISABLE and RDISABLE bits are
format independent.

As XCCR and RCCR are found only from OMAP2430 and OMAP34xx, I move setup
of XDISABLE and RDISABLE to where those cpu's are tested and remove format
dependent part for simplicity.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index f5387d9..89e8bce 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -379,8 +379,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->xcr2	|= XFIG;
 	}
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-		regs->xccr = DXENDLY(1) | XDMAEN;
-		regs->rccr = RFULL_CYCLE | RDMAEN;
+		regs->xccr = DXENDLY(1) | XDMAEN | XDISABLE;
+		regs->rccr = RFULL_CYCLE | RDMAEN | RDISABLE;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -388,15 +388,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* 1-bit data delay */
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
-		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
-		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* 1-bit data delay */
 		regs->rcr2      |= RDATDLY(1);
 		regs->xcr2      |= XDATDLY(1);
-		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
-		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		/* Invert FS polarity configuration */
 		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
 		break;
-- 
1.6.3.3

