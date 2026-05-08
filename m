Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB713D1709
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236748; cv=none; b=Zr/cMN9JCOven9VtpjWv0e7J9W39PXfEw8FAHAgPcLfUpABu6GWDc/xeCt+Ov+p1uw+AijbbcA7BOeTzM69KdDpicp+ihRmNtrm/Cboi2DffkbM1zsm1CVLF/5v1SsFRSElL6P18WtTxfiV8zcg6IUkfa0TxisAMBsu7ueiA8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236748; c=relaxed/simple;
	bh=+Cat/hrzlP9TQa7q7VLyIEo3Rx45NIuQaGGmUTbrMPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCLMaO4Pj9hz6NCbzr+QWDvUFic2DkTgskNFvaIV20Zi0sU0RESU3SdFgT0aJnM1QKacsYDZmKA8n7DowijdmaGgQBKHaCUWW81d4X+/tUbhhu9FeN2HxgqME6fQgH/7S7RVMwfQlrYtKaUFdsJZHwGcpi4okAUfMlGMWFrHNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFtEicd6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFtEicd6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366070f71adso1586184a91.2
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236746; x=1778841546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1fF2g2fGUgug/smobxh1GYiC42PEqoDgJD4+eh4r10=;
        b=IFtEicd64JDkJNoYlJd6jHifz3oo6kVZqVS16EvYhL5af1t8Dmv4e32Gz8m/+I9Ewu
         eJTsJ9fEdBVqTPppqgUKQFM+l7yHk+2OQZwn7GpNPQLX3dKODCpNLQnPjgReVOtHZ9W9
         sGKfUS7eInuPJMuNVijeb3XDfksgc3tGDTk/V0sCa2Dli8+Crl/hrvrw5PU6fL5rM4ti
         kZyRKBjd7DTYgxM0ndfgTy+WIi2pXSQMgVdQf3gjhYWHcJWmJgMqutA3onmfptZRFLd1
         mNKDnnY7z7Vxvt1IbML51QNazfME5GAh3qfk2TrH1z7eSEQ9IyFayJXWV0WV+54s9DnF
         OSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236746; x=1778841546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1fF2g2fGUgug/smobxh1GYiC42PEqoDgJD4+eh4r10=;
        b=hTIkSbqX2VQfA+IU1VRugBB9RtIKBmu3dSZ+M2wZ3/r/05XKjLiDlDzgKPPS1hQ9Da
         Idq3Il1l86jIcsO7y+c1It5QeZej1lp3s+89q2vU/tR2agvRCX2Bb1+DnA/29mPhJM51
         tKdJ+40PxnmUkAhhWLDb0I1X98vKF6SFwMDFJ/vndbjsZ6IG2A40tgPQxsO6z8MkUeCU
         takJIIEZRgFatm1Mj2pZb+G7aS6rFxgTLemxldapZDrC/KAHzW6Q0hZII9l6H2KDZXhJ
         2pzo1WgRrPUWfzsUs0msPNWrlAjkDakC4aGxLLaMa7pKf32oUVq/ysxu3MZRFyMjlOZm
         JhKw==
X-Forwarded-Encrypted: i=1; AFNElJ8L2BizZGlyVyiwZRv76WKcjirMO9+Ggr0+sCzecVYQNgNPFFXxKgDv9XMTUVsX05sbQawf82h9V0iL@vger.kernel.org
X-Gm-Message-State: AOJu0YycYESXTYtBaJljZ0MSCtgtbXM8JBy9cARqyCjuP3MhRSEl+13s
	8t1gKwFyAXUwjEuwoAxPcnf+VQCEDSoS3Ueu2JfpkEsGfw5w2Kvvl7STj5JiqA==
X-Gm-Gg: Acq92OGICUm6s4u8QzbTBGyL3TQ/kySZwQTvFQUlDC5SnviZi3RblvIieq2mfPqZIJs
	M4eviwHZAnrmKBZ/maCFbZg10kWYdN4T3ANOj6c4G+ADmIybUabqAE5nrbge/e/sUwrdXOfWmWj
	XOolYcz55tb3QPtYiWIbl7Vmyky7+xUlqkVQZy5pi2h7Hw4kTTf4aE9Gd9xai0w/czlyBJB1w1v
	VLpmY6dD7veq4oAEztmCwGQ/E3tYfim9ajsjDCHteiX3BaGcLTDEhPkJNfXehtbkf9mFhBGf+88
	OQE6Sl3KNSpErUP/9exOK2ZpZO3zvy/8SvQ9BXnQxbisOlZkKqHorZNk20YV4hgQNfzVi/URQWZ
	giM4gOxgS/RX2EL1386DGHkO0kYH3iBNK/K9u43vD1hS8/YY/DZQEiK4z08UeMXuVN1CJ1Noh5F
	bwEkMxqZ7lbl8qZ3R2GPepoCDVbrMU+ZqSm43DEnPnCUEN3JqTA2VUhc3+wg==
X-Received: by 2002:a17:903:1b50:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2ba794bf96emr121392205ad.14.1778236746201;
        Fri, 08 May 2026 03:39:06 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:39:05 -0700 (PDT)
From: phucduc.bui@gmail.com
To: peter.ujfalusi@gmail.com,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	jarkko.nikula@bitmer.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/7] ASoC: ti: omap-dmic: Use guard() for mutex locks
Date: Fri,  8 May 2026 17:38:32 +0700
Message-ID: <20260508103837.138142-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508103837.138142-1-phucduc.bui@gmail.com>
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Replace open-coded mutex_lock()/mutex_unlock() pairs with guard(mutex)()
and scoped_guard() helpers.

This also simplifies the control flow by removing temporary return
variables and unnecessary goto-based cleanup paths.

No functional change intended.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-dmic.c | 44 ++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
index fb92bb88eb5c..dc92fdb89a0f 100644
--- a/sound/soc/ti/omap-dmic.c
+++ b/sound/soc/ti/omap-dmic.c
@@ -91,18 +91,14 @@ static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
-	int ret = 0;
-
-	mutex_lock(&dmic->mutex);
 
-	if (!snd_soc_dai_active(dai))
-		dmic->active = 1;
-	else
-		ret = -EBUSY;
+	guard(mutex)(&dmic->mutex);
 
-	mutex_unlock(&dmic->mutex);
+	if (snd_soc_dai_active(dai))
+		return -EBUSY;
 
-	return ret;
+	dmic->active = 1;
+	return 0;
 }
 
 static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
@@ -110,14 +106,12 @@ static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 {
 	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
 
-	mutex_lock(&dmic->mutex);
+	guard(mutex)(&dmic->mutex);
 
 	cpu_latency_qos_remove_request(&dmic->pm_qos_req);
 
 	if (!snd_soc_dai_active(dai))
 		dmic->active = 0;
-
-	mutex_unlock(&dmic->mutex);
 }
 
 static int omap_dmic_select_divider(struct omap_dmic *dmic, int sample_rate)
@@ -334,26 +328,24 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 		return -ENODEV;
 	}
 
-	mutex_lock(&dmic->mutex);
-	if (dmic->active) {
-		/* disable clock while reparenting */
-		pm_runtime_put_sync(dmic->dev);
-		ret = clk_set_parent(mux, parent_clk);
-		pm_runtime_get_sync(dmic->dev);
-	} else {
-		ret = clk_set_parent(mux, parent_clk);
+	scoped_guard(mutex, &dmic->mutex) {
+		if (dmic->active) {
+			/* disable clock while reparenting */
+			pm_runtime_put_sync(dmic->dev);
+			ret = clk_set_parent(mux, parent_clk);
+			pm_runtime_get_sync(dmic->dev);
+		} else {
+			ret = clk_set_parent(mux, parent_clk);
+		}
 	}
-	mutex_unlock(&dmic->mutex);
 
 	if (ret < 0) {
 		dev_err(dmic->dev, "re-parent failed\n");
-		goto err_busy;
+	} else {
+		dmic->sysclk = clk_id;
+		dmic->fclk_freq = freq;
 	}
 
-	dmic->sysclk = clk_id;
-	dmic->fclk_freq = freq;
-
-err_busy:
 	clk_put(mux);
 	clk_put(parent_clk);
 
-- 
2.43.0

