From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 3/3] ASoC: Always syncronize audio transfers on frames
Date: Tue, 13 Jan 2009 09:52:15 +0200
Message-ID: <1231833140301-git-send-email-ext-eero.nurkkala@nokia.com>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
 <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
 <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56835 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbZAMH4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 02:56:17 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D7taXF009170
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 09:56:14 +0200
In-Reply-To: <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

All these steps are required for ASoC to behave correctly.
This is, no RFIG or XFIG (Not defined in 34xx), correct
initiliazation of rccr and xccr. They are format dependent,
for example TDM audio has different values than I2S or
DSP_A. Also the omap_mcbsp_xmit_enable and/or
omap_mcbsp_recv_enable must be called right after the
DMA has started. This provides no longer L and R channels
switching at random.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8485a8a..06b6367 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -178,6 +178,11 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!mcbsp_data->active++)
 			omap_mcbsp_start(mcbsp_data->bus_id);
+		/* Make sure data transfer is frame synchronized */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			omap_mcbsp_xmit_enable(mcbsp_data->bus_id, 1);
+		else
+			omap_mcbsp_recv_enable(mcbsp_data->bus_id, 1);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -293,19 +298,26 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Generic McBSP register settings */
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
-	regs->rcr2	|= RFIG;
-	regs->xcr2	|= XFIG;
+	/* RFIG and XFIG are not defined in 34xx */
+	if (!cpu_is_omap34xx()) {
+		regs->rcr2	|= RFIG;
+		regs->xcr2	|= XFIG;
+	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		/* 1-bit data delay */
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
+		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
+		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
+		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
+		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		break;
 	default:
 		/* Unsupported data format */
-- 
1.5.2

