From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 18/20] ASoC: Always syncronize audio transfers on frames
Date: Mon, 17 Aug 2009 14:51:17 +0300
Message-ID: <1250509879-6703-19-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23231 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902AbZHQMFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:22 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

All these steps are required for ASoC to behave correctly.
rccr and xccr are format dependent, for example TDM audio
has different values than I2S or DSP_A. Also the
omap_mcbsp_xmit_enable and/or omap_mcbsp_recv_enable must
be called right after the DMA has started.
This provides no longer L and R channels switching at random.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a7b0961..76c32f8 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -189,8 +189,12 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		mcbsp_data->active++;
 		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
+		/* Make sure data transfer is frame synchronized */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			omap_mcbsp_xmit_enable(mcbsp_data->bus_id, 1);
+		else
+			omap_mcbsp_recv_enable(mcbsp_data->bus_id, 1);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -336,11 +340,15 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* 1-bit data delay */
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
+		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
+		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* 1-bit data delay */
 		regs->rcr2      |= RDATDLY(1);
 		regs->xcr2      |= XDATDLY(1);
+		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
+		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
 		/* Invert FS polarity configuration */
 		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
 		break;
-- 
1.6.2.GIT

