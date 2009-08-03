From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] [PATCH] ASoC: OMAP: full duplex mode fix
Date: Mon, 3 Aug 2009 03:32:04 +0200
Message-ID: <200908030332.06727.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This patch tries to correct the problem of full duplex mode not working
over a single McBSP based CPU DAI.

Created against linux-2.6.31-rc5.
Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- linux-2.6.31-rc5/sound/soc/omap/omap-mcbsp.c.orig	2009-08-01 02:40:45.000000000 +0200
+++ linux-2.6.31-rc5/sound/soc/omap/omap-mcbsp.c	2009-08-03 03:28:07.000000000 +0200
@@ -183,6 +183,7 @@ static int omap_mcbsp_dai_trigger(struct
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	u16 buf;
 	int err = 0;
 
 	switch (cmd) {
@@ -191,6 +192,14 @@ static int omap_mcbsp_dai_trigger(struct
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!mcbsp_data->active++)
 			omap_mcbsp_start(mcbsp_data->bus_id);
+		else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			/* looks like capture already in progress,
+			 * start playback by taking it out of error condition */
+			omap_mcbsp_pollwrite(mcbsp_data->bus_id, 0x0);
+		else
+			/* looks like playback already in progress,
+			 * start capture by taking it out of error condition */
+			omap_mcbsp_pollread(mcbsp_data->bus_id, &buf);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
