From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 04/11] ASoC: core - Add API call to register dai kcontrols.
Date: Wed, 15 Feb 2012 17:37:53 +0200
Message-ID: <1329320280-1621-5-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44570 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751530Ab2BOPiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:09 -0500
Received: by mail-ee0-f43.google.com with SMTP id b45so472980eek.16
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:38:07 -0800 (PST)
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Allow dai drivers to register kcontrols.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2f687ed..f513758 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -372,6 +372,8 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 	const struct snd_kcontrol_new *controls, int num_controls);
+int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
+	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 35a1e63..d04a029 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2080,6 +2080,37 @@ int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 EXPORT_SYMBOL_GPL(snd_soc_add_platform_controls);
 
 /**
+ * snd_soc_add_dai_controls - add an array of controls to a dai.
+ * Convienience function to add a list of controls.
+ *
+ * @dai: dai to add controls to
+ * @controls: array of controls to add
+ * @num_controls: number of elements in the array
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	struct snd_card *card = dai->card->snd_card;
+	int err, i;
+
+	for (i = 0; i < num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+		err = snd_ctl_add(card, snd_soc_cnew(control, dai,
+				control->name, NULL));
+		if (err < 0) {
+			dev_err(dai->dev, "Failed to add %s %d\n",
+				control->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_dai_controls);
+
+/**
  * snd_soc_info_enum_double - enumerated double mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.7.8.4

