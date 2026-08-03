Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC713101BF
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772352; cv=none; b=GSx21qQs6Uuuok9mlisoYSyc2nQnZB+xVvfX7oEaYzNXG1cIiM7lTOfFbZEdszD7RCsbehorPmJTX4DCkbeJEIN7UuRJ9fJHmPkIXCsj3JsOerVlWWpIC7wfo1+K1meQMNKoXlSrL/pQ7Q3TpiXZtTcXEn5vdUn5s9totZS2rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772352; c=relaxed/simple;
	bh=NbziU21Uwf9tsF4qhJ7ycQZNrgAbD6aLFtsogDvDgwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZcbXG6FIF9LE34XxZIYi3MKcBWH7wdWG8jIUHJbMZaL8qQwZPi8NsruFJfgtcFcMRjzRYlyvJtx7Q7XRTvGQqJLutvXLMi/2rjDQvCySnpEzKLZc8ecuflyHM70rXpLArcT7fv/lZpCR/mf+QVRF0eIWmcCepgjRje2OBid6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mwbkj7W/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mwbkj7W/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so41038a91.0
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785772350; x=1786377150; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMGav3xJdmmSRTKaIqplO9a5WTwQJq0xRLfaVlj7k/k=;
        b=mwbkj7W/I1ZuXSi8L3LDD7ZEzYhBQBK0DpfvDt0R7XvTlPPLnlur9tBkuRVegYcOtH
         BUOmW7n/WphuLdCkZeVa75qh3jVNa78f+0/e/W9V1wDWcfWHEys4bVDSofZMeiD2qjTk
         PdjOkdnwIA/Qq0HZ9DDBTQca24z9sQad037uncN2CUn9NYWJodvp5I/gbi4nJ3mgzNWI
         j2D9Znf/WNDWCmZb7aaCD0cspTRSf2JJKwJEttZWXOEGtGRk+9HV6O02iakndLI/PxZs
         7Ur6S4BzGbS18FnhK8dWnfYABsY8GJ86j81LCo4hcuAieEg2dT8fuyGOaxkCcAD4+HCZ
         /bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772350; x=1786377150;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oMGav3xJdmmSRTKaIqplO9a5WTwQJq0xRLfaVlj7k/k=;
        b=OPdbhZ6ImRGqRjF5zzu1rkggNTBQ5iJnwdxBj1dp3hy+GDNLpUG58o0AxSzG43ENUJ
         NdCyNehGIxp+z3LucSYZT2XioziTiKoWUiGnVc923K20xB3oUvvY7tmLLBA+4HTybCX7
         bhh3FgzJAjfS5j4INE06+wo4xOYNKS74xhYTR2wg9FxCwrwREInBLGunB6Wmtav7fiDN
         ua4gv7veQi55dn2uju/7m9gBLN07QtaRcNn8aR4cGpGxtI0gCe9CS5X+vWapS8vUbnSa
         cASmwjwstneLC8XCbbs/+2N/Moc47gDYyy9Cjt4j7j0emAXihpYMPHNMRW65TTagI6sc
         begA==
X-Gm-Message-State: AOJu0YwGjYmrpymN3/tpa0W+NvjOdGxvY+vX3R5hYQIbJgNA9No3CrHN
	eItWbSGxOL9cKX1q6Is6prYeP5MX9NiLxxu9UbEE0ZvtYMgGeHZEj/hrrwggGMi8A3M=
X-Gm-Gg: AR+sD12dvxIKjopDZ7oUCidBO4bdHRqmm/3tOzIxPaeyykAiauvrjrVB6shhZg2oCyT
	+8jMSYM1eTV1yceXuaDCxIlnxAswB8ErdEloM/FgXL1DKj3lGsPdYO+9SxiOw/2lQaKkSEjJV7M
	U0D018oZehIGxxofsGD8ripIHvzN4Wd/hEtCkCfw7MglzH/GnuzBNnvC94Ybtw4Nykp+szRf5Nm
	nzmcsq0+aoiQ5rUjt6CTuvphIyKolAk/7oILv/fvzdOkJ5Qgr+WEbGEEcEt328TPMA3SJ7MemNm
	bbMBX77S9czKeLxHfpjI8Pos8/XS0tlZzucg4NZPJl7UZhhsCbTS1GrJ+blI9hHp0lVuhQDlduF
	VxX08C72bVyTz2SggntQwnB1HURrujM8qC9jGQgWlHTepkJ9kcdCrPm+H3JlVoBGF7bXCoZs3If
	XFfNyz31sKvcEeTKa+Dl7n81x25KMteeWIBSpTk6/j/soBEIS4yjW7cLFrzA==
X-Received: by 2002:a17:90b:4cd1:b0:387:d5bd:622e with SMTP id 98e67ed59e1d1-38fece84676mr12015a91.17.1785772350215;
        Mon, 03 Aug 2026 08:52:30 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm3038440a91.4.2026.08.03.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:52:29 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] soc: drivers: omap updates for v7.3
Date: Mon, 03 Aug 2026 08:52:29 -0700
Message-ID: <7hzez3i4le.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.3/drivers-signed

for you to fetch changes up to 6342de0aed216b6df460b492ddb532b3e0ed16f1:

  bus: ti-sysc: Fix /chosen node reference leak (2026-07-06 11:42:48 -0700)

----------------------------------------------------------------
drivers: omap updates for v7.3
- bus: ti-sysc: Fix /chosen node reference leak

----------------------------------------------------------------
Yuho Choi (1):
      bus: ti-sysc: Fix /chosen node reference leak

 drivers/bus/ti-sysc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
