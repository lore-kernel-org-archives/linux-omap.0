Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2ED3D3308
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236756; cv=none; b=YcH5N/lqp3auN7PGl0YSc+3svNMQak8yt4k+SX6FFsTlpeuph9OoJ+S4q9eWgT5OTFyt89Wm7+/bTttZdGvPHF8wg+QSR+vAlMX9HNkzRMeY7uUnITJG8A4yqq/QqxMJQOmb45TGH4gDmAXVSQFB/HzMjbRyGjtCiqAPyKc9DYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236756; c=relaxed/simple;
	bh=28cWvZt5+LjVRFYTpiBD7lWC/PI7kpR5cnKEpuPnDeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGEJ3Rc747juM0mRWofa2vDL+hA/GsEuInh543zPbkMQsZfJtcm9/Xc/GHR6iDtsez/gi6SIDv437pO0ywtq3ttN35cvLiSqBwLOfW6Z2s6XaoAbOXInT5y5c9zXx19PS38AGgvkUxNaa3w5G+HFDcNFrWMob711tVgkk52VKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V19QTynV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V19QTynV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b9705613ddso11906205ad.1
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236755; x=1778841555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtY4fEpkcKI43PjOB3u+OACOnE6yg3XP27IxAIRobhU=;
        b=V19QTynVeUXGSbFe+O7PxceLr/8yFzhRaI9E/+g/caoKcIUP9syDHEtl1jAsqu37v4
         R0hYO8et/WL/u/bfW9XLXLfbVPPMO2hOSN3QeYuGD+enOf6sbTVmcEYXmfgPj9x9XRgI
         96ei9MzmnkZ2zbT/XMGYVxQwfT8D26bEZFiWYNFPPgZ41yPwfqM5dxRd41O4ijUFuZ2y
         TvCNKf3znkCW38BJn0DYWD8CTroWH8EjdB3AbLeb3voXC9wr27kLNJzDQUEzLKCKkdW3
         aY4xg1lRr1AiMK6rVAv5OFiNZU6JoPthiZ7jJGuXOXzrSXaCmSkm5/TseviWSNthVj8U
         1jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236755; x=1778841555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtY4fEpkcKI43PjOB3u+OACOnE6yg3XP27IxAIRobhU=;
        b=A7LEG+tCXEIxX1dQ1fg7UrsNDhzAZclpTzXgu3/7MvhGb3pYy5NWo+6HmLUrbiMsuW
         ovcG3mmNYyx773dcPcZKueK/PK7U/dFuMo6HuNEXibswP88uV23f4u2LU1R8h8eLVnT0
         V6DvVBt8fxQjqD91fFayVWXVj5+ZmKxKN+XIDiml/Rq4OaYnO60NoftcsnXy4crbTZ8j
         k2kciZXdwVYSyBVp8AlgV6y6mrU9FweYyqcKk/7VijFHXvuf/+WvciO4e4wnpfNckmYp
         9mxaDsiC0yY/wWhlY0xdDJoyzNkHYQQwGpeXTqSSGgsGssSsbkPOEmk7IVrn7vyZGStu
         k6sQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Resx3lCDR+3FB9zx+DoghUYJ1q36SmEyBVCnwOhjP7VmKqNcpGdiguJAnbMfJJNu9BeQv0NeEWZCv@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDhITk4Tpks9LX6++cebCM1vSx1MFxIOIEAI0ubHTrY0d2ZqB
	rnCCCCjlJ9ZjSDM2h9p6TwQV1iKlNqvB4tAUG0NwEYrHKxYU6uJ/nYaB
X-Gm-Gg: Acq92OEpja0vTUIMu9KEduQn9Z4/Y/aoyCsZF703G3al9qQHRAqlX2hs9naxqfedS6Q
	EOpnmYtoNW7W+6ryR2VFxzx3Vdv098a4WHHfViuON1IW95hQ28xdDfLf/GSAKYFB2rjLf4sWcET
	m3geIQU4LdOfgOZSYkLzGQpfkXx3SfM7eddIuLSAA5B477VresGvXcOirHVS6yTUDFzLS9jeUEq
	U/KcFBBqtLs74DvJP+RAIdCX/vm0Pu6cJ9eHpovgDVRTXuPe5aGTRZY8fIi22RnmP8A3aZ1N8IE
	OsWBnt6pV5NlSp1olLVdzBJiAjfxYNCiY6AJWCtS6k6zr2Z/zuHffh6jarLE3lOMrrGTpHXlXC+
	71DG6nUO61AAtZZVI/OeBEw91EllK5b0G+g/Btu8aqxWIY6hXJ9ZqWw/raZ4yU7IT0nF3NDX6bU
	PMP7gmVMsPB+9s+lG6ZslktIs88S+0xfLWU7VWkda4qDXsrC8flt7Xe69AIhyuXL1qdOEM
X-Received: by 2002:a17:903:2ecb:b0:2ba:2581:36bd with SMTP id d9443c01a7336-2ba798c26f5mr125067205ad.21.1778236754856;
        Fri, 08 May 2026 03:39:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:39:14 -0700 (PDT)
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
Subject: [PATCH 4/7] ASoC: ti: omap-mcpdm: Use guard() for mutex locks
Date: Fri,  8 May 2026 17:38:34 +0700
Message-ID: <20260508103837.138142-5-phucduc.bui@gmail.com>
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
 sound/soc/ti/omap-mcpdm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/omap-mcpdm.c b/sound/soc/ti/omap-mcpdm.c
index 1a5d19937c64..c7d7b502f120 100644
--- a/sound/soc/ti/omap-mcpdm.c
+++ b/sound/soc/ti/omap-mcpdm.c
@@ -251,13 +251,11 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 
-	mutex_lock(&mcpdm->mutex);
+	guard(mutex)(&mcpdm->mutex);
 
 	if (!snd_soc_dai_active(dai))
 		omap_mcpdm_open_streams(mcpdm);
 
-	mutex_unlock(&mcpdm->mutex);
-
 	return 0;
 }
 
@@ -269,7 +267,7 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
 	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 
-	mutex_lock(&mcpdm->mutex);
+	guard(mutex)(&mcpdm->mutex);
 
 	if (!snd_soc_dai_active(dai)) {
 		if (omap_mcpdm_active(mcpdm)) {
@@ -287,8 +285,6 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 		cpu_latency_qos_remove_request(&mcpdm->pm_qos_req);
 
 	mcpdm->latency[stream1] = 0;
-
-	mutex_unlock(&mcpdm->mutex);
 }
 
 static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0

