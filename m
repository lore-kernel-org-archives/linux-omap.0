Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F893815D2
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107252; cv=none; b=QOAt+SWJ8g7gPF98C59oHH/Qb/0bYmyYeYXpT7htkLqIgDMjXm/e7g8XPUIQoGAcLzIS9A+RLVeFibQZDStY5aPApG1kXRH0LeAJNSiTFj5r2PKYWeAU9jkNI6eLVIZqRbeyUooANMp+nhSWlYB/98ETOj4Q2fm/OcUkgl5ACyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107252; c=relaxed/simple;
	bh=+bey99AjgyNTqzkxXlw+Qjdw77mPPw1bmRZ8ASYrE0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWlHvqHGiRlV0lP9xsDQcKDD0vs41wM4gSVvBC8m8moMzomeHDDvUR4hl1vp6XtCzKJcVYVGWsdn/tEYxT4VEDDHLOa5B2TCQXzd90fymhKhff/fumzOKLal50AjeCSqOLVxu7bepigabM9U954f7BtT+Uu+wDXE6Qwjlq3n9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=es2UPx5o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="es2UPx5o"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f2676bb21so13093925ad.0
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769107244; x=1769712044; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kh3llz159zOHhYjpa3DZZY1B3AUjD9TXdEvBojqy5mg=;
        b=es2UPx5ohQX8GM28TZzXq0bm/2Yfd52nRBQRqqqhp6jh9Hl9rMdLPBn9femJkNrpHn
         zYgdTBfpC5/sIIYxhtZ3YsGwZC4wrXuRcxVi6bOlY8Xy3BsuQa5H8h65ghTF2RsDUdKR
         U/Pz1Mf9ZjAXywLZ6P1jrXJDsJd/oVnJBFUjdRDngSFM+UV+3I3XgpuuYTTniztkPwjV
         oBY70JOopNlk9wX48L7ZYIg8DRUez4O2frpsLFnG0K8L5yLIaXa0f7bIbhU32hit3dpr
         Wnd08s08NQGRHBW9+LSDSqygARpk1J1lgf/O1luclykYFQyyBAeBoGGFm3MRzB54lK96
         q8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107244; x=1769712044;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh3llz159zOHhYjpa3DZZY1B3AUjD9TXdEvBojqy5mg=;
        b=R09oLtv5iIchRRsqgb1d1A9BCRTMC7gy35TmQHAA8fMEThpCqbjPI8/S00qERxllR9
         am1QDgE75+S7oHMOtNL1O0Y8xtt4WCygjuJeBUUtt2YrxO+M/+P+9wfMuQ5T0E9K/NaD
         5Gnjdn+mojM9J32IRWsnzp2C034yytNVM9qi6OPna9BrKk8GenK2kSc1CVe0rPeQ1trD
         unw2xpEEHhUxlnPDQxFTpm6ckKxB/lLLOcoPG/ibUB72TIgSl0bMM/d8MgyAzo5LYq1J
         VLcBmpDvNuioHZVWylgQTBw90CJWmSORoozWlmHBvttbl5fdWoVxE5VuhKqErqqHhxmY
         dkKQ==
X-Gm-Message-State: AOJu0YyvZli1O+oEGmzOBrN0P8fWp3wFjrcUBFHqHK5IDZmyW9rq1znj
	g+ECegjpwxIcfuzA3dBe2vQWzSKn+TgURNeMYv8nLhUUhJtX0yq/oiPKhmqbjDKTrtE=
X-Gm-Gg: AZuq6aKr6KOb+iFpCnYP1+e0eq+z0Re8yIpRrR0KFxadK5Ta6kgXedMSv3GnK9mLeNV
	kMqaK1oUFi/3zg36l5aD7yd0wXFIo164F43CrOIK0toHT1o/Xxle2iozH29v7DcBETn1x4sHvmh
	j/ZxmGd5iOH3DagZrw/eqxlJvtuckBhr50/N/R3jI3Q/rHcr//1RwFZppG+vN1cRA44t+tlbiqA
	mO7R0+UbL6kQTFTW5xDPiGpHe1C0kFEYhSpKb+J59NafD05wR8rubTQOQfSsQvc5IUBxHrJLtYA
	WvG/PaOkuvs+B874Ro9ogL4vLWUVns9qV82ZXXfDH8sujgBqgcG3Ao8swNdcL2C7YvSgmi+rTkL
	LnGfCCinrhcwxi0okfMTZeRWJbhQPAgoJvgUo5xH34I7uD0gmG6G9EyDk5nO8j++crN2pQb6h1K
	EcOItkTWMp
X-Received: by 2002:a17:902:e851:b0:29f:1bf:642a with SMTP id d9443c01a7336-2a7fe43ee93mr2949225ad.12.1769107243616;
        Thu, 22 Jan 2026 10:40:43 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7b03945c7sm52280935ad.102.2026.01.22.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:40:43 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: omap: soc updates for v6.20
Date: Thu, 22 Jan 2026 10:40:42 -0800
Message-ID: <7h343x7aol.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v6.20/soc-signed

for you to fetch changes up to dc717e24deb4e626f4ad4896dd722815ef32311a:

  ARM: omap1: drop unused Kconfig symbol (2026-01-05 12:11:02 -0800)

----------------------------------------------------------------
ARM: omap: soc updates for v6.20

----------------------------------------------------------------
Randy Dunlap (1):
      ARM: omap1: drop unused Kconfig symbol

Wentao Liang (1):
      ARM: omap2: Fix reference count leaks in omap_control_init()

 arch/arm/mach-omap1/Kconfig   |  1 -
 arch/arm/mach-omap2/control.c | 14 ++++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)
