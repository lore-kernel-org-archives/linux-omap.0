Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F33CF696
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236752; cv=none; b=Ifzl+g4+DoVoxiTopPgvxs1ivnOg7ejujlTSrcPJtVr9ea/azrsuDvwMTZ1MUMVo0McSkajlgJMqvhuOcuhUEZjXfRO+wc29dEVekMwkSI4PrVBwpwGLQnoT1oxhZ+x7sKS+oeewrZvk9LAjQCVgE9em7egIRnDlt5238QE2sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236752; c=relaxed/simple;
	bh=IDfulofV8L3pjBAwtb/03nHXAYUcs5a20eJyXfotbwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyljfyfEizATOBpfPZ7NPLEz9l63XI/BzDorzPrq7OAb3ik+YajxIXbnFlUN/Rutxm8I9/Blqw6jERvuFB8zKFHdve8AI6FVahnnQOMRxlEt/Th1l3tB1xngym6e5zmbS/P1WTqEv04Hqt2QfJcb9q7UMitL1PdcBGofcEH/YcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HADUq02j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HADUq02j"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba21d32776so13178795ad.2
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236751; x=1778841551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zKyR5U1yAXuf2WaMek/cM/qR7vazFRcQvHEtxImguA=;
        b=HADUq02jxeyeOIveZd7w7EYwT6G1v3nrgHsV69x8oSiWWp3JiVtiokQQFF7jGH4HfN
         HLVTdYpn4UJ6nVoyXCPxG0FRcKyZRu76H6/xx23OV0Lm5WsoJbVrF5adVXji7UprChJK
         isi3VqYUkJePRvHkG9kznDKJWJQwKSC5I2P/COoy2EB3yTJOT4krTWM8zDLsGR9hkJWY
         C20HB3EPnKyDvLMaYLYhLE36BevGpLS+OabokUsgoen81CIeVPLof0cw99aLsradV/Vs
         4yw6cir6cPBP/CHbiyUpcBawdQ8eZ7lt8segjYnT9NtLDgI9NuXeWI5F9PYH+WTrDw6p
         2xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236751; x=1778841551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4zKyR5U1yAXuf2WaMek/cM/qR7vazFRcQvHEtxImguA=;
        b=PZpNfMXzIZmteCgj4AXE6Xp8Vu8Fu846CguMrYcKXMSaGberWUsghlceVE15wleicB
         FZ+y0/1nZGf6dAI1Gv+XmMxSLi++wfxC/pP32NKlIOTM+Sng3oBbn8Gz4Fjao/I8R0Kx
         HyPRVPqCUA9Osxp1c/xyG0QDRtkYz7JYz9rQZz6QlgiI90EfIbKK+xcAIdmfj0pzY/tt
         FPnstHqohxbf+E5kyq8tFjwRfD6clglapOIGf2Odp+wiNVkB5zJEc1qcvYhT8UkmHEFm
         xDTuyTl2kZWGL3xFWyJ2vTc6g2pHSgQyHdB5aibuqMKdt7PE/hu1CyPvyN5ybNL/bVD6
         jZOw==
X-Forwarded-Encrypted: i=1; AFNElJ+2iOZaYmXDUSADqQgPvOIDWr+ZEZktbfCTDiaVmxlvJpknVuYK0GEZECrGgiH+w3C5/w386Dv9i42a@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJL3/GjWDSZoiKKGR6NQc9TORsHlXfiJV0EVLUIwIhapM4Ju1
	Zj2icZCT5IRliSNUpFly1P8OnLApip2JrHZFiMw9T7TU1psFZJXdirxu
X-Gm-Gg: Acq92OGWZCpe7AfjoGISnH0YKTjnJU73fIE66sSYhr3UOzYSPGBkha7QkciXxSHYNsJ
	4xtuHmdTA+kJmZ9pdmZwX89BMpuN25LTMqAR+rbyx544LiQSLFVcOpWwoi/TwfKrrRs33tsuvyk
	2X3VHq7ma5Y86oxNjZLfVhwCCQ0Yb0C+w4DfrSLakhuBF/407eCX3I3gRIla8IE6xTohBorVLdB
	zJ4YvAwmlHl54kKdmUZyagU1OWLJrpmWoy6dHTAGRmhMQGsaIE9xyiNkZ1T9l27ZL84aGvKaVcK
	kGS4bQJsSXAgINaiNXI4cnX2nZvkwy0Jd8wj9tLrezn09VUAAZKdGIYfhsDq+d2lLW/+pFQUoqf
	eoMsFLWouDhMS3L872wP34jtI6CCuGeig+q7cAE2B+ItjlgGGcGtvNPzkaE4RlSJH1Cgb7iIO7t
	lhBddL5ObMw6cV077kYN+3t8azYQrhsplVPLoBMXqDJc8/KhME4ox025UrNQ==
X-Received: by 2002:a17:902:e98e:b0:2b4:5e65:5d0e with SMTP id d9443c01a7336-2ba78c40260mr94019615ad.10.1778236750894;
        Fri, 08 May 2026 03:39:10 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:39:10 -0700 (PDT)
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
Subject: [PATCH 3/7] ASoC: ti: omap-hdmi: Use guard() for mutex locks
Date: Fri,  8 May 2026 17:38:33 +0700
Message-ID: <20260508103837.138142-4-phucduc.bui@gmail.com>
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

Clean up the code using guard() for mutex locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-hdmi.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index 55e7cb96858f..e60f5b483fc5 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -49,7 +49,7 @@ static void hdmi_dai_abort(struct device *dev)
 {
 	struct hdmi_audio_data *ad = dev_get_drvdata(dev);
 
-	mutex_lock(&ad->current_stream_lock);
+	guard(mutex)(&ad->current_stream_lock);
 	if (ad->current_stream && ad->current_stream->runtime &&
 	    snd_pcm_running(ad->current_stream)) {
 		dev_err(dev, "HDMI display disabled, aborting playback\n");
@@ -57,7 +57,6 @@ static void hdmi_dai_abort(struct device *dev)
 		snd_pcm_stop(ad->current_stream, SNDRV_PCM_STATE_DISCONNECTED);
 		snd_pcm_stream_unlock_irq(ad->current_stream);
 	}
-	mutex_unlock(&ad->current_stream_lock);
 }
 
 static int hdmi_dai_startup(struct snd_pcm_substream *substream,
@@ -86,16 +85,14 @@ static int hdmi_dai_startup(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(dai, substream, &ad->dma_data);
 
-	mutex_lock(&ad->current_stream_lock);
-	ad->current_stream = substream;
-	mutex_unlock(&ad->current_stream_lock);
+	scoped_guard(mutex, &ad->current_stream_lock)
+		ad->current_stream = substream;
 
 	ret = ad->ops->audio_startup(ad->dssdev, hdmi_dai_abort);
 
 	if (ret) {
-		mutex_lock(&ad->current_stream_lock);
-		ad->current_stream = NULL;
-		mutex_unlock(&ad->current_stream_lock);
+		scoped_guard(mutex, &ad->current_stream_lock)
+			ad->current_stream = NULL;
 	}
 
 	return ret;
@@ -261,9 +258,8 @@ static void hdmi_dai_shutdown(struct snd_pcm_substream *substream,
 
 	ad->ops->audio_shutdown(ad->dssdev);
 
-	mutex_lock(&ad->current_stream_lock);
-	ad->current_stream = NULL;
-	mutex_unlock(&ad->current_stream_lock);
+	scoped_guard(mutex, &ad->current_stream_lock)
+		ad->current_stream = NULL;
 }
 
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
-- 
2.43.0

