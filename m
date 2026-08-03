Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFB33A033
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772289; cv=none; b=XH0Sx/K722395jnclxCMC0MvIZgzNK+MwRSW3nyIF5Vi0QitgPGuQzWgMsCRJzC0FhEdoaYrpfHNZfaNJOeJIknLwrEXRw7BKNB3YLT2ICR/7P2LTW3LOd7iTgEdECrA52T/O16bRIEB/yvdGA1BJCfUxuBtuX+urUnz9IEtM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772289; c=relaxed/simple;
	bh=ejXH5qcZOvvG6iZ5Sfwx1s3pa6RHFrtsgRq250OohG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8bgzbRFBrBoq2BEzvHwsBEYtuS5ZNoDIUxXuLNbAlrSlUanBcHMw1wMpD5s3t6tMJbdJEUzqwGZs9ahskgq5MGO2sZwm6vbniy2KL4SvqExKY0XRz3oA5+qgh8V8KLav7zG4VB/W9353lxuhsrdmlg7FneEIqkYXZMyQAmqBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CCO1PhkD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CCO1PhkD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce98cb8165so470445ad.1
        for <linux-omap@vger.kernel.org>; Mon, 03 Aug 2026 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785772288; x=1786377088; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ocbZUo7zpFmSLPbwfUgNYrUI1VbSx+D5BmbZxXmpAkw=;
        b=CCO1PhkD7lO1XfRkAS2z+tX/uISyhDSKNISffYXzxn5oOFcp0D2yEnkaEmHJD1pH4G
         G8yQGHpuJfSDFrilzuYWmYcyor5t1SdEZxOxo7EGh/RKTwqgkbL5ZlsZu7H0gsJgad/Q
         5js5VWoKCvXB82Adz2ZDap4Dt1CmbOP5DEU2EXyHdpvcEsiqB0T4rQ2dWkKRKlHKyjnL
         R3VXaupwWqjBkbcCCHEuVAbemVJ/wf7ZnbSySy3taIPqzFeKWCjwGRmdDICxMOccU1iY
         ZgQD78/iE52D880ucOx3h/3N4j/bNYson+sckPS0UEZhLviAs9VDXV1YL6/4F/1S7CRJ
         WEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772288; x=1786377088;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ocbZUo7zpFmSLPbwfUgNYrUI1VbSx+D5BmbZxXmpAkw=;
        b=UFCH14VAAy+VLzTSTujdDDgAwnwOiTsY+oqcabd319XPM9L1UodS93H1D5cjVaIzF8
         WIeiWP2DkF30pN53lBLq6P/+4dWugvGXn7ZnmgslnY+WCsVAPhH8IN+QvPbzN269WeOp
         dXHTR3We99UYl4XyzOGrwf99H6Q+hh1+wdxN0KyRaLuoCTYugw2bc+FMcIzXbsO/DOhg
         XEhNkeUqYOtLVSGBJqpjla8+/MIiGtOJETbXgahm/XGMV4tK919zw6/TnVbU42Pu4Sb+
         TSpPftrpVAG6Mq3VqYHVBOMkcZ6TSOWtJXJwhOPja5GXFQBkBGjNN6LrN1jpm9AMMYz5
         /YMg==
X-Gm-Message-State: AOJu0YxuE57FJqux2lpMGepkoj1l+PDvaUFbZaBJ9jIoyppqILhwyhkM
	mpsnFwpORlF516WEgmHSqXDpYxlfRkTwUfrT/+39UIjDj7W2zKMU3J1VIkaWZl3d9elKpgfVIfc
	KGCoWzXscYw==
X-Gm-Gg: AR+sD13KQHiJxAGArKkuIPeIYFXadjWWEn7S3KKjiG6Mg1Cw9NcuBJW63dMByv19T8h
	Jw5UQVih53oeq6CJeWy86NJKXeZc779T6dVwNQa6ES9U/FtrS6dypPN/SxND9f8UJrfo8tF12kB
	ogJ4R8a6q/ylsRsQDIYBxUZQIMyWFyjoUBW7Dsno4nCCFXBvP8gvnhBw9t2g4fBwobRxgwYDQCR
	VtYoO08HIBrwJnzcZ9Ft7YNSTJTbafLODC30/OvGBLGcbqt30eNRr//FL64zf9F7px5W9yiYUaf
	HRBziomi4ZG7QM8XwIhQFH1iPE0a/b2LpwvKPfTfam0RPZx2t6TJ/xda9Y+y5UmFJ9ffmsttu47
	mCb8pDmmmquNB5RsSfOB9bfnA/yWgGyAWELrw3WQuaPgXPnRSGGfzL2Vaf1XWWkxedRlhRWB5DY
	774W9sk1GLI3vS7wprFq0MwbSyKlcM/IxV4Ygz87HZFydNiOcvGb/q3HjtcA==
X-Received: by 2002:a17:902:c40d:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d08aa1b175mr521585ad.2.1785772287919;
        Mon, 03 Aug 2026 08:51:27 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d04b15d27asm39967845ad.78.2026.08.03.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:51:27 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: dts: OMAP updates for v7.3
Date: Mon, 03 Aug 2026 08:51:27 -0700
Message-ID: <7hbjbjjj7k.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.3/dt-signed

for you to fetch changes up to 36d3d0f740d75dc0274b72720c044f476ff0e242:

  ARM: dts: ti/omap: embt2ws: use mulit-led for RGB LED (2026-07-06 11:40:17 -0700)

----------------------------------------------------------------
ARM: dts: OMAP updates for v7.3
- DT support for PRU-ICSS on AM3/4/5
- minor fixes & cleanups

----------------------------------------------------------------
Andreas Kemnade (1):
      ARM: dts: ti/omap: embt2ws: use mulit-led for RGB LED

Krzysztof Kozlowski (2):
      ARM: dts: ti: Add specific compatibles for SCM conf nodes
      ARM: dts: ti: omap: Correct indentation

Roger Quadros (3):
      arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
      arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
      arm: dts: ti: Add device tree support for PRU-ICSS on AM335x

Thomas Richard (1):
      ARM: dts: ti: var-som-om44: Add USB Ethernet controller node

Vidhu Sarwal (1):
      ARM: dts: ti: Fix typos in comments

 arch/arm/boot/dts/ti/davinci/da850-lcdk.dts                |   2 +-
 arch/arm/boot/dts/ti/omap/Makefile                         |   4 +++
 arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi                   |  15 ++++++++--
 arch/arm/boot/dts/ti/omap/am3517-evm.dts                   |   2 +-
 arch/arm/boot/dts/ti/omap/am4372.dtsi                      |  11 +++++++
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts               | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi                   |   2 +-
 arch/arm/boot/dts/ti/omap/am57-pruss.dtsi                  |  11 +++++++
 arch/arm/boot/dts/ti/omap/am571x-idk.dts                   |   8 ++++-
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts          |   2 +-
 arch/arm/boot/dts/ti/omap/am572x-idk.dts                   |  10 ++++---
 arch/arm/boot/dts/ti/omap/am574x-idk.dts                   |  10 ++++---
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi           |  61 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/dm8148-evm.dts                   |   4 +--
 arch/arm/boot/dts/ti/omap/dm814x.dtsi                      |   2 +-
 arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi               |   2 +-
 arch/arm/boot/dts/ti/omap/dm816x.dtsi                      |   2 +-
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi                     |   4 +--
 arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi    |  10 +++----
 arch/arm/boot/dts/ti/omap/omap2430.dtsi                    |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-cm-t3x30.dtsi              |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi               |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/ti/omap/omap3.dtsi                       |   2 +-
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts          |  13 +++++++--
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi                    |   2 +-
 arch/arm/boot/dts/ti/omap/omap4-panda-es.dts               |   2 +-
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi          |  14 +++++++++
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi                    |   6 ++--
 31 files changed, 428 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso
