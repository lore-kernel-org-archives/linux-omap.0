Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6433F367
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2026 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772322; cv=none; b=ct5qJEA/RfiOt83ZRREG9gENTMqRp0YToWHeoppgjGYz6vlQiENGdiAq5GboQFKqcnRzq4lXBHTHwur3R66oSuzxoSe+hzK3UNdCVR58gaE1l01p1uid357HbIrl0MeKJn6YhyDlkyeEFFcXYWQSgkj5sukAt13b1LatfzDBt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772322; c=relaxed/simple;
	bh=mmQYKq0BtbnhjGj+y3pRQrqUdvpr5FKLB4mQEb4XQEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sCOVBfxhI8jtrGHSzOVK/v1rawH9CLsrfPrt0FAB5xhymYnCmXWKpzMU45FeJ+MnEaWspTEkCtnYaPCDto3UlxBDjMSOjpGg4HYjHdsMJdal1C4+4heYDwJGpBIjuv4+/q/9aCAnMIHVogRmb8oAPd2e+xoqLxRi5BD6cPhiD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YG54WbSo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YG54WbSo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2997509a91.3
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785772321; x=1786377121; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C2QcaSW8eE8D7RoBuOICkCFr3KzY/Y5G0pSnKbTuZfY=;
        b=YG54WbSoXICF39S1+t66F6y/+MCv0UrjumGb0XH0Z6A1m9Ua1Wc/XRIllON1gNlN25
         v7fLXSADUMkljyMDeKMsmdmGiiascBB6ZuJ0Z3+iFxWlbDmtxaKFqai040DaDeUfoXeK
         SQvrEb+JBa6sbGZk0wJph68LzIddMf73KWOwkzG9x4idvuqDPxpN+mC1TIqKb+Qszcru
         /L70ck9TDTm0HgsqET7cPzpGefrc1z8HsU4VCylTI3P0SuGQLU9xlMEXd1yUNBahuRGv
         iF4+S7xltfYOvXgGAKSZT2thXICzZKuFnf+E67rg/XbYBwiWFihtdxjwE+VnxpAV/5mO
         UJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772321; x=1786377121;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C2QcaSW8eE8D7RoBuOICkCFr3KzY/Y5G0pSnKbTuZfY=;
        b=QkyxKcOMs1JJCuqsGXRCqv7dzT/9rIoQO+sQXAIp6fYUkQRlaQlLl4NXSI40dU/9lr
         4qr9jfxCjYpUvRHDs9IuhVXmUZk2qGnAsmZOKx3vXcr+GahnR0CUNPmrY3ANw6e8PCIJ
         FbhkIw27EpZQKhQFQunUmetjPBXeSOeiBMs2c1E8JdIGSiYKND7Py9yo3gWAEs7TxVRK
         5lq90ZkiQndZFk1eC/Yzd2faaKOoJMoMEsBFDt68ZpKi9Nb6CbpLZxVEPE4FjthwzhFu
         qCViRMnNbdkVCCFwvFcqYm/3YIOt3FORoG/vu3HHh2AO2P5ntOProU/cKHrSUinozWG9
         k6fg==
X-Gm-Message-State: AOJu0YwRqtc53DoIk6eTJYhJOJsLgqsMbpbHU7NOzzslcoSJcg6GBiyb
	Qy8h7iQjxfJwqlV13cj2p0i3p4u1XRxNMV5GptBCYDBgrnXeXQcmaKKFVt/6zej3BE0=
X-Gm-Gg: AR+sD10jq6B4yaUfemdHyrsacHvxK81OBSN+lbJlkS7y9q1kh+Zos+sWNVzYa9z1by8
	GBy/muE5GxrfJgb8KZK2lkfgHTyAOpCZpxweCiIiGBm2fHDmsMubvnkyJ5DxxrIoApucebY5cfW
	G9peQgv9B/MpeGP/3hHaELFMSQY/vs3xVpC14qAaY4jUmMP3ydW4MtiXlTluMV7GRcFEMAkVO8D
	bmO+Cd0uWuqvUANX+SLxuHQrQ/lgD+nkb+UznVNiJ8uWLcaLbe+aVb4poxr3aRs6WrPndVQY0On
	7SzzXGkOL4h+2Gif1EwLgvIQuAjrxQBN+r/9K80px4yZupe4dxOGQjDpCvTp4eNDXQNuexzwdHa
	71SJ2U4Lo4DzZiQXdgibZquIYQd+cAFZn/xZf980/2dk/yEfKdWGuqrWRROBjxvLILTGc17ykph
	dejobHbo2qjpfDGMPFX2wW5DFUr2Xpm1qhxDYNT6SmvOHG+Hm9HYckFjr+zg==
X-Received: by 2002:a17:90b:4b85:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-38fbc4a1328mr9585476a91.18.1785772314020;
        Mon, 03 Aug 2026 08:51:54 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-38febe2daeesm42905a91.0.2026.08.03.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:51:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] soc: OMAP2 updates for v7.3
Date: Mon, 03 Aug 2026 08:51:53 -0700
Message-ID: <7h5x1rjj6u.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.3/soc-signed

for you to fetch changes up to 76103814279724e5c98b1c16a730f56ebede9f74:

  ARM: OMAP2+: Fix OF node reference leaks in omap_hwmod (2026-06-29 13:13:52 -0700)

----------------------------------------------------------------
soc: OMAP2 updates for v7.3
- minor fixes

----------------------------------------------------------------
Mithil Bavishi (1):
      ARM: OMAP2+: Add CFI type for omap4_finish_suspend

Yuho Choi (1):
      ARM: OMAP2+: Fix OF node reference leaks in omap_hwmod

 arch/arm/mach-omap2/omap_hwmod.c | 26 ++++++++++++++++++--------
 arch/arm/mach-omap2/sleep44xx.S  |  5 +++--
 2 files changed, 21 insertions(+), 10 deletions(-)
