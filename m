Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7E3F5BDD
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932068; cv=none; b=evR2FdiRaIX2LoyiV/n31+HGoJBWS4OMwwPsZsBdw297kqPx8sbD9jqNbKFUgK/INFn3sQiqdqQGXlAtbWLAy3qbkHzRj6rJNuhq8V2OL2zE2vxO61ZBky/3dmFc7KjcEKRRK2b7IpkmW1sol/hyDa3MTOSAnqU5STqtA9el4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932068; c=relaxed/simple;
	bh=wdhOAdFxJCsMSsg4Ys+Hv3MlG04dDJlFHq7OT79fYHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNBrzQ+GEHjkK2ejzmyOGehMg3Iwcq7olR6lyA2nJyXu8lZPk2OUjRnvY/GWktO73Y+tRCnEpqfXqYjtWxyTRonU2TTf1aV7jyeJJmIV5Ru694f8nWYbAAu+0mDA6HyxoL8NYz355P+10PjdYkpQX9RhoeC3mI8ExSepMkJNCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SoDKc4df; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SoDKc4df"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so1528343a12.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780932066; x=1781536866; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sIsYTLOZChveT9EMnGezeFDSrrYGoEXKFgVmBYHPNH8=;
        b=SoDKc4dfoXh/VcapcGUkIIzN/9PxIbmvVLfC7XYrhlLQFCAkbCoWaVIHgHiJdgMR6m
         7ssf+o0KO5wiB7DOIA/XffiHaXx/yHInzdT/eD1KsZorxXDByK1SD80Bf57vNR9fPH7J
         yPl8VNDt3uLU/HXPjctIC6rw+yfsOU7NazchMTxp6ejiCwyMihLMbBxXtXkqRHTU/iDB
         lCZtOg6UwrTnTQgRYKcJjkBEzsHtfwxFEiWV42EWOVaXWoM8G6vYxPPYQHwf02Y2h/JD
         XRQH9txHPKKUT7lx+6UQSzfGU+q3kHUGO2VBjgBKgbcq/nb/UmiYC33XCpSjdCGwrg+T
         tPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932066; x=1781536866;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIsYTLOZChveT9EMnGezeFDSrrYGoEXKFgVmBYHPNH8=;
        b=MUB0JjQgU/KAQj5NGHMlwerDAP0nEfO//JOEYk2jigIQMo/VqRCjMlB08O/+oXiHAQ
         ZQRQT+4OtHwjmM5SO0Y19LbTigUiibopC23nqeDtlV90+eNPu2k9C/Wasn2sNl4MUxQB
         LZJK7wElHJdZyFblJlxt+5XPu/kCqzog+F/m9hyH9GZFUgvUH756Rb/lM2lrw9bMNe4Q
         vPg4200HIRrY8c400PLIWraWHMd7O9xs0ttsnyEckFcqij/zNfWJVtbFoS857YJQHttC
         LrQcvUqR6zcQVLq4QnM7a0yW+XxDTQZRI4Q7nm9ZFKPIG58+9ZVxFJrH9BliWjlIXdVC
         E3cg==
X-Gm-Message-State: AOJu0YzbOP2FBfS4s8j1EF7heizYFsaSr3djuxRtWUawunaT1rJmMkzF
	N5HD6dWJCxOLpvzrmIuUNLEGweamL1NDHnjZIL3I1R9Pt/6XJ3Bj47k0ymFgHqjfAFc=
X-Gm-Gg: Acq92OFTRXFaE3TfcPlxGoE8LpJrgXw51DodDgeUklVEpg1JlfiXvxT25tyXlhhQQKJ
	Dl0MyqqYdemzsMU1OuCpVDr/QoaU7F6vS1EHyYHW/YDpX97aWYHJ+2KWqcNyP78ZgSM1R0vOvpy
	eqg4xwdblxmt0g7gqQ99yYEOqfe7y5YB2jqKiEljHET6TALix+0B3JynoPNNrmkl52NHBIyZiuq
	PhKjU0Usa8WtK2rsmHSnmq2H3G/I1EKRZQp0SIG+JwrchvIHgQI91BLD4jXiy5xED7TPHJ7lsr1
	LU9ClqZgZKBUBQ7zFF3fhrktmYOdK3lTaXZmgobH94I6nUBOEhzpgoMQrPV2EvwQLIeueMzzjjA
	+BascssTP4YEMYlWLLbA/WZakKdVPH1QnMLcZPk5Cqv0rmRo1UOHZR4u+ffH2PHUMl4OyTPi5RU
	Ypa3ha1p1bIN2gEoGYJJuZA4Yiz52Fwz8=
X-Received: by 2002:a05:6a21:70cb:b0:3b1:882a:607b with SMTP id adf61e73a8af0-3b4ccf6ea30mr17584603637.22.1780932066451;
        Mon, 08 Jun 2026 08:21:06 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c85df0b2ddbsm15543247a12.24.2026.06.08.08.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:21:05 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: soc: updates for v7.2
Date: Mon, 08 Jun 2026 08:21:05 -0700
Message-ID: <7hldcpm526.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.2/soc-signed

for you to fetch changes up to 2a7a9e20b9e8b5dc4fdef777e67d390dcb3a8ea4:

  ARM: omap2: simplify allocation for omap_device (2026-05-11 09:51:01 -0700)

----------------------------------------------------------------
ARM: soc: updates for v7.2

Minor update for omap_device core code.

----------------------------------------------------------------
Rosen Penev (1):
      ARM: omap2: simplify allocation for omap_device

 arch/arm/mach-omap2/omap_device.c | 29 ++++++++++-------------------
 arch/arm/mach-omap2/omap_device.h |  4 ++--
 2 files changed, 12 insertions(+), 21 deletions(-)
