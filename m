From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 13/14] ASoC: omap-mcpdm: Support for suspend resume
Date: Wed, 18 May 2016 16:46:35 +0300
Message-ID: <1463579196-5484-14-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463579196-5484-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: t-kristo-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Implement ASoC's suspend and resume callbacks.
Since McPDM does not use pcm_trigger for start and stop of the stream due
to strict sequencing needs with the twl6040, the callbacks will stop and
restart the McPDM in case the board suspended during audio activity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 sound/soc/omap/omap-mcpdm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 11bd07cdce22..74d6e6fdcfd0 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -66,6 +66,9 @@ struct omap_mcpdm {
 	/* McPDM needs to be restarted due to runtime reconfiguration */
 	bool restart;
 
+	/* pm state for suspend/resume handling */
+	int pm_active_count;
+
 	struct snd_dmaengine_dai_dma_data dma_data[2];
 };
 
@@ -422,12 +425,55 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int omap_mcpdm_suspend(struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	if (dai->active) {
+		omap_mcpdm_stop(mcpdm);
+		omap_mcpdm_close_streams(mcpdm);
+	}
+
+	mcpdm->pm_active_count = 0;
+	while (pm_runtime_active(mcpdm->dev)) {
+		pm_runtime_put_sync(mcpdm->dev);
+		mcpdm->pm_active_count++;
+	}
+
+	return 0;
+}
+
+static int omap_mcpdm_resume(struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	if (mcpdm->pm_active_count) {
+		while (mcpdm->pm_active_count--)
+			pm_runtime_get_sync(mcpdm->dev);
+
+		if (dai->active) {
+			omap_mcpdm_open_streams(mcpdm);
+			omap_mcpdm_start(mcpdm);
+		}
+	}
+
+
+	return 0;
+}
+#else
+#define omap_mcpdm_suspend NULL
+#define omap_mcpdm_resume NULL
+#endif
+
 #define OMAP_MCPDM_RATES	(SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 #define OMAP_MCPDM_FORMATS	SNDRV_PCM_FMTBIT_S32_LE
 
 static struct snd_soc_dai_driver omap_mcpdm_dai = {
 	.probe = omap_mcpdm_probe,
 	.remove = omap_mcpdm_remove,
+	.suspend = omap_mcpdm_suspend,
+	.resume = omap_mcpdm_resume,
 	.probe_order = SND_SOC_COMP_ORDER_LATE,
 	.remove_order = SND_SOC_COMP_ORDER_EARLY,
 	.playback = {
-- 
2.8.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
