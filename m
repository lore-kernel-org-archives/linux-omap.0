Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4956372B25
	for <linux-omap@vger.kernel.org>; Wed,  1 Apr 2026 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078973; cv=none; b=j3d1+ocHGCjEcQR+F3bpKi0fJXQurTAca5WEAtoNghvIcLu4RxxboOabQA00NIUQXd0qJ36RwzXphG1qCEd9mG3V6jS7QNuohneGzJg5vOcG3ChbE9BVO7pUNf4xZNn29S6OygA34vZfS/JOSnvEH15GEF+hlYTTKoSbD7j2uAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078973; c=relaxed/simple;
	bh=K8KsRVv9ierCoDyKNMfqXhMspOs4K7/4jBXcjnpXjbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WczW/epkT5/mUc5JswYLSC4nn5r+GmAm8bwL15PWwnVdz6pySkHuo2qoZq2pSTupUpb1zdVcMBERB1+9Pnw1J4Leju+HY+BXtP3C1MvYOBT+tJTEJf9DIUp4z6kmzTYzkwJ8hvj8FUo9eucnaPxaZzGea04uyp1zpfEn3hk4+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lpwkm510; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lpwkm510"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aae146b604so964875ad.3
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2026 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775078972; x=1775683772; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GOwLlN10Ns683PDS/KNdu0fTgjCNY8NkrJ0V0K9rlc=;
        b=lpwkm510nCOBHIqmRebRqcqQE55HAy7xGNxESbcHZilDIROjsRMVaWMIQtymFjlvSG
         Ao+kTi8B/x/Mm5z3IFNt/5GZSoGvd7J4CDJ//884hdGkSiA6d/ukoEK6YFYdhUzVoNqJ
         O2CKoEzh3QrRaO7GpDSckvcISDs1LneqTQYCjVOP3Cm07XSdNY0E00KxFe370NIuS3ve
         O9NacMKgauRl8YTNsqgfLOkEzSYJPTKhVHUEjvB/ibVqNvi3gUSCmxjqw30z343GPmxw
         GRD634+c5pevLF7tbmt2eVGSrXeAFcyak9Af59ViNW1jampsYnaU6EqnriDsW+oPTOdO
         G5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078972; x=1775683772;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GOwLlN10Ns683PDS/KNdu0fTgjCNY8NkrJ0V0K9rlc=;
        b=bQPIq03s5cZDEttUhbSi7C/Dl6MLILXTMGKmN5lGN+ztJo+cTc657G0CDvFeWdgg6M
         1IQPQt0mE6YRTdBIsjaqpUTE3UPz0HMFJ/6IbQRhpBxfwkf1p7PYrgMWTVBQC7otbfxN
         vxtZ7Dss5i2fqhkT+ej38dkX3JJXwqK41xL0vtM4iX0sqQta2ETMOptRQqzmnXEU5A59
         /sjsZy1BvDHIUr000WoY4MIND/97ImHLickeB6z8QxIuMxKoteOb6sOeHlD/9tqmI/7i
         fBeTILiB9llHn1elyLcokjG6UxE5FR0hbOhO8cezHDa7K7UWUckxkDr8BY2I2OVjZnC/
         Gngw==
X-Gm-Message-State: AOJu0Yyr+tFbDY/J+9cngryq3tI9WpxSH3ihEcnqjDZU7Jl7DKIw88cf
	VM3dwrQVr+LsJvijStMVQyE6NHHhF1+6a67rxRJlJigTAGq8eJsI+uS3R+VbESJW8xE=
X-Gm-Gg: ATEYQzzTNVzbXK+ImVNkyseGKV/U2CIF4HRc1AvGakw4r+JUR6e5qkKh7TXeOHybnya
	aKyFR0OMOFtsMZz32DZM3UFQx/aZFhGj8/ypdIQDUkbxIk7x7rq3t3GOgqMj9oWQ15zhcE3mH+C
	opEsfc4z+YfnWG6iUhJrMCIKGvutu3CNP64jTNd+TgvM7HBqgMHZk1hCZaLtVp9fnsAdap3tFmV
	ny/b6dOx7oCElIQl9zniEL5s14NMGZ3wAkfOguUgxVd0PIP9qmo/xN0+YVLq051xc1/TSJREQJz
	9l4UimwRF4p2PXpG2X0I0e106krVwCJQ0QdrtJdOBFY4g87a69m2/JmUpztwVNs86d3uDivDUhi
	W+h+r5K8wDuJuCSYf13xjSX3MzEX8M6ckRR6cPETa8k0Nmguy6k2vt5eRO1j+mT47/lXW1f/jDL
	MgC2f/VuiBRV9apqRE1Ag=
X-Received: by 2002:a17:903:37c3:b0:2b2:52af:52b8 with SMTP id d9443c01a7336-2b275891e28mr6903115ad.11.1775078972028;
        Wed, 01 Apr 2026 14:29:32 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm6419405ad.74.2026.04.01.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:29:31 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: dts: updates for ti/omap for v7.1
Date: Wed, 01 Apr 2026 14:29:31 -0700
Message-ID: <7hqzoytlms.fsf@baylibre.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.1/dt-signed

for you to fetch changes up to 2c4059f54f65ff1ee2d430fa023d25487cfb5b99:

  ARM: dts: am335x: Add Seeed Studio BeagleBone HDMI cape overlay (2026-03-31 17:15:17 -0700)

----------------------------------------------------------------
ARM: dts: updates for ti/omap for v7.1

----------------------------------------------------------------
Andrew Goodbody (1):
      ARM: dts: omap: dm816x: Correct pinctrl register

Charan Pedumuru (1):
      arm: dts: ti: omap: align node patterns with established convention

Kory Maincent (TI) (2):
      ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
      ARM: dts: am335x: Add Seeed Studio BeagleBone HDMI cape overlay

Mithil Bavishi (8):
      ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
      dt-bindings: vendor-prefixes: Add Doestek
      dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
      dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
      ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series
      dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
      ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
      ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1

 Documentation/devicetree/bindings/arm/ti/omap.yaml               |   2 +
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml |   1 +
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml  |   4 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml           |   2 +
 arch/arm/boot/dts/ti/omap/Makefile                               |  15 ++++
 arch/arm/boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso             | 157 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/dm816x.dtsi                            |   4 +-
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi                           |   4 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi                          |   4 +-
 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi     | 744 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts           | 101 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts            |  70 +++++++++++++++
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi                          |   2 +-
 arch/arm/boot/dts/ti/omap/twl6032.dtsi                           |  77 ++++++++++++++++
 14 files changed, 1180 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi
