Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203586;
	b=stO1T8mFaNp/D2SG1xBJDU7suy0R7KNdV6irPSqLSv8uSiFzh7kqitSqfBCftUONgDEQ
	 rEfOWmLsuK9dY49CNG3OwW5rR5LbhXx1eiotCkFEyppMRCR8NQBGecSYYfLrm7/ZEDnjp
	 4jUrrkmqkluj0aHHYF4wXMduZSk/rmeTT0FEPkYHKPY39ucUys5vtgCgrEFqztaKQ8ZYN
	 8Pe+FZeFzsipRDcbnRTP5X+DBOuFvHohG9PP8ohpUEjakYv6m6ya7i3PcgyBPKXgtGHRs
	 56DVcjsRCff2q7VO6YAWcg8BCXW+qOiSbUA7ZDUN4UmQTdso9onvQZaeGb5ia/txh+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=yF8DTNoppb75llVRPX1LYhsClp6/Hcf2t++M9WagagA=;
	b=AheaSkvbY9FJ1vGWig+pYyObzttk9VcNExWP6+QMx7E/Ry6Y1rbGRWvWka7XxttEGLvb
	 GA6Evjf+9pi2ZvQREbHTOsXX2TWn0Tn4vmVCaEv7ru0uVfiMRpdMNWuzruk6IyLWQGhnG
	 alzzrRKIjH7dNsb4B9w3V4rF/T88tk6m3lveITh9uuUcH7YPyPFZbM0HAnJL303i74z7t
	 c3sa/eG+dErVa9FDYFYXeQzny4t0AxPrpA43YROEeflR6qJV0clD/7f9zRE0iEGkzmLJX
	 72rVnisBidXrNSB3lsEzHu1/x2jkWzHDt/XIPBtJedFmlndzgULm0x4b0iUwFlW1knQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=To7xsWAk;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC9606AA61
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0DC9606AA61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=To7xsWAk
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4a16dfb8fa6so7005195e9.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203584; x=1793808384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yF8DTNoppb75llVRPX1LYhsClp6/Hcf2t++M9WagagA=;
        b=To7xsWAkeZoR3UfNxISL00p3TDp1YKvjvX5uz1h2JKzbs+n26BJ5d22BglVMx05TN8
         qRgpa1lt8F9FG3R7QnLnWMvjKkbUObRpmi+Mlv5YwH2OSlcnvtgD7WnJBJ4UzVX09VsU
         3L2MEbtIDsUjHI0GQRvW1dlfxkO0NoFrbAcMZfgsPyAgmt4Ui099XB9Nr6yP8KBVrIoi
         sXvVrvv/+goMtM9Ps/jBN0x7TvO/zD+hrcrAqdJBleAOvJza+0ETtZorHtLQj3GdjnjO
         dODy751fzWHx6xztkxJli1i1cvJN4xUP4GlsdQ2Xyp3i9HzHjvGqbg8L8GjPvOqRv8ee
         Id5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203584; x=1793808384;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yF8DTNoppb75llVRPX1LYhsClp6/Hcf2t++M9WagagA=;
        b=nhicjVkziX+UDV7WAVVykDf/u2okxx16eOc9sQhcsvXUkpSc3og5X+PFn4l/mm4CQP
         wThrQ8mfiH02UgHp/crVbTIVWxLCuckGAXJeGQW6TbsKryMGkxZqkEe0y5RFi/dUm08e
         JrbeymSA07BL6RkLLI+zFVqch/VWfFAjpu9+HG/eBBaJI3wyJehOVklmawytdC1kSu2F
         UnvVNQ0bFLu8R3jH6HiaZueqiMCI6tnhy/uc0CG3HWhdxJ/jlxQHe6IzLQjV0mrFH1Sh
         LKaNYOrmEsdFy5e8muNdywjM17LTXWNsBAzYRtDMiGXe3KJKLtlNAnUIFSmFFRB869Cm
         qV0Q==
X-Gm-Message-State: AFq9FYIkX0Ja2iVZtX9mFFRUG7r2HuxJgJrSzctz5NCDhIpMiT1ivJN9
	5PKFIg9x5YP81YAM46QwDXM8w/p0a35WTb5BuTRcGheCyvz6CDOFkq8tXtSwFEzp4z0=
X-Gm-Gg: AYBFou2ENtPSkF1y1UjBrY9EWNnwePNxKzp0fsi+It/uF5WCjSTmiT3OPGoHrhT4Z7+
	5lB9rsH7UHuDNVP6tNUtrOzb1UZdj1UIUQ2fI/NNyqSTvtTa5OlmcWRlJsO/o4MqJPic+M20Wvk
	Cfcnd2PRBgkmA3WLwn1u7nCg8rCheXfDFjZZoo+wgUIQEZFCECNnbsagBGODqUgVga4+bWK9Q4w
	ut953Osa8e2mFejsC8b10iuv/au/kSZ6E3HpfxviK5UCt3Tcqx5YuhMzv4GBIaxq/YFRd8BoKOy
	qKIzEC80Kpz8w/rnB3qIGfe5oWP18l3isE5kxSWQ4XHuNYN6nJaV72aReFchBmA5+i7VgVyS4z7
	Xl1H9XAxuENTZ0cGkWUULLyxSjwbDopbruvXsi5t2wEYCSc6r7baz3nZJctypsKL4BOPUG1emP6
	VbeDR3nPqZm//0yltVQFyNLM2ruvMfnaoFCgLFJ4fdZ85jlTJ44oJCLEWLM4PNZe+/7xsosD94X
	XZ4YgGwPskKVZcaKPf/DmA67U55H2gg87rmKCx0+0aVNqY0LSIZRVz8aZGfOGKNdvJH2JE+3u3n
	GvWqBDeLkkbWqLWDEnllpLm38SiqvJ/2rfCjgo+Rm/XYvUsO8HOQfBMU6Ci0FbrBDyZCO+sN+iv
	Kq3PI+VUSpYR2w48Kf0MOysJvc54=
X-Received: by 2002:a05:600c:3b1e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4a9665870e9mr66989745e9.15.1793203583947;
        Wed, 28 Oct 2026 09:06:23 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:23 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Subject: [PATCH v2 0/9] ARM: dts: omap: dm816x: fixes and peripheral
 updates for DM8168 SoC
Date: Wed, 28 Oct 2026 17:06:01 +0100
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4V07ZhOgVpd+R+GBZQB6qMlbSUaw
 r9bMC5dnuTec2YWyBsK7JTNzNNkgnE2gdhlTA+17QlMm5gJLiRyLGGsox6AbtH5EtqHQqmgjQF
 E0eSlVhyPnWTpPXrqzGszX6ovh2dzJR1X3boYTEiS95aecN39KvJvZULg0BSaci7wwIU6342tv
 ds737NqWZYP2kByONEAAAA=
X-Change-ID: 20261015-patch-ektor5-dm8168-dts-24b35c8019f6
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=2377;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=KPWUh12AlBMdTgY4W9Vvurzty1N3jd/W9TyN0OVcNqk=;
 b=jpFHpzmJ+Cs/Ugc/qNMlaeTbGp1SvOlBHHccwaTTgEAOwYwXAs/JkeskmNRK2Vi0n1/UsSoTt
 DbD9bv6fgUtDCFT+bcF24gpHTQ8QDlVsw8iFEUuBvKbSIFJmGbjIMuk
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

This patch series collects several fixes and peripheral enhancements for TI
DM816x SoCs and the DM8168-EVM board:

- Pinctrl: add correct pullup/down enable defines for DM816X SoCs, which
  they appear to be inverted respect to OMAP2/3.
- SD: explicit pullup disable in DM8168-EVM SD card pinmuxing.
- Clocks: Correct sysclk5 frequency definition in DT.
- Storage (MMC): Update MMC node settings.
- USB: Update MUSB node, enable multipoint mode, dropped usb-otg hwmod.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
Tested NAND on DM8168-EVM, seems the pinmuxing is working fine.
GPMC_WAIT is left with the pull-down enabled where a pull-up would be
preferable, and GPMC_WPn is not muxed (reset default). Neither causes a
functional problem.

Changes in v2:
- Removed useless "Prevent USB being put into idle" patch.
- Dropped "Match up capability flags for USB" patch.
- Refactored USB node patch to use ti-sysc instead of usb_otg_hs.
- Added "Remove hwmod code for USB" patch to complete the ti-sysc
  porting.
- Using DT include instead of dt-bindings header, dropped patch.
- Link to v1: https://patch.msgid.link/20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org

---
Andrew Goodbody (6):
      ARM: dts: omap: dm816x: Fix pinctrl range
      ARM: dts: omap: dm816x: refactor and align MMC node
      ARM: dts: omap: dm816x: Correct speed for sysclk5
      ARM: dts: omap: dm816x: Update USB node
      ARM: dts: omap: dm816x: Remove hwmod code for USB
      ARM: dts: omap: dm8168-evm: Correct SD card pinmux

Christopher Obbard (1):
      ARM: dts: omap: dm8168-evm: enable MUSB multipoint support

Ettore Chimenti (2):
      ARM: dts: omap: dm816x: Add specific pinctrl config defines
      ARM: dts: omap: dm816x: use dedicated SoC pinctrl

 arch/arm/boot/dts/ti/omap/dm8168-evm.dts     | 17 +++---
 arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi |  2 +-
 arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h   | 20 +++++++
 arch/arm/boot/dts/ti/omap/dm816x.dtsi        | 81 +++++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c   | 21 --------
 5 files changed, 83 insertions(+), 58 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261015-patch-ektor5-dm8168-dts-24b35c8019f6

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>

