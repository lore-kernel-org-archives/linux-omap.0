Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773C3CDBB5
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192931; cv=none; b=ZRfIl3izAKJulpt0HzYi22icjkTgnJkKxLqzUSh+4jQLP03OqcE44VvRMhQ7XFjQ09r3X35TmoBkPySNZd0BqEyqxy+8jK7BDOzbCii9QWNKjjRvk7eemvVpn4V86c83vTq8q72bbByIC27mbV21ItPaZtAw2pP4LaGnQH+z+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192931; c=relaxed/simple;
	bh=BGRxIGzV5F2amCG/5z64SRgI5hIKfJeXA3e3Pz1V9yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtC4M/LolJRSArEFFD8k0YwTdXlrk6KQIDY2i51nGgmRu7EILhZf/vlkqg5gzGXkOzajbG3ovgHqvPeA5SWYVBiBTdn0+LMu5Oa4PKdRV3Th+gSL92fBBaeCbDdISIcRiEaLdbwBnMbZqGV3HGI3ZlJtE3tkRTN0l7bDWJJB79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOT2DqDG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOT2DqDG"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so2406715b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192926; x=1784797726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLJXUpxY0UPS6/a7VhqudDZufGgCMV4Lpojx0iuFHFM=;
        b=QOT2DqDGb0ON/Kv7/v8Ht8h6BwMIe3mAgChFAt0o047LISvudnKH86S7pfFIbw+nx+
         7ImQHb6fj7BSxX9OKUoQ1RQTMXH4E3sCO50EpmiDJ2lSoQiq0MPuOxF2V/dQuOto4nt2
         FMJGojNGuq+IUiDldM2u4+s0bGVNhHJhnlFuZ+A7qFVIaRwjwF7CaLIT5TcCQCE8gHiF
         rkC3tG59gzXVtr68r5WZwVPWq8eocq4KmAmMbPrVXPrPLTw7VLbnHxXtz0B5c5zSKjxD
         gCztIG1kZ4kwCjGyWIOhvHzVceF+Cr9UDSFqKRTxcbguzUwMhLAq6UtP7O4puUoBt78D
         G7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192926; x=1784797726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLJXUpxY0UPS6/a7VhqudDZufGgCMV4Lpojx0iuFHFM=;
        b=FkArSM/AckyU0K8DJzMjBVnqZhiQR9OQiSMWU6SB23bXFZFbPq/3DOInXb32aA1L1h
         icxYiElgtJAtcCxne5xpQVTzpJZtm1XeouE5kd5m0nH7dKpokMCbtqKJcJFpxBWxQ9Pp
         0K2QNNPLiUAS2b2OCj3Eswb4m8oUJSVxTSADiMNN+tMIYTGl2tFlKpehjNfv8n44GLPT
         gje+B4q0ovW3ZanbKLeZlUQ4RFvtpgFubuGtpvAuhbX2CIb68hqKFkoh34JbSAJSzahs
         PDqRreRpb/z7T20tUKHrVwZ34Iz03OvhDLQBIF/hY6s5bwSkYDwbAhQzwf5G7JlxnCCA
         27Xg==
X-Forwarded-Encrypted: i=1; AHgh+RoIuUNAdnGJrdr5wdsk1d97HrFGsL2Z3AwRKOFmzH/CDKHMyi+4IjCn1JxYu59mN/Aaz4GvATHVaGtz@vger.kernel.org
X-Gm-Message-State: AOJu0YyESoaS8paN4sT1VLJGx7NqkPcdB2+SpyP/q9hMHczRsBTdVWWS
	jGmHPm6wMsxGLIGeyOKFLZPhkqxCf/Bodacqby5xgjcKW5ekyMZ6Qh2k
X-Gm-Gg: AfdE7cnLLxsuo2OAwLshfmxvhVUoKRGcdEpjBZYdfItfs1HI/L8u2JEsmUP9vsJ1c8i
	YkcTsfdtc0Pw3BqaVkF6W3CH2vi7vcFSUIl3K5i8DQiLbVXpZfSbMNYUp26y4nvCjXSfOFvBSNd
	EVSUDM1dZUq8GF5Q81dZGUS+H6Q6jOwFEH3/TdqXFmbG9/XxUuhidZQwV4Y58/EiaIjEzytteIn
	vUhZa+G3QtEMrkJoQamuLztg6F5al6kx+OuoU7kKvD/O+ZbQ8mWn9x19CZfkh/BPq33cbsnyH5x
	80oupjRqg/o2Ty6sZ9XisJSVZoJzoMiXZ/XZYlBcfLGlColaFyJ+8ENo5rxlzCH2EI/llilM6rL
	k16G9WMian3AyzF9nv5VDE46rk7P12otjTJWGzJdITWDBRtJaeu+CDvIBZPwR3nGEiqC9OOWtE5
	TTnu+d/WYPgu8TmD3VBJpVupj7tWuvlZPtXwDs
X-Received: by 2002:a05:6a00:bb88:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-848897d3008mr19810146b3a.35.1784192926084;
        Thu, 16 Jul 2026 02:08:46 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:08:45 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 00/10] ASoC: ti: Improve probe error handling
Date: Thu, 16 Jul 2026 16:08:19 +0700
Message-ID: <20260716090829.72082-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series cleans up probe error handling across several TI ASoC
drivers.

The changes fall into two categories:
 1.Replace dev_err() with dev_err_probe() when reporting probe
   failures. This preserves the original error code while suppressing
   unnecessary log messages for deferred probe errors.
 2.Preserve the original error codes returned by helper functions
   instead of converting them to -ENODEV, and remove redundant error
   messages where the helper already reports the failure.

Build-tested only.

Changes in v2:
 - Add missing parentheses to `snd_soc_register_card()` (Christophe).
 - Remove an extra blank line (Christophe).

Best regards,
Phuc

bui duc phuc (10):
  ASoC: ti: ams-delta: Use dev_err_probe() for error handling
  ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
  ASoC: ti: j721e-evm: Return the original error from card name parsing
  ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
  ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
  ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
  ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
  ASoC: ti: omap-twl4030: Return the original error code
  ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
  ASoC: ti: rx51: Use dev_err_probe() for error handling

 sound/soc/ti/ams-delta.c        |  4 ++--
 sound/soc/ti/davinci-evm.c      |  3 +--
 sound/soc/ti/j721e-evm.c        |  7 +++----
 sound/soc/ti/omap-abe-twl6040.c | 15 ++++++---------
 sound/soc/ti/omap-dmic.c        |  7 +++----
 sound/soc/ti/omap-hdmi.c        |  6 ++----
 sound/soc/ti/omap-twl4030.c     | 15 ++++++---------
 sound/soc/ti/rx51.c             | 28 ++++++++++++----------------
 8 files changed, 35 insertions(+), 50 deletions(-)

-- 
2.43.0

