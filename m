Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A83806DE
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107195; cv=none; b=UXMHoYuQ3yR7uas4ME55uwt46xWtnfQR8SlW/GThfOdSCj8LaxYKy5BHZhMBqREm95jGWjvrEEShlNXVrBMOTpsQoIE/pxHAumrYESyaQ2Mj5eU/CKio8Ejl9IlRV0S9okKzj71tS7Jo/3tpnEUVWuJCHUnbOMlpABp7JkSUUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107195; c=relaxed/simple;
	bh=C/LJc0P7pSCX6HhTs7JO0p5h6mPdfW06ySxpR5N1kJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXeQqsBJ5XCWRIyWYRTOYVzooio9fSaJsFEtbdt/7v4qclHRJS1jF2jEa6f1jJ3h5QUgH63VY7OT2SjOGeMuSimBOMeqVZopXxd7EACqJT0LiaidIPuInRIvGg/BXFXv03rHFf3s1aseN/MP0O5lZilt+3HYloh20gDl4jd+gMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kUnpBenE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kUnpBenE"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c613a0ca52dso684710a12.3
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 10:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769107185; x=1769711985; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eU9nAAzm7tuhsde9kPZ3jwJ1ZSEJF+Z3udZWl8Q5Jwg=;
        b=kUnpBenEH5TQ36u+pSvuvpXAVcuEcrTWj0UINWK4fZyET5redO28mSQ7XxGV/JDIU5
         T2aQ4pJUqctMla8A3Z8UEV3nizVwcveKf+RZzKTSNN/qtgiP+WB/72OXQm7R0ZbKpXJE
         xYJkmBNtNjegHgIOP2JW7LF7ckEjGYJQLM9IOc975umQL62FzM/kkJeJN2cI2RrfwtPO
         Sp68SpbUEtNXuSgCONv73QofIzSvExxCXtDw8KhbPhgIFKhkG6jKTz5w3FPlimgSso/j
         U6AP2wS+XlYEBYwkP6+NaiWMYzsR4RK54c1sUZN6NXcDuUM3Iom6dIt7L0EHxAyo/U8c
         6DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107185; x=1769711985;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU9nAAzm7tuhsde9kPZ3jwJ1ZSEJF+Z3udZWl8Q5Jwg=;
        b=JA2uAhM+4ZremG1ZvYDqcBhQYX8XSKl2bGVbnMENsoxuu2xWTRvbPRrThFaFa9psMI
         Q0xYBpY3TY8Ry5wjs6vZjunzMYZrMhLqbmq89Z098fZ+Y4rwnnAfc7+swsMb0dSkkQ+I
         RH5wTn0BzROW+k7ONsV5XBSnt5cu6tpFzs7b6B8Ysh+VMDDx3CtLHYFTbwU1ZdC9GFzj
         VFKfs2MRWRb/ymIaDlwNpooXQc7YfSVh1727QMu40G+8t+as37ZwZRnR9iGkl3+w311A
         vFUCBU06QwX0C+4yhcNGw8MKSZG50I/QTb6BLLNACIxbwMGeBoIeOebQ9KPg3s9K//4J
         pbkA==
X-Gm-Message-State: AOJu0Yzh1K78pT09S5QUlsnNnb+lchgAe3uaf7zT2YIIBS0ge+UJB7ac
	U+x4OPNY2hifZgWvYNLV9ioQVjjPgxqYHYq+ENxGINbZkO7TRs5viLjWXYgHk1DLyV8a2cs48JK
	UZ2FAqsU=
X-Gm-Gg: AZuq6aIdgU7D3Fk4P9Q53cRvE6rw1smMUYG5ZRZq6/UNARy2+owo0SgYCX3aXMZrMxm
	atqJ34bnv4v24naYRInYpE8jnnlqezt+ElfMZ4i3GWd6XWaLypQOwOXzWhLdcCDKp94s29R11aS
	6KwSE9IB1onL3IJrwmsqI3lYNOjfSkDMfKJ8/awCOfkMLk/LJdTPmnmgQvGhcPvMwZ7u564GXhT
	tWOwmtRnoWJvLwlJroY1kflUrI7a0hyN1Dw9ewrF4M7xOB8LsNiQpP7Cbs+STE5DegMsbnavCSh
	NoqTzkh7V4hXM9VkByHYvuPDaSDqLHZ50oHZ2zeHikdhQx/0n5bCN8j56KD2+mtiKKzKBMd/ryJ
	98UOi/Hm8F+IprFsk/EJBktY74dlTaWddeiiHM7FEXHVheBpx88O/RdqsILjdZv7ljCBhyxxeMj
	WNEAnu/2FOo9q43NduOA0=
X-Received: by 2002:a05:6a20:7485:b0:366:14ac:e1f0 with SMTP id adf61e73a8af0-38e6f83ae57mr387123637.66.1769107184746;
        Thu, 22 Jan 2026 10:39:44 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a3f2ddcsm41909a12.17.2026.01.22.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:39:43 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: dts: OMAP updates for v6.20
Date: Thu, 22 Jan 2026 10:39:43 -0800
Message-ID: <7h7bt97aq8.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v6.20/dt-signed

for you to fetch changes up to 76f88d2edd9f21acad7be8422069403118708455:

  ARM: dts: omap: dra7: Remove bogus #syscon-cells property (2026-01-05 12:11:31 -0800)

----------------------------------------------------------------
ARM: dts: OMAP updates for v6.20

----------------------------------------------------------------
Alexander Stein (1):
      ARM: dts: tps65910: Add gpio & interrupt properties

Andreas Kemnade (2):
      ARM: dts: ti/omap: omap4-epson-embt2ws: add powerbutton
      ARM: dts: ti/omap: omap*: fix watchdog node names

Kory Maincent (TI.com) (1):
      ARM: dts: Drop am335x-base0033 devicetree

Rob Herring (Arm) (1):
      ARM: dts: ti: Drop unused .dtsi

Vladimir Zapolskiy (1):
      ARM: dts: omap: dra7: Remove bogus #syscon-cells property

Yegor Yefremov (1):
      ARM: dts: omap: enable panic-indicator option

 arch/arm/boot/dts/ti/omap/Makefile                |   1 -
 arch/arm/boot/dts/ti/omap/am335x-baltos-leds.dtsi |   1 +
 arch/arm/boot/dts/ti/omap/am335x-base0033.dts     |  92 -----------------------------------------------------------------------------
 arch/arm/boot/dts/ti/omap/am3703.dtsi             |  14 ------------
 arch/arm/boot/dts/ti/omap/am3715.dtsi             |  10 ---------
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi            |   1 -
 arch/arm/boot/dts/ti/omap/omap2430.dtsi           |   2 +-
 arch/arm/boot/dts/ti/omap/omap3.dtsi              |   2 +-
 arch/arm/boot/dts/ti/omap/omap3430es1-clocks.dtsi | 237 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts |   5 +++++
 arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi       |   2 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi           |   2 +-
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi           |   2 +-
 arch/arm/boot/dts/tps65910.dtsi                   |   4 ++++
 14 files changed, 15 insertions(+), 360 deletions(-)
 delete mode 100644 arch/arm/boot/dts/ti/omap/am335x-base0033.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/am3703.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/am3715.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap3430es1-clocks.dtsi
