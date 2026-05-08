Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4543D0905
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236734; cv=none; b=R7hbgu+xY9yfIpwMzitjpqERNUxvMDUbrkKhzt5Fzort6T5/e9fFNrl0jB+HZstvXNy2gdbEfja7nsA4QZlK5AH+zGPy+z8ppuBW4NgBitfwLDMj+XzNF+2UPlJRIsJRx6g80Q0tYuXHByFN27C8pFynaDP85t9HDP33BPf9p2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236734; c=relaxed/simple;
	bh=6OqTH0hYqu74jsj3Hyhqf0/kStXynlWfF9E7YDa08mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6J6nKl0rB0DLKdlJ4ilgcWvtj4a1GrozdNNn2E9WZshdhcKy0z3QG7nc4Blmsn/oJUYWGM/BVhLDCDxXVRKz38itF/nFaeey7d+PUmclpPvJ0tPqvDqKGNCQaB7CAovPuDBS+wV+EVzxA/h2F3GTf3vIY8ij9PLrrGyZe66REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuaSxrIR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuaSxrIR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9f316d68so8973545ad.2
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236733; x=1778841533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6m/SKf2PyFWZeQKqRQhBbnBBScw1UjxM2ZPFwBwR5Y8=;
        b=NuaSxrIRN9i/pVsjWES0egal3fVIHzug6rNh0Qa5OMl++CWDuwOEBO7t60K2n05ii9
         eslsiRC9Tl4eXd1Q8YYLrgZlKh/zY0I1KRubLqGsUIAtaM0J6L7LqY2667Y0wvALa/eG
         Sut132d3X9VVGcPQ02mM4ouHTnAIXuSrnGGIlOzxzC2/fL31UHOMkBsqN9oDc3NboYs+
         2tLrhJOEX2M8WDAIujyxeQkXwY73qMVRE/2NmZ4PaLymn8Lu6Ayn35+FFpEOonq1iWvn
         iI156vd+U7CH94Zg4H78Ubor+EvJSetPYqJiv0EJcDYtBcUaRaVsDkl5rQDGdWKxjHt0
         fD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236733; x=1778841533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m/SKf2PyFWZeQKqRQhBbnBBScw1UjxM2ZPFwBwR5Y8=;
        b=hG8OwbjaONIVxpTTESc0RIigk3gKL00VhYf1m0QVpxASq7MigIbGGRdPtzCMDatCMD
         CWLJn6mMZlNZpc4LxEfT5q07LR0JhRDiC59MkZG/KoNOVaYTM3SZSTWekz5VbEw1QMGD
         VI6PYYNb1d0mCN4SJJzpdQpGzKSwORgkpuD8660hpd+QKYAm8wsiWJqnTez/7eBJf/8L
         3XuSyHxFYhXAF2wR1T1J1IrMmOEMo948iWqU+UV9+FrIzH53F7/+nRQkrOES8LnnY/1K
         4Ox5yOEwDnLDiv2oZZb8uv014BLLDpY69J7KfBGFGc5TpDnvVuyZBCh69jIUG6rioF3v
         na5g==
X-Forwarded-Encrypted: i=1; AFNElJ8F3HEJdSGpqJmLu4tN7Qbsci6Vgrl7IK+Me/gw7C0kus/mXNxApnrcbTnmLefzQiNkpXOtUytKofAE@vger.kernel.org
X-Gm-Message-State: AOJu0YxUL6Jgz20MHvKkn2xZ8CMAxGCvKe0t80T8sGMttsnXXzi2Wtfl
	llVz2OA9S4cdnFnAqElSMBm2AlnNo/7ImWL5deys9rrSTID8Ipg3I13k
X-Gm-Gg: Acq92OFdVKcZLJDFe1qPIMEAab6ItTDnvh1zg4GGnnSsQroGjIJOJMIP/Kd7JVqKjMH
	zKhvpZEDnlLID6WPfJo/LS5lDYVj4np49TocEaAk9mxq4D3df37cYfIGlFeoBDYgjIrOY3FkeWg
	QzOlNYG3ql2wzM4GEMBD/Mjpa+9E0i51qvqbCEpudYsdV0eH/ZuPQ7qtmazvwFG6N0sM/qWolOH
	QCOI6KcAYsmWGPCpx1Tj5uwPiCTXP2jRJK2LXmrX5PgdeMxHRCIzQkFu5cFwMWWITPi7E++Xee+
	tKDtMohPMUgkS7N/vWDicjhHzfgxcouIwBenlwo9+ZjJE1hfOLqYm+34Tqbi7UmJw/Ocvb0RiXX
	L4EqkQYmopAV/TNeip9/rRAzTHMnTagxK4QEj0aFC7Rzp36BNmRPGerJF3vyQeK/fH7zbDAjGbJ
	i0yq/Hal8Ht54TegI+XhftNr6KEA+n+a9i+w04k3bDmgnIQVTiK1Rcqlqw7w==
X-Received: by 2002:a17:902:ca85:b0:2ba:4086:ecb9 with SMTP id d9443c01a7336-2ba798d564cmr82193185ad.36.1778236732792;
        Fri, 08 May 2026 03:38:52 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm18309345ad.1.2026.05.08.03.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:38:52 -0700 (PDT)
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
Subject: [PATCH 0/7] ASoC: ti: Cleanup locking code using guard() helpers
Date: Fri,  8 May 2026 17:38:30 +0700
Message-ID: <20260508103837.138142-1-phucduc.bui@gmail.com>
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

This series converts mutex and spinlock handling in TI ASoC drivers
to use guard() helpers.

Most patches are straightforward conversions to guard() helpers.
Two patches include minor cleanup changes in the process:

omap-dmic: Simplified omap_dmic_dai_startup() by removing the
temporary return variable and using a direct return path on error.

omap-mcbsp: Modernized omap_mcbsp_request() by using __free(kfree) 
for memory management. This ensures that memory is always freed on 
error paths after the spinlock is released, without needing manual 
goto labels.

No behavior change intended.

Best regards,
Phuc

bui duc phuc (7):
  ASoC: ti: j721e-evm: Use guard() for mutex locks
  ASoC: ti: omap-dmic: Use guard() for mutex locks
  ASoC: ti: omap-hdmi: Use guard() for mutex locks
  ASoC: ti: omap-mcpdm: Use guard() for mutex locks
  ASoC: ti: ams-delta: Use guard() for spin locks
  ASoC: ti: omap-mcbsp-st: Use guard() for spin locks
  ASoC: ti: omap-mcbsp: Simplify lock and resource handling

 sound/soc/ti/ams-delta.c     | 26 ++++++++---------
 sound/soc/ti/j721e-evm.c     | 25 ++++++-----------
 sound/soc/ti/omap-dmic.c     | 44 ++++++++++++-----------------
 sound/soc/ti/omap-hdmi.c     | 18 +++++-------
 sound/soc/ti/omap-mcbsp-st.c | 26 ++++++-----------
 sound/soc/ti/omap-mcbsp.c    | 54 ++++++++++++++++--------------------
 sound/soc/ti/omap-mcpdm.c    |  8 ++----
 7 files changed, 81 insertions(+), 120 deletions(-)

-- 
2.43.0

