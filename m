Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290D420486
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199883; cv=none; b=RyQkFMA+VEzSB2VZf1WYS7z/nLjdn3rRvIO0y441DsKePsiLezK0Zn2dflkgWx9SeEgTRHEauTOMuYX4fOAffxKScNZYvc+Hc5nLhqFnBiD3LQrOEbTCTiZesdpy4vAdmhUkjjX6wMONPHSKdNpYmjn5sIfI7GQ7K/Tn/FCf4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199883; c=relaxed/simple;
	bh=GwvVmdOasksVQpTljB1yONv+ydx6AdGFOmBJEsuZ44Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kFTgS4+N0+6YwjXpyqANzM4pxMfAI6BYsImrspbNiDZspDDNh/9LKkGrx/bxPPlM6HYCj8aPb255g7R9Rq6APqZIpJTJG0hfMNllVUO+JN9DveDE3zYllqinhCT/7xigEMZzIKHzuRxH0zHyZ2/vVTbP7aBDS0Ao3s93rF1vos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A1c0ZIc1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A1c0ZIc1"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso70916a91.3
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199881; x=1788804681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HY8aVkF7j6juR+nATWesw8MV58ZoElmwKvQ+IQ/wROo=;
        b=A1c0ZIc1QmUV4KAlhXdTKv6KAdA8YI43TyW+oTU2iX0wWtIgcjLF6OGOhEQAD4/R9U
         eIj+fXec7VmepV659hDg7gkNuJWk3B2jPEfV9jqDZs0YaIY1HFybYCS+2g1NFvrQMgag
         6li4zSIq85/s9qez3EPCHGKuAiyqJlh9CnI+U0oinwGMzn9uQQ7xMJhZm5sM7x/b9w5Z
         H8q2S3UgBLgfjkglVMlavAI0NsNO+BRMdIuHA7CZpo+HPVABoyMzL1AdA5wA/QQ4DEv/
         pafwew4AxS8kr7XQ4mLub5QA0JOMScUvlM/mw4AvpLPIjG0DRZ2YdI2/xxAKKs9nF94e
         HBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199881; x=1788804681;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HY8aVkF7j6juR+nATWesw8MV58ZoElmwKvQ+IQ/wROo=;
        b=MDpUj93xvccgH3PWG9u1jB+FNKf+I0GepDc9mmXqXdUyjvTomJtR/VhFQbsaZD+y83
         plqgE+Hw5QLuYEawzRmLBcPtC6ASxAAyKVZYtHf4AaEXSwkKWXUeAOGYNUIbeqot2LFo
         Mkx7bmQG3IKu8dkr8GMoxUG/pPG9dVYUOukHMVoC/VF1wvtPhCxq8a7rWwM81QrxQw1i
         Wex1pC45BAzMJ2EGe1UCCLKTz06PDN9zt+K3h63x3+zvdTGPJtVIvPGA4CF7EcpkgpVg
         FEaXLjlDDPskuDk/tNIGmxP3UFuVl8g5vL1Qb+qYDH/7FyWVCNaWaO5Wc6N8wNJgKgt7
         Zq4w==
X-Forwarded-Encrypted: i=1; AKwUvBwrREpV3eV1iqIxSGeFCPobgjo65dkTwjsfZCyUjjtHkmbMcFToeICfZQ2CKIsPWY3P2EdIMUYZlLIt@vger.kernel.org
X-Gm-Message-State: AFuF++kTVG3QZWQ4WB3mYP3Aq38odyggDWtmurUHhQNEH8k7HDL5ZZMx
	AT9E3R3I1Jb/uheSHLirNcM6DxLT8hAEfdhue2M2kvmPZw80jS6WVrtm6BjA3bGLZIs=
X-Gm-Gg: AYBFou3+UFNpfodlly/dumzR4ELPrNi+dCeE8Kaz5P1taiddp4PbJMvP8KmONPv3Vun
	FwbYpyRiSwrmoryBe5AENVues8Qt3pv8WIE4sTrZyp35fmuUu2HVjiL2YwNUi09TXgu2DgFN9aP
	DYp0dU+3EOXiuHYCQYwAiLL8CqghHypvYzpndHWPC+8JAbpz2+MfQMEQzHA0+W1rDBqGpwNct++
	HhYoBWL/3WUUX3goPZxGdUDWx77GmqbpSATzqY64J4h3D+VAOdDignPVuNI0BQKrg7yoeQR7c89
	JvIXC27KXZLUNpwTw5hG6kih+gQDvKZDcpyXp42awgshCvgvVNuSOhXK/nMvZcb1QC+jo02mHtZ
	33OdGvipFwTNhpoMT5sx446y6Su1xTzGrzZPopPdS1bL+6WO3NPezmzJjcFOVjV6CkzrDqaHmFP
	u67IlCjl5yOhQJ4/I7xCMW7dtdEmEd0GefFKm5qQkldfjJGs/dm3Jm7UHO8g==
X-Received: by 2002:a17:90b:5102:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-396d0ea862fmr45988035a91.6.1788199881361;
        Mon, 31 Aug 2026 11:11:21 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990bd1b395sm915178a91.1.2026.08.31.11.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:20 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
 m-chawdhry@ti.com
In-Reply-To: <20260719141008.3562347-1-egbostina@gmail.com>
References: <20260719141008.3562347-1-egbostina@gmail.com>
Subject: Re: (subset) [PATCH 0/2] dt-bindings: rtc: Convert to DT schema
Message-Id: <178819988045.2869653.16639071093612124641.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:20 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Sun, 19 Jul 2026 14:10:06 +0000, Eduard Bostina wrote:
> This series converts the Texas Instruments Palmas RTC bindings to DT schema
> and resolves a node name compliance issue.
> 
> Patch 1 converts the text binding to DT schema.
> 
> Patch 2 updates the tps659038_rtc nodes across the AM57xx device trees
> to use the generic 'rtc' node name.
> 
> [...]

Applied, thanks!

[2/2] ARM: dts: ti: omap: Fix Palmas RTC node names
      commit: eaeb86b1194ef162254059ba6a2c5145d1ed7ef1

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

