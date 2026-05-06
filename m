Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400B2E9757
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102535; cv=none; b=kKNyOHxRmze/GaiA++HzoT9IZsh1LYtyyZ7JcP6pjZG3PXJp/989JafIa9UI2SGIk8kYJ0UKLmAO5tMxYENO/YLQ2vNq+2PAxp6limBeP4Q/QyKt3NHDFkO1lc9tPxefDWH+NbCgks8YzbdvalrCE6sbI170FlrD4ZBdg9LATZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102535; c=relaxed/simple;
	bh=TDFlAyJw1nUODGr7CJgiZNIw/mOTrHdvnPgaxqyWrIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H8S7jdriM1hWjX1fXNJqh/09I8C7KFoi1SoHi1PMIqfBJTPqOy0pTP4tQXA84lmCkPH8UrVDcDdiwG2CPqXHLABYHwa77vnia6VQb3rxjL3GSXK4cvGdq3Rsx4cJAr49mbAMrruGTvbwTG3qoBKLtUX7Sygg0eWeE3neGb1Npoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GXpETEK6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GXpETEK6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-362e50b4641so82249a91.0
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2026 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778102533; x=1778707333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+3kkHmTsm2rX61tkHXl0gWLDyLZTSYok7GwmcKQ3fQ=;
        b=GXpETEK6PSp8V4gOKJ2seojB66tCYausMgQiarlrQpA8DfAVRX+xxFgQrNhA8Qtzgf
         gpy8xp4WRYD5R3NGt98Pa3urG/Y5Ugy4DY7LcuoafImQl1E6n74lRZ9rDAW3mkuEJDre
         tOpMMZcHlvmhAQohMVNVztCoIAR1XYVREuBxHe5mMHnaiLE+rhBaWycN/Cbk8GnAi2bs
         CNy5pWS9tZBGxA4zcii+CHBW3Zh/P+0sXmVCZun8lK4CWdxCVgWbFNUABfveOXds34A5
         k8J2Yz9/ZnRY+5MgSJ4l0rWLEdv0/Qj8iIVzT1gcbSjew6eebMsFAmYUhtNqHuiCZFB9
         4lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102533; x=1778707333;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E+3kkHmTsm2rX61tkHXl0gWLDyLZTSYok7GwmcKQ3fQ=;
        b=eJUj9Yb/t7lPFv8Wy1x1Fl0cWOAwF/n49M5Y7qJFRHw2y3NrxfhA+3gLSXvtzS6Rbj
         gBQ1SF57TTEopZIV4Hw2e75N5paQPsX0NGzqzowlHBUmCvRpO5hMAwKJpn5v09LDitD3
         OCCVmEV9d9bh0eaXtwbPVwZfAHhDkdfjB8D34Yk8BqdKjgEEug5FEwQEI2XdoR8HTSAp
         ff9uNqQ4UPWf1gFw62IpVQdcSYS+z0fpsSqolTApGaWHJGHMw2tWcIpW2KsDBtf/2JK1
         mLU6cWxqdZh/p6TwlZOSwF1tVuCkRSBOWiInlGreuPQRfCS719iu4J/8eQv1IdiHBE1b
         Jk+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+2ZJ0cKtNoVJOa4pbGbb1nbnb4DyrgMcpyi0Saqu4QMI7ZiymW7gY+zYS+uf7QrqWT36jJgGEFu8lh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BLaV+FHD0HfRsY/Lia9NYO11IMr+f32dLdzG2Cl4WtZZ9Ac5
	906sMKVfw7i/MsNE0Kq4jnSMgYbmmyuAheyJiOmoJFyhXjarBe2C3IjeRsWnzpDKhqg=
X-Gm-Gg: AeBDietXQpBmgLOCOtGzIaI3YR1vwenPlnGlN8Ucdb9hMSXMyJbuZHmun0oDeaPIIF6
	hQcF94GyNKn73gfgq2Nr+B1uMXw5XyvIUOUZBeXouKqfwuVElT+fPZ/REC+/MPURB470cN+rgdd
	RDMyGQQiq6mpy41QQVk5jCxwDVjwIiDRrJHaz84wOkOd3llwVJxnOCiIkQu0zugTaQqqLm5DctS
	+c3gF3kCWQKvvmqBMbp/Kv1F/JsUwLSSmBJrtPG6DAMRUmkOPjQxEUu0h8YZwYEDtRaQr/+vGeK
	APOaa1YMFbqO/WH4bHaVqu7r1MV/VVDeN/QJ38MSxsOQ8ncHAqhC5VqWDVbKyZbpSXceuuyJjds
	6I6mukMjlZj85gfcgPfmUPkug5ZewYhj0qtukGTO6y7ItPMaOWonTtd8vG859CJn0IF+sHOBx6Q
	A9O0daJtfZiFhss+2eZ8HA/+rAeREd4A==
X-Received: by 2002:a17:90b:548d:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-365ab9b8c53mr4534954a91.5.1778102533545;
        Wed, 06 May 2026 14:22:13 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-365b08feeb0sm2272665a91.2.2026.05.06.14.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:22:13 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20250122164129.807247-1-ivo.g.dimitrov.75@gmail.com>
References: <20250122164129.807247-1-ivo.g.dimitrov.75@gmail.com>
Subject: Re: (subset) [PATCH v2 0/5] ASoC: cpcap: Implement jack headset
 detection
Message-Id: <177810253253.236754.5359911875458195041.b4-ty@b4>
Date: Wed, 06 May 2026 14:22:12 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 22 Jan 2025 18:41:24 +0200, Ivaylo Dimitrov wrote:
> cpcap audio codec found on cpcap PMIC supports headset detection
> and PTT button through its 3.5 mm jack. This series implements
> support for those capabilities.
> 
> Changelog:
> v2:
> - cpcap.c: fix a typo
> - dt-bindings: fix interrupts description and alignment
> - motorola-cpcap-mapphone.dtsi: fix interrupts alignment
> 
> [...]

Applied, thanks!

[1/5] arch: arm: dts: cpcap-mapphone: Set VAUDIO regulator always-on
      commit: 009f64641db3fbfecf92dee910c57a41c3e77a4b
[4/5] arch: arm: dts: cpcap-mapphone: Add audio-codec jack detection interrupts
      commit: 164f88cd7e0c0fcb950e8b4ba5d8c26404334c88

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

