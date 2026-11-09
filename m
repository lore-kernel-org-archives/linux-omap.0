Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268113;
	b=qUxxqbIx9lxQ/claET6zf/Y98pESVzRt/V8FRgNHND3USs3/s9QKDfbMWzhMzkgJw8CY
	 UNbHEiT0ElcGZZuDmzayeUYeYeqhHT7aXPNDeCC1YeRfmzRpwPYpHmJ2hWOIIZWrSvce3
	 /GBAGLIkSuX7xxeVBFig4z0dJOQatuZO/dmcA9glm0etQaThZ+hVpf7VSCGSXdC4jYkTE
	 9lX9RJlxZFzdIvrWY0gQ4kS3sY/kccHMXS/9CE5bm+MHucoNyKHB6HtUyHV70q33jG7VV
	 NKddL2buyc2+szI/N/O25a/RhhMaOqFPJe3Yt0jdb618J787zoZdCT5UT/t2Wb5nt1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=6QvI65ANWFLjHGTYP+BpY9IO0Q+Q4tp1M4hrdUa1hfU=;
	b=Mp9BYRA189o/cbaB5Jgf9L8s2kdTlSP0GxX2Hw7FeJHZVz04KRbOB8BCvV9acmQoAp3s
	 kDq0b6gMgHc3TVg6cASOb5FURsOFcY78tFewdtdfQ4kjUX9BsHGbOvWf6z4orvP4OAqmv
	 S7qUCF44Lfj43TdkWBWHIr4lR8CY6EGCjXCpcNtDnkFuOAeAAywkPrzfLWV4UWkWGCQJz
	 UnaMTBAThPEAnrXzMviqyze9+pYd8BAQKGRg9z9G2UEGP0MGpY8elx7o1pHICksAQMsqN
	 F+d5RFL5rqESqG8wVisgV/M8Wlxlo20QgDi3j/EOLSuYMyktFEnrczIbg87WvmRq6OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IaJnxcRe;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72160A2624
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B72160A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IaJnxcRe
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso745946a91.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268108; x=1794872908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QvI65ANWFLjHGTYP+BpY9IO0Q+Q4tp1M4hrdUa1hfU=;
        b=IaJnxcReFcjgbLmRyjeMXGhrxzGN74eb4PUsd7TeEF4qhGuPX54MQ1RvR3Y2zlSAcR
         Bqs3BrDRIVjRzaL7NOmAoXjdP+97pne+H6IRbI8gRC1uXqOynbhDXoZoDYRcorIcMklz
         07VcOB6zx7//NaAfc0sCO8UE53sSnRa/AJjxLQhEE6sTwMW2PZzJ6YsOVB2NuybiA6i1
         BPUdWXlnFMNFL3sDgXArYIDsPMBu5YK2QmPKRKnkGR1YN3YjmSlF7PoQSzZK7bNj6Vd1
         XDPczPdNIBJ2vjhNM7o5eI/8zwNvid8O8caSdNg8BLRvW0I81Od0l0iCYPd4Zzxbx5+6
         5uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268108; x=1794872908;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QvI65ANWFLjHGTYP+BpY9IO0Q+Q4tp1M4hrdUa1hfU=;
        b=WRX9c7Xjd0RJKyxjdukd2kXrG4l4ZhjYS06RrQSjWv40cSyIsr5jIMDlabSAeU2bo9
         9LH/+kKMiRm5pknVer7jrUawuoq8QlFMwAOcKTwjxAYw2OGHDFYlU01ZS0ISngROmoxM
         rP+uY5ZD72JgqjluVgA8q7QcJ49UntoTKGv3lHIT1DcGeInSb6NiOVUHd32sHxbY5ddP
         IQ3/R5ZVOpJGUYpInfcnPHzV1wP/vPwdfIrD4FHyxyyduYIAD2ho4nWU6egU/JIIfNTJ
         Bc7JENMbK6E2foYv56Q8UGYWnJPGzfA1pV9RbUFp7WGyOZ2sVM/KHc8l0cyt2ptIqYlt
         8MyQ==
X-Forwarded-Encrypted: i=1; AL+hErErfn04eYEnJwkdMe0jJh2FAHZqCJgs8AwwTzsn4eQk2kZZQ1aQ78lT+t8vthJ8mzg0/B6nap6Pxuw7@vger.kernel.org
X-Gm-Message-State: APuU4Z/KQyFZHczpHtZ7O+/DHMlVptPIV3kBPrUbOUnpB+M4nYo9nKvj
	UsjVJAvkfLS4XbvEkptTZPzJ0ZxU611YILAZu0jsWzdCjGXhUCtlY+7hd0T9Urh9rOk=
X-Gm-Gg: AYBFou2wxjtzIr9td9EtpcfRalXcRdC1SLYDv/UV3dZz8Cdm8x2wX/URthY3Lt/GlTt
	7juZNqVOvRMIL+1SetYJ3FWRvMYrXGlJGCeHfbKYK56+Q3e2F3u0flG7f69fQwd4ZmWTN2Vhqbt
	H1Do5zdAfLCj1RF/TDizRahIjHDC0jvWQjlRsGCZ/idnWlQLIhfmUONADs7REn4Il59MHkz/vlI
	T1AHCzGHVqCsyQzeOqkqx6Ecu3aiHdrHykY9x8H6JgcE73br4EZH2Ya3bq70i9X7qVrjuMIv1C+
	FLeJ+vZn6PZ64zGA2y8LGTlfjGxLQla9NVcEIXVVYI1ji+D4CHtvQvyWSOK39IUTaA+3ZeVemAb
	YGo0mVuc9M7Hk/2TWx1CSNTvzIQ2UIUe7cJ70fzHiPgF/GDtPnwNqX12A28/zeCG9VCbZKwTbof
	p8oiilh9EXNMlpRdREINA0PsLGDBAZgP0TPYAjyB8O0+GuAHMpiWaACGSYlwLEQ9r8uWgWIuOMV
	UPhx427zjYum0U5KAS5FonOUvm6LOOmzErurIk2uhYWD+I8MawwbsIX5mwbotLqBJldV2csAloi
	TEH5+VN201+rs/uvp1JijFI/
X-Received: by 2002:a17:90b:1fc8:b0:3ac:9a5e:9ce9 with SMTP id 98e67ed59e1d1-3b166ca430cmr1173151a91.29.1794268107865;
        Mon, 09 Nov 2026 15:48:27 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b1676e2974sm1411179a91.9.2026.11.09.15.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:27 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mithil Bavishi <bavishimithil@gmail.com>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261106073219.59785-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261106073219.59785-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: espresso-common: Fix magnetometer
 interrupts
Message-Id: <179426810659.2265990.750430446710445234.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:26 -0800
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
X-Mailer: b4 0.16.0


On Fri, 06 Nov 2026 08:32:20 +0100, Krzysztof Kozlowski wrote:
> Interrupts property takes a number, not a phandle.  Passing the gpio
> controller phandle made most likely the interrupt as broken, which could
> affect magnetometer driver operation.

Applied, thanks!

[1/1] ARM: dts: ti: omap: espresso-common: Fix magnetometer interrupts
      commit: b76bf201e56a9c7df1a64bb9388b654cb6a168f8

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

