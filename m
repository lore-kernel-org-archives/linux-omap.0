Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1C340412
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2026 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772251; cv=none; b=YJGVK7CaYs6NFeqVPonjEtZAZmqsIIO+UBnBAveIUbtBfBhdYbxU5OcUlEKokDW3fBGdKpA/5Xzm1Exxoma4fh/puPOuiXC3tralJQA9In1vUHO0u8w6H0sqA4Fa/NHprI5InKMWt/mQXNtaNiXYEZM1QlcJj7XBaE9QLYHKmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772251; c=relaxed/simple;
	bh=zBoJOy3aA0uyoB7z3ZtGuAXNBzCbibioJt6Be0moF+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ilFCqU+SKOzKKCezobgKbTKOrwXghGM2ABSBcEJLx+lcHINtMvY/HJbIqmVfHl2++8EbcdIiqLqJBz14mJkgUuYAxs/Rekh4ENSmGHA5d18DwgLP1Lw3n/NT0SsXDxO60Zl2kWXCBC7NLAzQi48+Y8vxcfCQ9Ts/1xiIt5jL1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dng6mF1z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dng6mF1z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso34551365ad.1
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785772249; x=1786377049; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xejlBMo45WLuRAy/dsFHC7xCFuVwpUREVKu0zwhd9DY=;
        b=dng6mF1zsWMmMx6Bi6ggv3e9N0lx5EGufrfleaikUeI0MTbV1ykbJUTUAUuqiCYX6z
         8t4rHxSi+8fupEXyX7Y25xy3aBuY0DswNXf6rijCq+WfkzNJKD0tc91FpYKaGVtH0NAS
         cTp7UARvJsdlW5rUM6TkSjpzxRB4VxtlE1ilALH4jG0vvjKKFPFun5A58yCbDL1qcni+
         EsTGC679lD8KCh3E4iHJW0XqyDEUMJKiVng2yZs3nB/4ihRAsIdSlkiGNj5mfZ7tKWB1
         iLMZVZieSwFZyD50El6KNQbvQ4SCRcC4bEGFgt/N/KlcuWM+srrlo1CKYW8uDy8ZfaNu
         qI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772249; x=1786377049;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xejlBMo45WLuRAy/dsFHC7xCFuVwpUREVKu0zwhd9DY=;
        b=Gy787VnWe3sSDpQ526hpxN9W/lGSZklLLlZ9N2eUIN5jpVfQw4b/QZJwUg6XvnfQWn
         VpOLATzeutCNrfVOo+fTW526fcqBiEnlxyDZ8JBeaGAFZpVLCt8+7KfaTaUnn8NE16QT
         8pqQlNx/UTvya8JzwfP+1g2GbSnJyoKI3QeVtLgNkMUUDHvGszadwiF/3wY/aag+abZa
         WfrDWRO29/Ba7WXnG0H8ZyemN/qixRjyXNrVLTTHRAyQ3bTxe6SEkCBxnfJ+WR+M5aAm
         fN3SITqMeR4Se09Bot4d4sGmT0WxoUgLSR/Ra4AP56/SkJCXKjq89viBizMZ7tcGrANt
         Oo6g==
X-Gm-Message-State: AOJu0YxyxSV7X6pvfML7TvioZjpgOJ3d8tIxn6cNZmmnkCUTSByuSH8d
	YpDGhZmjgcMR/nS9AgQc0nTqMH7CADz0pStBf3mV88EFrFP3ouIQhYQ9fuIPZEwboh4=
X-Gm-Gg: AR+sD11DNi9tOb5/ExNnsUeMLNaxxDCB39L5YTKhNYjDVddCa+f99hwUhVOBjUjgmLU
	i+lgnKpMWAxCUF/NGb1G0rYmfNATs0wfxtD5Ihw4KZNK40o73CqeDGVfoeI3T5Lsth5fGvo9T7j
	BDmi18BcluD6yYq6oBd2YXRzkw4yoMrLHS1SUl47y6t1b1i2XcieXHHdXgEU1e1At9Y0tiDySkQ
	NLQuGyfiTjOD5ix4/d+FdCy6AfbrVbTUYvOQAhe2kjLO0ajGSFTOcVj0MjrgYRHHBDqcnukP6ci
	5iZRhkITUyM+byAlyhUtZVhzhtTbJ/lJE/3j/mEXbK2GyvNewju5NEdb9vOIK3nWc30K0gP+FVe
	oLo9ZzxyBGTFByxrgIO7B4PKFlTc3k8LpXJh27qVmV3jLnh32tmowmOYRdFy2f96KhvPLhg/KXJ
	osKx9gOLN73DHhlSjSn22S0JzxrqnRabrZLGXSpifoVZDx8zCTJs846ZJw1g==
X-Received: by 2002:a17:902:e543:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2d052215bb2mr105382375ad.16.1785772248620;
        Mon, 03 Aug 2026 08:50:48 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d04b0ea863sm39573495ad.38.2026.08.03.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:50:48 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm/omap: defconfig updates for v7.3
Date: Mon, 03 Aug 2026 08:50:47 -0700
Message-ID: <7hh5lbjj8o.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.3/defconfig-signed

for you to fetch changes up to d091917c23668cebb0ad23b18f5a9f6665150054:

  arm: omap2plus_defconfig: Enable multi-LED (2026-07-06 11:41:09 -0700)

----------------------------------------------------------------
arm/omap: defconfig updates for v7.3
- omap2plus_defconfig: Enable multi-LED
- omap2plus_defconfig: enable things required by iwd
- multi_v7_defconfig: Enable BRIDGE and DP83848_PHY for TI AM57xx, AM437x and AM335x

----------------------------------------------------------------
Andreas Kemnade (2):
      ARM: omap2plus_defconfig: enable things required by iwd
      arm: omap2plus_defconfig: Enable multi-LED

Parvathi Pudi (1):
      arm: multi_v7_defconfig: Enable BRIDGE and DP83848_PHY for TI AM57xx, AM437x and AM335x

 arch/arm/configs/multi_v7_defconfig  |  2 ++
 arch/arm/configs/omap2plus_defconfig | 13 +++++++++++++
 2 files changed, 15 insertions(+)
