Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C548F83C
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160031; cv=none; b=lxTd7J1lmkjpO60CvpdM0xAjjLACh2aCJxOYY0wOhEQKchKkbc9hHscHeVeLcy17asA2doQ6fipiz0RjxqO86N2DQnIfGL8ce1LvL7LHRVcb0GjUcg9bgWSMaWC8nguk9De0LcjOuf7ovmkXilVe0sz51lv3a9nbKzLwS2nbKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160031; c=relaxed/simple;
	bh=KiS7s2YWKfO0/RJfTe+FQs+3VjzN90YoB9vay3+yqCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o1OdjS+Qjej/2Iuqui0WQgnV8i1+bOO7wcfDn3l5/q5EtExbzX17dG2nLaoyDtKbk9jjxbXscPPrqeAOe7eKM3XpqbAxQN4k5GqCCN3Z26zjUut0lo9r01MtVvXkWkRMf1F4fhA873E0VmEFeNek+rracFIbxjhqmNrG+3n+YCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2ctcBRj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2ctcBRj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso550201f8f.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787160009; x=1787764809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8aiWTi8iCRitLJdmIbO9vTChppeuaJGSr+c2w6PERcA=;
        b=f2ctcBRjzXWh7GJ5JzZqTU8O+hlHta2XbKV71VYthCJhyhNvojLSV28MmEX9zaVzRe
         K3ReCFUBzq6ScyL5HYS4gxt+F+EzjbgpvIxqpXQz1CN3vgOO7yC3EmY9vHAgD5rNCDLw
         yIyrf2clK7E1OtYBnXrotq3brpvrxyTwr96Ju0M2B3iCmLfgSimlf605lyEI4cR/khGt
         z+iU9wi/BvhBCzZsOfP8EZ1oQ4nwCcp7Z7PRlYyvcd7qKFuaUBdbDyIjwO4QAixHqMqS
         P8k1oOmGr13e7rrnuZ+Ig6T2rxgXULBq2qO9wXXWLBODzIh5nQA9I2RQ1ToKpisBYy+P
         /C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160009; x=1787764809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aiWTi8iCRitLJdmIbO9vTChppeuaJGSr+c2w6PERcA=;
        b=L/wkqP4DK6fAl+gWstWHvNA8N2HwcgqCCCSsLxRZAgOqF/64F3HQHkiYWrTP6GWln1
         o2NpbFa9DHawNrDrHmXMaD5TS9qWyJ86LWe8P+asyyxnCGMuuUdI0ZR8Ls0+xX3+pGtB
         ra1NN5UymILuwFm4fb48J8ayeQqopUR2UbBldXm53DlwSgyO0nQazJxcdAEzs/ywYZxy
         XB9oawUqIouAAkdNHpd0MpeU8clbBeg8k8XzJPWTGQq/qVTl2w9exInsvjDZUJPPeUUm
         +kPjpY0BCMUKkLNIrE7EnGEh9PKrFl+Bz4c9wE8KYfNiqWLtKu1TQ8nJhIOG0o/TbjyH
         sB6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpraeS93s49rmd1kZDvuXYzfliilQPLwx12q41PmwKf8KhKxnA9KphXh/lBtapuFhz217jFwPItivrB@vger.kernel.org
X-Gm-Message-State: AFuF++n4tzdqH381bZm3q1uJhW4B6jVW+Np6/3fyBVbq9lTBYNi5fs0Y
	hsTQiIRCSowIFir7Nk6Boj0tj6zIo7b2/MsNc5vTHQVJo0HrICsQC60c
X-Gm-Gg: AR+sD1049pgjfWj62zmSTLcTfkGe8moPFNg2PIGISCqj8gwITn6OBvRlwnAefEV0IrY
	MJBSia3mQBw0PleuJ6MmQ9D4NZAM4apQVwQar3TSbhw9m+bktp0u6gvLpavFJPAToJh0JboyQr1
	XVJlEml+PZ76MOUv0+dz5CvdfzeAzFEp6/x7DByAImX93W8N2x0Gxym+D1j0+0yf+FSUK4gC6dv
	BBIhaDJGWxPTrazYIoD9MPvE5tfUFBCvOqjDrAcb5Bet4j2yfxlDxsVQ5TUKLC0fJX8fwDglO46
	/pSAVJuMC8vOQh6tBdgdpHvnH8ddixZ7wYQ99ZtCKIdXqD0AvBowk8T4BDIVY+5OJpEuGV5ouTD
	UjG1x6LO7UNviJ8w/RMuEBU40jR4w9RdnPKkHfvIbrB0X8zt19YCcD5Uu3+Z8MbrugTw8WSODVj
	bnA3hm4aChoPCy4DoGtEARvoAIrGtyeVPdPIrLNkKKVdtDSg5NFE3FFwa6+sk6BhPeQkVQhCVdk
	DkUVb14Og==
X-Received: by 2002:a05:6000:3c5:b0:481:4fe2:ce55 with SMTP id ffacd0b85a97d-482b1ffd595mr11674656f8f.21.1787160009175;
        Wed, 19 Aug 2026 10:20:09 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e54sm7638119f8f.11.2026.08.19.10.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:20:08 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC HDMI codec
Date: Wed, 19 Aug 2026 20:19:35 +0300
Message-Id: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OMAP HDMI audio driver currently has no way of reporting HDMI cable
hotplug events to ASoC. As a result, user space cannot detect HDMI audio
availability through the standard jack mechanism and audio policy managers
cannot automatically route audio to or from the HDMI output.

Add an optional HPD callback to `omap_hdmi_audio_pdata` and invoke it from
the DRM HDMI bridge whenever the connector status changes. The HDMI audio
driver registers an ASoC jack and reports `SND_JACK_AVOUT` state changes in
response to these notifications.

Also fix the disconnect path by taking a runtime PM reference before
updating the CEC physical address.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi.h        |  6 +++
 drivers/gpu/drm/omapdrm/dss/hdmi4.c       | 29 ++++++++++---
 drivers/gpu/drm/omapdrm/dss/hdmi5.c       | 37 +++++++++++++---
 drivers/gpu/drm/omapdrm/dss/hdmi_common.c | 14 ++++++
 include/sound/omap-hdmi-audio.h           |  1 +
 sound/soc/ti/omap-hdmi.c                  | 53 +++++++++++++++++++++--
 6 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi.h b/drivers/gpu/drm/omapdrm/dss/hdmi.h
index c4a4e07f0b99..a79d4590611f 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi.h
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi.h
@@ -15,6 +15,7 @@
 #include <sound/omap-hdmi-audio.h>
 #include <media/cec.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 
 #include "omapdss.h"
 #include "dss.h"
@@ -368,6 +369,8 @@ struct omap_hdmi {
 	struct drm_bridge bridge;
 
 	struct platform_device *audio_pdev;
+	struct mutex audio_lock;
+
 	void (*audio_abort_cb)(struct device *dev);
 	int wp_idlemode;
 
@@ -380,6 +383,9 @@ struct omap_hdmi {
 	bool display_enabled;
 };
 
+void hdmi_audio_hpd_notify(struct omap_hdmi *hdmi,
+			   enum drm_connector_status status);
+
 #define drm_bridge_to_hdmi(b) container_of(b, struct omap_hdmi, bridge)
 
 #endif
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index e306247ed8a0..e0e077397b77 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -433,8 +433,15 @@ static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
 
-	if (status == connector_status_disconnected)
+	hdmi_audio_hpd_notify(hdmi, status);
+
+	if (status == connector_status_disconnected) {
+		if (hdmi_runtime_get(hdmi))
+			return;
+
 		hdmi4_cec_set_phys_addr(&hdmi->core, CEC_PHYS_ADDR_INVALID);
+		hdmi_runtime_put(hdmi);
+	}
 }
 
 static const struct drm_edid *hdmi4_bridge_edid_read(struct drm_bridge *bridge,
@@ -626,12 +633,17 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
 		.ops = &hdmi_audio_ops,
 	};
 
+	guard(mutex)(&hdmi->audio_lock);
 	hdmi->audio_pdev = platform_device_register_data(
 		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
 		&pdata, sizeof(pdata));
 
-	if (IS_ERR(hdmi->audio_pdev))
-		return PTR_ERR(hdmi->audio_pdev);
+	if (IS_ERR(hdmi->audio_pdev)) {
+		int err = PTR_ERR(hdmi->audio_pdev);
+
+		hdmi->audio_pdev = NULL;
+		return err;
+	}
 
 	return 0;
 }
@@ -688,8 +700,14 @@ static void hdmi4_unbind(struct device *dev, struct device *master, void *data)
 
 	dss_debugfs_remove_file(hdmi->debugfs);
 
-	if (hdmi->audio_pdev)
-		platform_device_unregister(hdmi->audio_pdev);
+	scoped_guard(mutex, &hdmi->audio_lock) {
+		if (hdmi->audio_pdev) {
+			struct platform_device *pdev = hdmi->audio_pdev;
+
+			hdmi->audio_pdev = NULL;
+			platform_device_unregister(pdev);
+		}
+	}
 
 	hdmi4_cec_uninit(&hdmi->core);
 	hdmi_pll_uninit(&hdmi->pll);
@@ -770,6 +788,7 @@ static int hdmi4_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hdmi);
 
 	mutex_init(&hdmi->lock);
+	mutex_init(&hdmi->audio_lock);
 	spin_lock_init(&hdmi->audio_playing_lock);
 
 	r = hdmi4_probe_of(hdmi);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index ab2d4eb6787f..3828eb3be6f9 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -425,6 +425,15 @@ static void hdmi5_bridge_disable(struct drm_bridge *bridge,
 	mutex_unlock(&hdmi->lock);
 }
 
+static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
+				    struct drm_connector *connector,
+				    enum drm_connector_status status)
+{
+	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
+
+	hdmi_audio_hpd_notify(hdmi, status);
+}
+
 static const struct drm_edid *hdmi5_bridge_edid_read(struct drm_bridge *bridge,
 						     struct drm_connector *connector)
 {
@@ -475,6 +484,7 @@ static const struct drm_bridge_funcs hdmi5_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_enable = hdmi5_bridge_enable,
 	.atomic_disable = hdmi5_bridge_disable,
+	.hpd_notify = hdmi5_bridge_hpd_notify,
 	.edid_read = hdmi5_bridge_edid_read,
 };
 
@@ -601,12 +611,18 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
 		.ops = &hdmi_audio_ops,
 	};
 
-	hdmi->audio_pdev = platform_device_register_data(
-		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
-		&pdata, sizeof(pdata));
+	scoped_guard(mutex, &hdmi->audio_lock) {
+		hdmi->audio_pdev = platform_device_register_data(
+			&hdmi->pdev->dev, "omap-hdmi-audio",
+			PLATFORM_DEVID_AUTO, &pdata, sizeof(pdata));
 
-	if (IS_ERR(hdmi->audio_pdev))
-		return PTR_ERR(hdmi->audio_pdev);
+		if (IS_ERR(hdmi->audio_pdev)) {
+			int err = PTR_ERR(hdmi->audio_pdev);
+
+			hdmi->audio_pdev = NULL;
+			return err;
+		}
+	}
 
 	hdmi_runtime_get(hdmi);
 	hdmi->wp_idlemode =
@@ -654,8 +670,14 @@ static void hdmi5_unbind(struct device *dev, struct device *master, void *data)
 
 	dss_debugfs_remove_file(hdmi->debugfs);
 
-	if (hdmi->audio_pdev)
-		platform_device_unregister(hdmi->audio_pdev);
+	scoped_guard(mutex, &hdmi->audio_lock) {
+		if (hdmi->audio_pdev) {
+			struct platform_device *pdev = hdmi->audio_pdev;
+
+			hdmi->audio_pdev = NULL;
+			platform_device_unregister(pdev);
+		}
+	}
 
 	hdmi_pll_uninit(&hdmi->pll);
 }
@@ -735,6 +757,7 @@ static int hdmi5_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hdmi);
 
 	mutex_init(&hdmi->lock);
+	mutex_init(&hdmi->audio_lock);
 	spin_lock_init(&hdmi->audio_playing_lock);
 
 	r = hdmi5_probe_of(hdmi);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_common.c b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
index 3ecde23ac604..e9adc5775913 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
@@ -147,3 +147,17 @@ int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
+
+void hdmi_audio_hpd_notify(struct omap_hdmi *hdmi,
+			   enum drm_connector_status status)
+{
+	guard(mutex)(&hdmi->audio_lock);
+
+	if (hdmi->audio_pdev) {
+		struct device *dev = &hdmi->audio_pdev->dev;
+		struct omap_hdmi_audio_pdata *ha = dev_get_platdata(dev);
+
+		if (ha->audio_hpd)
+			ha->audio_hpd(dev, status == connector_status_connected);
+	}
+}
diff --git a/include/sound/omap-hdmi-audio.h b/include/sound/omap-hdmi-audio.h
index e5f82044a404..8dca92360ee0 100644
--- a/include/sound/omap-hdmi-audio.h
+++ b/include/sound/omap-hdmi-audio.h
@@ -34,6 +34,7 @@ struct omap_hdmi_audio_pdata {
 	phys_addr_t audio_dma_addr;
 
 	const struct omap_hdmi_audio_ops *ops;
+	void (*audio_hpd)(struct device *dev, bool connected);
 };
 
 #endif /* __OMAP_HDMI_AUDIO_H__ */
diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index e60f5b483fc5..90ce12a81246 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -17,6 +17,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <uapi/sound/asound.h>
 #include <sound/asoundef.h>
+#include <sound/jack.h>
 #include <sound/omap-hdmi-audio.h>
 
 #include "sdma-pcm.h"
@@ -35,6 +36,8 @@ struct hdmi_audio_data {
 
 	struct mutex current_stream_lock;
 	struct snd_pcm_substream *current_stream;
+	struct snd_soc_jack jack;
+	atomic_t jack_state;
 };
 
 static
@@ -262,6 +265,34 @@ static void hdmi_dai_shutdown(struct snd_pcm_substream *substream,
 		ad->current_stream = NULL;
 }
 
+static void hdmi_audio_hpd(struct device *dev, bool connected)
+{
+	struct hdmi_audio_data *ad = dev_get_drvdata(dev);
+
+	if (atomic_xchg(&ad->jack_state, connected) == connected)
+		return;
+
+	snd_soc_jack_report(&ad->jack,
+			    connected ? SND_JACK_AVOUT : 0, SND_JACK_AVOUT);
+	dev_dbg(dev, "HDMI %s\n", connected ? "CONNECTED" : "DISCONNECTED");
+}
+
+static int hdmi_audio_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct hdmi_audio_data *ad = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = snd_soc_card_jack_new(
+		      card, "HDMI", SND_JACK_AVOUT, &ad->jack);
+	if (ret < 0) {
+		dev_err(card->dev, "Cannot create HDMI jack: %i\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup	= hdmi_dai_startup,
 	.hw_params	= hdmi_dai_hw_params,
@@ -371,28 +402,44 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	card->dai_link->stream_name = card->name;
 	card->dai_link->cpus->dai_name = dev_name(ad->dssdev);
 	card->dai_link->platforms->name = dev_name(ad->dssdev);
+	card->dai_link->init = hdmi_audio_dai_init;
 	card->num_links = 1;
 	card->dev = dev;
 
+	atomic_set(&ad->jack_state, -1);
+	ad->card = card;
+
+	snd_soc_card_set_drvdata(card, ad);
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret) {
 		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
 		return ret;
 	}
 
-	ad->card = card;
-	snd_soc_card_set_drvdata(card, ad);
-
 	dev_set_drvdata(dev, ad);
 
+	ha->audio_hpd = hdmi_audio_hpd;
+
 	return 0;
 }
 
+static void omap_hdmi_audio_remove(struct platform_device *pdev)
+{
+	struct omap_hdmi_audio_pdata *ha = pdev->dev.platform_data;
+
+	/*
+	 * hdmi4_unbind() holds audio lock across platform_device_unregister(),
+	 * so audio_hpd() cannot run concurrently with this callback.
+	 */
+	ha->audio_hpd = NULL;
+}
+
 static struct platform_driver hdmi_audio_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = omap_hdmi_audio_probe,
+	.remove = omap_hdmi_audio_remove,
 };
 
 module_platform_driver(hdmi_audio_driver);
-- 
2.25.1

