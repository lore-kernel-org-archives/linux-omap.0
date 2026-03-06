Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79133043DD
	for <linux-omap@vger.kernel.org>; Fri,  6 Mar 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759247; cv=none; b=SYB92dONvSXwTJFov7s+VyreAwfMQXb9pY8HMKIT2aXZb/zkt6T58LHUXcb2iXBXNzSn+l2R6WBh/OVbh2TZ/2v+xrSb8a8g9VXd1kw6znpEA3y8jrLMjCiP/viCS9VPwwCXpZbspoVxqc9kDIcrECvSzorSw0irjgNiSJT5G0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759247; c=relaxed/simple;
	bh=3a8iGszPay1RUN0vwkRfUPEAflMRx9VM0K3ydtmavxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eu/IRCr7n+rI/E8/SQ9C+7xONI5pTnGGucaREVSyix9Vd3fw1snrtANCHbolk2OgF0Zsu31jpXrS80ixLnzGnBuwVp1EzXCVen5zN3zjpWkNcEU/J2X3pzfMZwHKKMgarOz9FQuov+dxGoqGmBTG9SXwS+6kNjI04Xo/OpaiQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nS3/9lha; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nS3/9lha"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae4e538abdso48006815ad.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 17:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772759246; x=1773364046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xldhKdSLExnwUIprLhiJ31YKhBCjitGVus1su/uXCG0=;
        b=nS3/9lhacfUPPQqy3OEjD2GyL9vmhjjC9nKwsFSuuLwYjVllJj28GaGXJO0fdNveNS
         SL3ivUIULG0wXLEx37Inqgzc8iz1UDSHUmQD2LQrnoEwiQ9rTG9uCVZ+igBOlpjGKt6N
         /3YQruhyD07SGKXotwUKMaJKOWR1TDWPtLxdCze0QF3t6LJs7JN8Rcj0rgzhIgMw5SHd
         Y4tBxH9Kz6dn31p6j/FeA5dN9EEtSKLfVv6hfXvMTbw/terqcrl6Gv7jE85De1cnk7ZG
         enHm/yGIfQMBOW/L6UMDX1btSLTSPHArojofjYLBxGv1V/ETgcJQvIg00VLsPfiZ8abo
         Xzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759246; x=1773364046;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xldhKdSLExnwUIprLhiJ31YKhBCjitGVus1su/uXCG0=;
        b=dC6BwgZKIi6UIpK8d1Bad6/N1RLn1bFpH2HdTyeSEczddWG5K6GlFWQDm+ILHmCUhE
         HUutjH8vxdLcpSuyqviwF7e/p98OPBb8Cuy6Hm3enYZopqTq16PnmZLs0RfhRdlTe4Qw
         hqb0qSiCJ/oY9h3FfeWxFlu1n0vZU/B/ocDHuvDG91o9dAN3mAzIi22da8g8evYuNaE/
         FPEc3eB4/6vwBANuqSa/KI/P7HVeMdMsion839kvcTdJgUhL/jXjIyjLHiAd79XNdblS
         TDVa/AHlAFIm9qcpQgsL30eePjPWItY7336ETXAGFxtaHcohMlZGG6G9INKICG4e5ZTL
         v3nQ==
X-Gm-Message-State: AOJu0Yyi6WRUGMQgDmpPjlWeNR1byOmqFL/5V4RUki6bK5MnGlqzcAUZ
	GFqAWSvHWGMTcCOcm6wydVWPkj2JMq2aPtZIVH9XNyn/c7ODTab5yW/Ov+OHZ8kNIWdX8tyApxX
	zrMt42Rk=
X-Gm-Gg: ATEYQzyXzknjXjaLfmKrTJJr300pIVcFWa7DRjDjeSHhhkqFgl4j2eZ1WsrDX9DN73R
	VYNJFhxAIdL+d9YuCocFOgOoqeaDUBePi5X2cejHIyn8nyoedsgVUa9/CXXp20oqT+V7ARAF2vC
	fa0hKK5l6DKvZ3DXIGsZ3/aE2aHNXL3rWpS4mAhKFcNIup+qKS+INoq1V2b/9kb5Tqii50OpnR/
	CxvgxUgGJ7m9U9WNEurnHHvah/e836s5+Z67PP2r7wDEGwIBZm+QNLKabxNAB+Ap2fd1xu+nbgw
	eojlSLLI28HlAkl6W2CsnJGu14nS3JZFniEffK2tOQHYr6RgSQhl9NfLaZajCtqWB7Di12m7VEl
	Vss4eeEfDD4wUpOP9b6w+FMd+fXhMzQMlNdVjN57cSfu67xxR13evm2MNkQBtHJoZvy1E6Q/Stw
	vd+yKLTbPM4T2OJoSKtgfG
X-Received: by 2002:a17:903:19e5:b0:2ae:61bb:425c with SMTP id d9443c01a7336-2ae8242cfa9mr4937905ad.35.1772759246050;
        Thu, 05 Mar 2026 17:07:26 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45e07626sm172536085ad.39.2026.03.05.17.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:07:25 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224144552.585272-1-thorsten.blum@linux.dev>
References: <20260224144552.585272-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH RESEND] ARM: omap2: Replace scnprintf with strscpy in
 omap3_cpuinfo
Message-Id: <177275924495.1445909.15705115426095519350.b4-ty@baylibre.com>
Date: Thu, 05 Mar 2026 17:07:24 -0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773


On Tue, 24 Feb 2026 15:45:51 +0100, Thorsten Blum wrote:
> Replace scnprintf("%s", ...) with the faster and more direct strscpy().
> 
> 

Applied, thanks!

[1/1] ARM: omap2: Replace scnprintf with strscpy in omap3_cpuinfo
      commit: 5156a8d92cebb531c320c7cec7e527e40232b922

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

