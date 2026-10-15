Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDC4A6CC2
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059827; cv=none; b=rCIwxueGTiTj7QyORfFRmzVE+m+rwINnSURr3u6URAThHcrOnYEXEh8qk7x3LHT5qirvCdECzbjzP6q3s+3L3iIZyN/1UIEv55YTMRLzgK8z+YbqJ6vzky+oejYd0TyRPF4o0uEXfaXC9aQCXKAL+UyrcqRSe1aMsVqielYSeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059827; c=relaxed/simple;
	bh=Bh3H+LUzhkBIffj284EKBCnhxWAGkIa9mZwra3fm6Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l690MnEx7l/q8SfjqU+oGxkXYCmXWEmqBBJ0Pz6wiVcKA1TKV8z7PaikOiA7j09LsVRPxHxbU/BvLHW0veWB8BY58TNcf87Fuiyxcxg6JtBPOj8v1DNLcxg1l13X3AqUnnhNFqWMZLOOn+2ZBxNw333wbIR5pi7tIxoHVoYyvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfrdo/td; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfrdo/td"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0d19cf7eso4612663f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792059824; x=1792664624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZ03ahkbPaO+GKHMEmL3lRce7EgYgsIUaIYhnRWAhmk=;
        b=Hfrdo/tdsAywdEJ0Q4zjR8LTvZIgQv4p6Red3MzTMbjAGQnbomDXgdDanktGnLOwrS
         XMkfH0kSWZ/iNk35Bhdt9gx4hpj/Av1NQ1gIT4QXCHWtsqr7GCAwp32PZ0Y2Wj+3f4Dx
         /vgK/rldv8A2F1m07xa4XeBQ33MdmdwEe/Av/lVUSNRDGa5nGO4xJ6u86nLByp71P3+5
         KkV5O3yI1aKvOB7d9VXaDjzI931rZp3Cpimra5JC8Mp4h54RhN2WW8ohscaxoAD84W7Y
         vTbNzf2cl4BegJqxS4fg+SRKprf58/9xgHihvaDS6iuF35vOgma0HP9ku9x1GA64bSkI
         gFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792059824; x=1792664624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZ03ahkbPaO+GKHMEmL3lRce7EgYgsIUaIYhnRWAhmk=;
        b=RxbCju7R3MCbfdDzbOt9g9z9WtqsrLHnVM2CNIs+pbNZ7/bDjzNzZRt4NjCRRnIHfv
         6siwL7rHo1e8sxheAE8wdttIgpinNLESe2YjGzAeTuHqkP1rkPGE5pZoDv8VxobtiivX
         COd2fe3b35ROSeEPgt1aRypb+d3AA2EhKRGT2uB+Zc0QSzNZQJrBjNC/fxApWq0528cZ
         evtTv3X9vFW+LxCUYy9orAllrMFib13pfd12n/fzTSDsmBCt3l/+C/4eXzI7py+iX7VY
         zLr12T9WB6gKkhovPMuJ7Kj9sNJ+r9RwPoo4Rca9ed0f38pmUnmm0KYwEwuU6uYGmpRU
         g2Sw==
X-Gm-Message-State: AFq9FYKyiM8BsWeLC3QHlSFpIJpd0Nsb6zlqtBwd7xTjSQIT7lRT6xUC
	GmXJ+uRY2mTmoL7nMMJShTrKNU0WWJRX3TkFKkVy4Pg+OHxy8C7pqnTL
X-Gm-Gg: AYBFou2nZwjqoEEoZaa+8c8hyJSf45Pn9BF79sMZPv0hGs5q/Hddxp14NwHl3feLyBb
	KDTtDkDANAyEyNxPG3xNqB187NAXmN/rTW3zodBY/RXzCdlc9AgzhySLUbEnS3FuZyVQq0ylbzQ
	dQcYP60SE6Urgk/w3GtIUveqfk4enjY9okRGsknREUionhrjVrIKL7SfGsX+zekZ/t+q5/6hy8q
	Lg3PEpO3ahDstLsBYaAEbsnJwuGzrXXeU/7i+r8xpgETwLP2QuXck12ss/+tSuuTtAcSt0jmYFo
	YLTE5aEocJSohcSpWGdA+V9RuF/fOct+HbGBzKHOR4pTIco1xJfFtQWP5qmzTokDZTxSs+D3zpu
	jsj+lK8AyN6yD7lw7Gu5kAx6lZvVikZv8tCWF6PFRBlEhpYQzt1hHEaSKiYifD9QvLmWO+3z1Ag
	ikoR06NA+mVUhjVWGjKwr4bW5d4t5a+6+XcbhQwKXfL9t8FA56UT2lSnIT02S6OZGcRtTiMfSO+
	zjffQyEe3BlEmTjkmQ=
X-Received: by 2002:a05:6000:2dc5:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-48dbaaecd68mr35443212f8f.13.1792059823690;
        Thu, 15 Oct 2026 03:23:43 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm14952542f8f.32.2026.10.15.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:23:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] mfd: tps65910: Use modern API for poweroff and restart
Date: Thu, 15 Oct 2026 13:23:18 +0300
Message-ID: <20261015102320.23760-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to modern way of registering poweroff call and add restart call.

Dmitry Osipenko (2):
  mfd: tps65910: Use devm_register_power_off_handler()
  mfd: tps65910: Add restart handler

 drivers/mfd/tps65910.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.53.0

