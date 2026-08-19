Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EC480953
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153292; cv=none; b=fP14O6XfiATKmBnAXHw9V2lo3BkXCxmkoiz8PHSxnV0YwF7HmMo7nMBEsKVEWfmTucs20q4ahNOuUXqfHrd48C8QuYbACsAh0qsZ8swlMUSRdtSZx9raYWN7fq7ADZX6FypgP7NM0cAbMuZTTP76KP+sF9e4GkEUsvv04gFbdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153292; c=relaxed/simple;
	bh=B6Pe+yxzn2tORwlGVgICYqclGje223dLGMWCyG3CUKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOxCnEB7r5aeRUPwgfCmvE9mHYb8zdZ32Q+SsQKWGQTFX3c/LGnjrEAaq/TBbqXWBetR38bzCLPRnRkl/9B7sPELkh2GF2B7FZPrBhysSiRhs36/ULq96aFz0t6DacGl+ujT/j92LMN8bX7ood31ISq7KAUwfo7SlMXXq46OH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHB5S+P8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHB5S+P8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4998590d392so10937095e9.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153288; x=1787758088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4O6b3uVfHCg73+g5tRn+qNdLjjRqVvCx0BGFx/lfSs4=;
        b=nHB5S+P8s6L0hwgs2eskR7Qb0ovG/qGQO0LekhYpAornmY/UteQ0PtifbijKNnEE3r
         7/YEW3gWheq8NqFkm5Xjm5bNHKl93zCGMSh/3fh/gs2WZ2lSA3Ab46dwr4KRlTaeL+ll
         o44J4J2JZagjbD4JrvjdBW3AsdB1cuqUQsS9hQKQT7z8S1trXtVBZfGo5k1bIz6xAFzl
         L3hX3r+3JWl75a7cHPvFZeEQy+9Cl7WGO+puZ7NoqhumVtKkUMayMKdTLEZEZn0022ZG
         LHevfINcJGH7iVztzLMNhBTlf44mDjknlck6V4/kdnLZHDw8Dc5l3jZbB6Aihtea7GD0
         PYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153288; x=1787758088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4O6b3uVfHCg73+g5tRn+qNdLjjRqVvCx0BGFx/lfSs4=;
        b=TG4R1XJbrKs1u1hj2O2axO3TB7Bht3fD/RgL1uDUYV3p639Ov0rza75RPKDl0RUBih
         htb8bXbRavPyAy2qIRXxC4+2+DVMvF/zUlXnMuMU45IlCAU6ZWLZT95tt6b1pfvRPk5e
         tK2G+97CsroOtqdaRticqBd0u9Bi7w/zGOcgguRRlzXYJUa/o1+M+bl8Asoyh4kChnTw
         apyX6d+bMA9DJMQwJTqG0z7Qo3lbyClGduQK8lmOQ932jVYJTmRRx7wfKlWVDiB0YwTN
         X2PakgSrv1ibZPZpoqjZENWU1/PKpuELNvEU8FunWuadZU8hxTbSaCoMd5NkOecoiwwY
         FzKg==
X-Forwarded-Encrypted: i=1; AHgh+RrPq9RCH2dGVY3Z+lYa7KaP2nug1vzDgZU9+JzpLtJRkf5WDjcJKu0a/5JD+lIroaec7ZWTuLleZE/+@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqn4NDK7YlKWLzReruI0Of89qyoVmtkvmpJ5wuQsc5WN0Spo9
	K1KyYVOqrjd4F3LMQba652FwBtPXBG1IWBvyie/oCSlspK/YJ4rC7Bu8
X-Gm-Gg: AR+sD10+lcGV2fSrDp88z8Ldvrw5IPhiXH/dW1Qz33pJhIggoVtfxDpsyoeXc5WDJjS
	uc+b8r0rmvJGxnX7Top1G5BVCUZ1M84V6AxncV8PwjBaLnvbFAORNGXVdR4o3EQh/IzZg4KOxKm
	dJihut3aEAeJ+HN4f4bd2s7zhNW1j+IdMYKpoCma9hBrwIyZFNl2ym+k7TNK8PoJT4n5EZpmmKI
	xgfKi1Uas4B8wVOZK3kmOVXPeMZB7XH5yc40CE4mPB9ikLbIvqbpljm3G9Jmfa8Z4TK7WfE+9j+
	O7jIFJ3c8E9xxfqdVYGMQMJzPliuNN52atcqEjcpOsw5TYvKH+/GYJlSyZsyhfFICtMhKExHPs8
	gDVJpAnCHI+5cCZWwFAAoUpHBFryZEAOl9cBiN1aBmPCE+TXr4Q4sYjAzTQGpkOcBvJy1wTnTWe
	FHBo5zyMl9yPpGWSBdPnWzZ0IFBSmeONNZ+6EucNgPiaxelcVz1hdeAN8z7E9AosCyz6wuVPcRE
	Wf2H2Z3pw==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499aa20c7b1mr95860655e9.15.1787153287944;
        Wed, 19 Aug 2026 08:28:07 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9dff4c1sm47667655e9.3.2026.08.19.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:28:07 -0700 (PDT)
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
Subject: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC HDMI codec
Date: Wed, 19 Aug 2026 18:27:55 +0300
Message-Id: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
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
 drivers/gpu/drm/omapdrm/dss/hdmi5.c       | 36 ++++++++++++---
 drivers/gpu/drm/omapdrm/dss/hdmi_common.c | 14 ++++++
 include/sound/omap-hdmi-audio.h           |  1 +
 sound/soc/ti/omap-hdmi.c                  | 53 +++++++++++++++++++++--
 6 files changed, 124 insertions(+), 15 deletions(-)

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
index ab2d4eb6787f..76aedc1c9ba1 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -425,6 +425,14 @@ static void hdmi5_bridge_disable(struct drm_bridge *bridge,
 	mutex_unlock(&hdmi->lock);
 }
 
+static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
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
@@ -475,6 +483,7 @@ static const struct drm_bridge_funcs hdmi5_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_enable = hdmi5_bridge_enable,
 	.atomic_disable = hdmi5_bridge_disable,
+	.hpd_notify = hdmi5_bridge_hpd_notify,
 	.edid_read = hdmi5_bridge_edid_read,
 };
 
@@ -601,12 +610,18 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
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
@@ -654,8 +669,14 @@ static void hdmi5_unbind(struct device *dev, struct device *master, void *data)
 
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
@@ -735,6 +756,7 @@ static int hdmi5_probe(struct platform_device *pdev)
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

