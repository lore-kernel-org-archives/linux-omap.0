Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F473D16F6
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236741; cv=none; b=dX9Wk1Q4rN5jdJNuZ2haR4gxVrSWdI4TCOZ5HTxJQQXcWT1xIQBvot3ftvtGmY5qQ0TPOqdrjtfi392CCl0fxjLLIPE6vXMRqGvbRNpvaAijIWODo9j8Om2q+Z4HdGmim0mnr04Gh1FcdmiWhYt2XN2GIvCaSOxetU1V6Cvkh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236741; c=relaxed/simple;
	bh=HbNQyIOQfmtYFfsohHgbl06rBm8HI5vxHjV4u7D/pL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy0jaE3hiA+pahihHOx6lhFs5WcmJ/C1YewcIl0Qa5n9e2HbQkLZXRl+l9IdG6wYkZknIafvvI1IURTrVnypCA/yWNlLC6AbpLlI5ojp2jl81Jctv2q/PoJjpP2eCgs4Q8u1bp39+vZw36Kl+x1jZem8C8iEdKK7uG57PIp52N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSm2BeKT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSm2BeKT"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso731088a12.0
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236740; x=1778841540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PHyrKnEx3Qw34k80dXVEjulQeqN21vdCRBwPpUnfZM=;
        b=lSm2BeKT660yA44NPx2nyf9g5J5GJHqFaeqswpB/sEFyZ8N2YEHpVxCChnytMoGX8O
         Ewl5Ax9OmaQ7SvJqooq6IrCy6C7sp48KjuWwPDJvh6pRNN5z02PXL09R4uvayu3sKOTt
         FbfqxTpyBZBZLnlTo++wbzbCtkW4iLGFf/O98sI5GEesb86opO+lpF66hCFevsApkdm+
         e06URc/XVDLPE4IVIcmu7pa2YOMWMDsPxCd7s2Do5QZyamx4JI6QBfARjINTJBluuAZq
         iJUAky4HaDwHEWhT4nDQhryTVmssZ7IXie0v7GkKds1QVQUCk9WyoNbmAeOaBdJ/lreV
         HO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236740; x=1778841540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PHyrKnEx3Qw34k80dXVEjulQeqN21vdCRBwPpUnfZM=;
        b=amb1GxJ+uNfI06bYOZ75hMzphZy0M25s105Wrv+3ND0C5W1OPElFMV57FVgVSE54Nr
         zQ6HoxtHHXNcXm7HTkaQ4CyGdKyFx69ALdIf3HNH36kAKBCPuGxmjSP4m8/KVC/Qwr5z
         Tc++RNXBUvc50CAVhPMunr54dlGpDmcYRR6bUJc4+YfWP7wS+TvVvL4EktPK4fBkpxGv
         YdO00yrrcmp74FwhVpJl3EtJnron+iVOE6AqZ6vatz/pibal6mwdv0vaLWn8kP+d77Bb
         KZBq+0DXjsPW1BX7/cTdAPHXdmSVe6IiXoaVcSLZ6ryES2ZdKbOdNThoDimt+SW702po
         PdEw==
X-Forwarded-Encrypted: i=1; AFNElJ/UFDIWcJNrAPpXEBEjGDP9H1joeHaA7vyqizsIkR5LrVH7/DIP2HrW3C1gsVFV4PfRhbQXrfjGNHJx@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlq8ZbQsQzhXg/5VwwUZZ2fkmhd3Sicd+XgoxiwSqOkpaOgbZ
	yPqdZ7G1aFV8ZVK8EK571+cR6CodgNkN2i+N9YE/MCmDcTSgyutcyry+hgqUlQ==
X-Gm-Gg: Acq92OEx+AbyyqTrri4WgRsFzgk081ww/yQCKjQ7CmLVMiB3bCgpM8YaUkv3dNLyNuv
	ojb7TN99G5Z1cDhEa2I1g+KhIxfsnwPBJ9pgJFLFSLT9Y3XLCkVAaJEk5FncASetGmc6eG8Ot5I
	2jFERmdVgwR7bjMubbBoKYzn+hEg1Vtat3k5vaita4o2uEtXKqzXgQlnQU9ltS4puge/JNJlDuJ
	9AZTbClvOgCTcJBxTDKzfVkRiRWpX4aLTgdLjotzHg2GFIrPrnSDT4a+L7s+uYMY++negB0fGq3
	X1Mx3XTVeFyblNEQJDOCfMWhB9/Ta/F8Zg9psHghM0qLe2ydZWtDALzARnsh0uZ2Fn+lKIkiOOr
	17Ipkv0SrwTVqAIvwt0i8mj3red2UPVLsgPsquzzwmp8rzNNnMY1C6f8alzUpC16WxLbijdTi+4
	t+5gEabn1da3Jznws9OCxCftHhqDLMPYBHAUmDliBDfvWkmZp9gWwrqXtj2w==
X-Received: by 2002:a17:903:1ae6:b0:2b9:edbc:69f3 with SMTP id d9443c01a7336-2ba78b4bcdfmr118316335ad.9.1778236739848;
        Fri, 08 May 2026 03:38:59 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:38:59 -0700 (PDT)
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
Subject: [PATCH 1/7] ASoC: ti: j721e-evm: Use guard() for mutex locks
Date: Fri,  8 May 2026 17:38:31 +0700
Message-ID: <20260508103837.138142-2-phucduc.bui@gmail.com>
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
 sound/soc/ti/j721e-evm.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index faa62c1a9b8e..8a3333aa32ee 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -263,7 +263,7 @@ static int j721e_audio_startup(struct snd_pcm_substream *substream)
 	int ret = 0;
 	int i;
 
-	mutex_lock(&priv->mutex);
+	guard(mutex)(&priv->mutex);
 
 	domain->active++;
 
@@ -303,7 +303,6 @@ static int j721e_audio_startup(struct snd_pcm_substream *substream)
 out:
 	if (ret)
 		domain->active--;
-	mutex_unlock(&priv->mutex);
 
 	return ret;
 }
@@ -323,30 +322,28 @@ static int j721e_audio_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	int i;
 
-	mutex_lock(&priv->mutex);
+	guard(mutex)(&priv->mutex);
 
-	if (domain->rate && domain->rate != params_rate(params)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (domain->rate && domain->rate != params_rate(params))
+		return -EINVAL;
 
 	if (params_width(params) == 16)
 		slot_width = 16;
 
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, slot_width);
 	if (ret && ret != -ENOTSUPP)
-		goto out;
+		return ret;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
 		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 2,
 					       slot_width);
 		if (ret && ret != -ENOTSUPP)
-			goto out;
+			return ret;
 	}
 
 	ret = j721e_configure_refclk(priv, domain_id, params_rate(params));
 	if (ret)
-		goto out;
+		return ret;
 
 	sysclk_rate = priv->hsdiv_rates[domain->parent_clk_id];
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
@@ -356,7 +353,7 @@ static int j721e_audio_hw_params(struct snd_pcm_substream *substream,
 			dev_err(priv->dev,
 				"codec set_sysclk failed for %u Hz\n",
 				sysclk_rate);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -371,8 +368,6 @@ static int j721e_audio_hw_params(struct snd_pcm_substream *substream,
 		ret = 0;
 	}
 
-out:
-	mutex_unlock(&priv->mutex);
 	return ret;
 }
 
@@ -383,15 +378,13 @@ static void j721e_audio_shutdown(struct snd_pcm_substream *substream)
 	unsigned int domain_id = rtd->dai_link->id;
 	struct j721e_audio_domain *domain = &priv->audio_domains[domain_id];
 
-	mutex_lock(&priv->mutex);
+	guard(mutex)(&priv->mutex);
 
 	domain->active--;
 	if (!domain->active) {
 		domain->rate = 0;
 		domain->active_link = 0;
 	}
-
-	mutex_unlock(&priv->mutex);
 }
 
 static const struct snd_soc_ops j721e_audio_ops = {
-- 
2.43.0

