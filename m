Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF16378D7F
	for <linux-omap@vger.kernel.org>; Wed,  1 Apr 2026 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078945; cv=none; b=ADJVFIeFtOvjSPOyJWJjPqniOGtnpwj0zfy0HquBAhte/UCWivPTfYv85WfPNO38IUknsTLthZG/xJlPW7eU8v0N+Kv9ObE7+yuf+hblXXcT44YkaQDkhSi1JtOu8iDckIy1QW18g9TbQZMpN0/UmOVUCYZU2qed22PpYFhmwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078945; c=relaxed/simple;
	bh=U/fUOSJSk4+rbP24lUBM6nBwRMa4PD4EWPaEofbYms0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2JFBE1SqQ3f3o3YlIwnsMyQiKNCrc0HZLFwthDNK22dG7SnHxg69lTH5ZbBJcEMu1RtrqpSmm0ePJ8rvazVrjvcvLijXIzhMyZ3fibRjyy5K96QVz5tUeJPboahiLywOS2LdyZeheAwSA9OdrE6aXwVY4yd7qkvM88v2Lu5PWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ert2CJV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ert2CJV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so49979a12.2
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2026 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775078944; x=1775683744; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tA3CYuQv2XiQfD/33D614etMn9c8OW1fecXvIS0+Tb0=;
        b=0ert2CJVfYhhonnErKzW8CN5upUs81zN+PTVTJt4iqJ35W/tE7Amu3n0o1W3r/fNpi
         M0mhI/kGUT4/7FArQwgleKwu+XELJJBvH5XdhHSOaEDvMUu6c4oOiWiqU2H/zp8K8fqi
         z2E9ODBjaCpS6SY/+FabdN6aQxR8HhwXNf2C+JkoElEwzeDIz04DiNw/8ytkv1BFG/qY
         5QtksdVv2NFI6veumtIZ+f7aGSbop0/gUX+dpqEO4hoY5Xpk71T0yB2LGYbV+gtfl7Lc
         Bhi+9DPZdNB1wOL3XZpbkgph0+HZuM9nI0WSezXxb0kzG1z5lV3Bj7wIggdroXL4ExC6
         JkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078944; x=1775683744;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA3CYuQv2XiQfD/33D614etMn9c8OW1fecXvIS0+Tb0=;
        b=ROhJZfNmNTxH9vxsAvVRo0eRT24vCLbhn/OgxWUzRYV3a9KPC1RFt9OQ+6BrujMg48
         sBHEWA9BfG+ocYwndNEnuHcXGdG85lNT+Vd6tVoiyKku7AUPS4TdQuplkUVDRC4kyCHM
         6t5sfZuCSNunDH2Z/TzqrC8wuNbCHXUKlQG2he1CeSryDJ4ernjnDygtMMCBsQuMbBLw
         PRBwEF81LlwUS82VYCnzx1+MBoZA7BtS/uNk9kO7Rx6EgGE7aRI/UbSZLp/6/0bXQidK
         910zHYJVBJIRwiYYuXvjdnsRlwrMDYnU7h0gXwk9uMEalE0LfdjKdTnYeRgwN61ttXtP
         wAMg==
X-Gm-Message-State: AOJu0Yy7Ycpu6xO2MuJZlAp4EYsyLcph4iTN1xPEt6Cy7wDtwLhVkhBY
	8gVX3mRLq8t93FLiTXI6KoaaZswTbyEq6vbnQcGWDRPEl2VcrEBjQqY/F0ME9IzqeWJ4aUu9m54
	Ni6mixi8=
X-Gm-Gg: ATEYQzzTWS8XVKufXXEI2c4LVDGYZ80BDK7JaXamz8YfDnKv1q8UCNxYQv8Iy3Mptzp
	3EUD/tEwmGCBtVJ/M1S4h8FOH/hE8iOEW5h/k4YAfrB1ewH9r8cvChH/kyoaGEXiYn6EiWaXxoS
	nmpMgVZ75ix/ftWy0Y9/mwbcDNS3Wq3Ik/ObIidmQaX1HxBM/29dtDNG9KwAxME34hVfrxLB3RF
	pDgCTlT4ZPI6xhYe3AYE2wkfE9fSDpIdIDXjYCHIojN5YQyCh66Z1L5B8MyjDEp8KLIQu3/Cn8a
	OqZCYvkonG7rqhqyWP/G8rk+hvpvwzdbgyahLMWU8BybdAxYacFwCItgdqZ2Rcem7b1LKCw7Xel
	whYQQub5P+NFwWV1axyQ6xb/QP7p9WpD3iO5ugGl2l6OCOD+7w5gBw8l800Fvdel+EChLLAfc8O
	/x948wUr/vLDGDlQmxm0Y=
X-Received: by 2002:a05:6a20:734d:b0:39b:b35f:2eb5 with SMTP id adf61e73a8af0-39ef76c1b2emr5611986637.41.1775078943866;
        Wed, 01 Apr 2026 14:29:03 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c647792bsm822742a12.6.2026.04.01.14.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:29:03 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm: OMAP defconfig updates for v7.1
Date: Wed, 01 Apr 2026 14:29:03 -0700
Message-ID: <7hv7eatlnk.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.1/defconfig-signed

for you to fetch changes up to adcf290f9de2fc4768e5ba07c700e91faf9c86bf:

  arm: multi_v7_defconfig: Enable more OMAP 3/4 related configs (2026-03-05 16:45:57 -0800)

----------------------------------------------------------------
arm: OMAP defconfig updates for v7.1

----------------------------------------------------------------
Andreas Kemnade (1):
      arm: multi_v7_defconfig: Enable more OMAP 3/4 related configs

Kory Maincent (TI) (1):
      ARM: multi_v7_defconfig: omap2plus_defconfig: Enable ITE IT66121 driver

 arch/arm/configs/multi_v7_defconfig  | 28 ++++++++++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig |  1 +
 2 files changed, 29 insertions(+)
