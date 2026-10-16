Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5436E470
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161684; cv=none; b=sFiXSO5dtjaY8aDJCXQwSy+lo4pjxWidAK8ZLmPh8r1RCkwvdgTw85IZO3yTH1UqvjHhP6zUS9x+jmXl/jdCc9r2hhgqG/r/EFyp/ttOWlDtCUieQr2IhacVUNooVhKA+Bk37lzI+JxXA665A2CP4TjX7nG3QmhkTtOw+d0KWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161684; c=relaxed/simple;
	bh=1fzbjOZRndfB87fivaUbcLVWuyZChYe1cIR0MU0Y99Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sy66mjowlYbLeyZMDG4Y1HhYKTL7eZJYOo6vae1SC+eiUF/Z/Tme+DaTlgJZ+3O72mkewTU968OwWPZ2J29oEjzrqIeGZhYJAsk0qI5dv9fMGzKWCq6wc7NX/r0AjC3sdy1KcnTr6p6rnPJl1swRzIAAky9Hqhn4iU/ucwlyDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sK4C17iV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK4C17iV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so223025e9.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161681; x=1792766481; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lDTSx29sE7yGWUgL48SizWkNhxpx8cSnW73JxIctDwM=;
        b=sK4C17iVCbltjQ/Sy+NU6C8jyEOz+KxbUpYpO3P37HDz4aDlu1/aOsGdCjFY/JjNzJ
         A/8sdGjJDaWW7xkRwN4tGcnivs8e0nyQyV2Uw0kKqf6uN13qwp1CfmHZIL9vvwCVwU5u
         OOAVqcNJ2qV6ccwL+1ibN2hKXR3KpfVe9/Z4uTjRpoPyJfZYKvL/T6mzihAgn7FeDEKW
         +21Z+Ko/k2CnS0a1w7tjnV5Iwb2S+aLwgLNf98Vu20PKlm49lsEFaUGb9EF1Sq/TpKG0
         lkXQBabaKL/PJPJ6sPkIHSLEGmLBpWTFNnoGWPV3VELdp3Lx2obdPofWw4YvSTMVljAH
         UA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161681; x=1792766481;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lDTSx29sE7yGWUgL48SizWkNhxpx8cSnW73JxIctDwM=;
        b=lX0BshH8e7spLl6vzUmUT67hDDk+AxH5a7W0vMX7qyhHfO5dDQ/qBmGQXTw2Wd1Kyh
         WSQUWFHRYDzBoojgnDA9eEE8a1CitdsSh/clhT1M/3bEmVNuJXtzw3G91LVDgNwATDtf
         ZV4knrhPTYx1nG8Kzkeq21i3XgY4zGfHSHfRUf00j5qXVdCxIrWRNfmdQCkPrBx5XTwF
         qaHXCxnAGKCQewIJTduS9VWdEDmowVbujVl1N/W3cbQHyiOBplGfdFMNcCUYRI2sOMOy
         YYciDuwdWgL91hDJudXWLSQ31W55gkhvBrBRYGmnYEKkALQ8Uzr+Ml8RfO/fNNJ9faW5
         QQmQ==
X-Gm-Message-State: AFq9FYKnbE3vYB2BnVNIz0FYH2mMtlI7kwTU5rsl8kBe9659EdRSGCm3
	7qHJB2iRcHYXoso+tYGjHnFg94mOitQg1skW08an3cysMYu52mDJOdKf+V+xE1dlTqI=
X-Gm-Gg: AYBFou0yRlNkOvXFIbKhOiSD8fpQ9EpZMKnlOwzdsMPmUXNblzrIPa3gOnvvxs7ixKI
	s8k7E1eQLTw0xTWbsmC/F5l0LKhTbKZsLFgt34SCv1NvhND9CUVmEylqmL2Z5NxnFXjiIgBnad9
	ijEV52OBgCbJhZwqnDpO9pWy2Nf9T/G3puuoXGtPTiEdWsdMOPwOpOpwODDmpecgZOFx1K9HvAK
	/HoG+GixHC7aQ1G40bgi9VyehtYOIEeMwyqpPbnKEIPyYoiZhsj7UMpjx8Yz0zV17mAAKua9JgY
	NiNuQ3RG8kjeeV2JFKRtism/9XCnsQgmW/13h7+eRi5D2mTUR11iFu8ZSbCal1pzt6E9nTSi9uu
	APJo7yjpJypYcIoPM6ohz9DlxVkvIUi3wmktm8RnAcdymaEnv+s0//f75X6J28Qzp//qpA+EcL0
	8dHjIcoO/T7WYNIuz3N/ouAjI8VmHACFkicrLFCvUz/0GlX/eH0iksS+Gg63Xvib0bY4INC6wNd
	ti6a8iM6nXb4QK3QqjhLoGulYrJ5aH+3B2k3O2QQSotHMb4j5iLTFMgpZ4E1MlOrfGhlA==
X-Received: by 2002:a05:600c:4e50:b0:4a0:1ea2:10c6 with SMTP id 5b1f17b1804b1-4a1d7600357mr109635e9.17.1792161681292;
        Fri, 16 Oct 2026 07:41:21 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:20 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Subject: [PATCH 00/10] ARM: dts: dm816x: fixes and peripheral updates for
 DM8168 SoC
Date: Fri, 16 Oct 2026 16:41:15 +0200
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJp9KmehXjAtpBRiOQTjUkh
 LtbdfkW/2+gnIUVzs0Gmd+iMk8VdGggjt10Y5RUDdZYT4YcLl2JI/KjzNlhegbyAVNRtG1/dDE
 YOg0ear1kHmT9nS/Xv/XV3zmW7w72/QMPW1QjewAAAA==
X-Change-ID: 20261015-patch-ektor5-dm8168-dts-24b35c8019f6
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=1767;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=1fzbjOZRndfB87fivaUbcLVWuyZChYe1cIR0MU0Y99Y=;
 b=c/xAc8G0qC65I2XNar40/+2zImigpn/uTTDF3dZn5BMSqPFymPmfzcSOUI6tdaHJ9aRtkU296
 KILAivamL85A1EvitrGzqXoQSSI9sfjEmI+hWkMKrjghp8c2KNVL8ob
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

This patch series collects several fixes and peripheral enhancements for TI
DM816x SoCs and the DM8168-EVM board:

- Pinctrl: add correct pullup/down enable defines for DM816X SoCs, which
  they appear to be inverted respect to OMAP2/3.
- SD: explicit pullup disable in DM8168-EVM SD card pinmuxing.
- Clocks & Timers: Correct sysclk5 frequency definition in DT.
- Storage (MMC): Update MMC node settings.
- USB: Update MUSB node, enable multipoint mode, and prevent USB idle issues.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
Andrew Goodbody (7):
      ARM: ti81xx: Prevent USB being put into idle
      ARM: dts: omap: dm816x: Fix pinctrl range
      ARM: dts: omap: dm816x: refactor and align MMC node
      ARM: dts: omap: dm816x: Update USB node
      ARM: omap: dm816x: Match up capability flags for USB
      ARM: dts: omap: dm816x: Correct speed for sysclk5
      ARM: dts: omap: dm8168-evm: Correct SD card pinmux

Christopher Obbard (1):
      ARM: dts: omap: dm8168-evm: enable MUSB multipoint support

Ettore Chimenti (2):
      dt-bindings: pinctrl: Add devicetree bindings for DM816x SoC Pinctrl
      ARM: dts: omap: dm816x: use dedicated SoC pinctrl

 arch/arm/boot/dts/ti/omap/dm8168-evm.dts     | 17 +++---
 arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi |  2 +-
 arch/arm/boot/dts/ti/omap/dm816x.dtsi        | 78 +++++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c   |  3 +-
 include/dt-bindings/pinctrl/dm816x.h         | 20 +++++++
 5 files changed, 84 insertions(+), 36 deletions(-)
---
base-commit: 045958acaa75205b31578cb22c4345e28dd2e4bf
change-id: 20261015-patch-ektor5-dm8168-dts-24b35c8019f6

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>

