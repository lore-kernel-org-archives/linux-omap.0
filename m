Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05806346E70
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107309; cv=none; b=PNLt9zmlozBpo2ES5hjw9It3T7QhSzfGQ3QQMmUrLBhdGZXwT72kzx5BzRgAI06Xb8pfCIy0NFjzpoxGoyIjZkdbMxns08cJBRye68Hm5ne3Opdou0k4lXc2HRo46uYwpc5roFjBka346t8ZYQhypeR58wNJDpQAYKde+JOqfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107309; c=relaxed/simple;
	bh=c8xIZqGOelDr8vR/kdjqqtA9Lii7KFTLqLW4/OAPLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twVFLo1KnRVo1Kg0pdaB2ksVLjAEp+Sog7SnV24KrQ06o6mfjSgt0V6Fc41qkazS2aiyztFFlNuG4c7PypYoQyp4Hh+DH2M4gc0UVAXOqtFgnaHU3fkWRUzeYVd2XwBVi/wSPnZAXBVotl9ZyQAxn2n8W2xXsYg8NNnBbGPFjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=InXzdgbF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="InXzdgbF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823075fed75so671164b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769107289; x=1769712089; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IqerNtZd/2eIPu0s74sVae5mDkPG9QDd8bnivU2GUiA=;
        b=InXzdgbFl3URNtlatv+XrJupXfEUtNwz2yW+pgc+RbjQQBQpJuAUPD/Kej5C7Ccy6D
         EuPC03WZVVgO5ilTqfD9Yos3ZgZpFAnPHJsJMsPKLrDnNxppOc+gxNTnwrLsJLSx040q
         Fyt8MmXhvITCz+cjTFAxJVRktJCRFxma8uvOMSNP9lD6ubPnchQBJ8qCXwr7Fyu2Ek3e
         xDGKolRTmFjWPgQyvtlx7hxzY/nVl05mKaokJd2DR0Tf1WYTVKCJx6yMacDJYhkPFWBF
         mIkS1+Th76oPqC45PNIUk8i2i+BqFKqPxUcWUso3BsBcLtEfOAqI1UCjAKHQYzirvFyo
         y2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107289; x=1769712089;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqerNtZd/2eIPu0s74sVae5mDkPG9QDd8bnivU2GUiA=;
        b=b+VrGtGNe5RJKA4QqnmJBBcBwKqBkST4xjUDR6At3glUDfxWim/1FWltoCE92py05d
         CqTGt76jsXXJssXjlo0McbgCuTqo58cFX5kXhEwu6AeMQCcpt82+Qt2Zw6Xj4OHQYLKM
         Ta4O6Dcn0fKjt5s1+gLBKSxzPHwc1C0HvZsjy98SS8IY86kySXmc+ZWe9NY97WiV8NQg
         fXCFJ1w6YxVadPhM5oetQ1YUEcfGTprG0YT2uucgMMqKUtJVoPTglvGdFD4ocbTSSLTb
         OVPrpzi1KAlO65M+e0ikihFGjtmE98Lqy+aQdRhKkxOQ0GlzjHMiuiS0MJ0TAXpYIk9g
         6knw==
X-Gm-Message-State: AOJu0Yz4IH13R7YyZnvNtlhKK3QuVLJtMiYRx8nMrCwGgtgggK80t6Jn
	Dg7tHq+uCTyP+HBKQpE2PBRyQM39JRCXHPOQh9jkKiplFYr7COjy0iotvyH5vipIDAs=
X-Gm-Gg: AZuq6aIDInenLghNZDbRPZoWs79UA/ZiuiyWPR/P9flSDtXGj2zutuYEdGHCSd5+tLz
	QrOu1ilIlv0Mld8yfvPi08npAKkZM2VhUuIwfw1lBrvHPPVSdcbN4uAfYa2z5dutDBZPAro5dfr
	cNelqD98cui2zKYTJB4GnPxgEPgvNevZNSp2PvDrYGxPXBA6VIVg5zb001nD/bIvUDQYOy7cPXH
	BpvYxfEX36JCFVsRY3A7YRxAw+EqZV98nBi1xxIx4KrJuRRwa4Q+o2C+8yRSyAsn3MxHS5nyCkG
	4Ga8qLTaXaO6nXXEGRd7o1C0MzsFNbFiWnZEEiu/UArZSuu+v4BPkuH7fcOoftUXhqI9De0R2sb
	dt2Uka3PfZvFcDlFD/y+Hxg4G65ZvnE+sf/HQ5MIl32xacfH9tz1Ib/MI9EAg0Gou648JgTjqID
	YS5a3TVWLJVtEHwGuhkS0=
X-Received: by 2002:a05:6a00:2342:b0:821:8629:ef70 with SMTP id d2e1a72fcca58-8218ebb62f2mr3358968b3a.0.1769107288788;
        Thu, 22 Jan 2026 10:41:28 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871f2c0sm60366b3a.31.2026.01.22.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:41:28 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] soc/drivers: bus & hwsplinlock updates for OMAP
Date: Thu, 22 Jan 2026 10:41:27 -0800
Message-ID: <7hy0lp5w2w.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v6.20/drivers-signed

for you to fetch changes up to 3bd4edd67b034f8e1f61c86e0eb098de6179e3f2:

  hwspinlock: omap: Handle devm_pm_runtime_enable() errors (2026-01-14 14:36:55 -0800)

----------------------------------------------------------------
drivers: bus & hwsplinlock updates for OMAP

----------------------------------------------------------------
Haotian Zhang (1):
      hwspinlock: omap: Handle devm_pm_runtime_enable() errors

Johan Hovold (2):
      bus: omap-ocp2scp: fix OF populate on driver rebind
      bus: omap-ocp2scp: enable compile testing

 drivers/bus/Kconfig                  |  2 +-
 drivers/bus/omap-ocp2scp.c           | 13 ++-----------
 drivers/hwspinlock/omap_hwspinlock.c |  4 +++-
 3 files changed, 6 insertions(+), 13 deletions(-)
