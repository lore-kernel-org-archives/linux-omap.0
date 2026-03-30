Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA93A6B7A
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907599; cv=none; b=XifXdCTZxIFtHyLWjA6fHu2M1tx4ZUcVr0H9BxrZ5Hpi+X06CQAK4wlTl71MiKOiG6ngyLjYn5nsc3O9yKhcEbLWxg/MdrMxXtH6m2MhIc76f75Lrw+s7OmkYHWpu0/0FXn0197KT9VMo7rkJcF6BdUZ9sH/YJLbB5rGLvcRUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907599; c=relaxed/simple;
	bh=4jTPZVvGwUIlEBcgQGdmD1Mj4Ocux/MAzit3JUzidYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gNYbThMi+okbCvr8NxqAHP843nN9t1LfTaf1GVkvcwOFW0PtTG5x2glIBEvFVhNFcSq4bDwi+kx7wC1xX/QKQNeseUXHv7BgFbFfvPEQKX1h0o8dtpzfa4XZyyMjZgbhIdA7GEtzdeq16loDr5S63ARwb8wp50/X4TSiejIYqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S2xCY4t1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S2xCY4t1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cd98be655so88238b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774907597; x=1775512397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nahCW0+Ro8Vy+N/mWFUvcaNK++QL1eNsUklGbOxkbK8=;
        b=S2xCY4t17JLGnEri36yQQnRaskGpcBACA+piTtYlOfnLoBFU38Rit1LSD/ksz85Arg
         C7dTWE/uSHLi7yi8xDRIOZp2JFXF8qT6rJQv5g4zjOfIwVZzhZT7e3x737+3brTCMCh1
         xVGmlDxP5Zx5H1bYvvFBkl1zmeNGpl252c3iJsl8jMu2AzTOA+VHVZOhvGgqwYfSYPFq
         BlNnB/vVJD4pw7YUjm4W0f73yFDspHWg+S+weI7yrkWmzMzpBXAta00S6NXM9YMpssgD
         Itx7Wyccdi2pFfLDW2aKT2Zs1p/7M7FcSTxDXLvx9v/3gz6sglIqril0vCklLuJACEGo
         V8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907597; x=1775512397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nahCW0+Ro8Vy+N/mWFUvcaNK++QL1eNsUklGbOxkbK8=;
        b=PTGckDNOLf/0/Bazn3dBwNI5kPBUHdEaBkHV3yYXK195O05SfJ1WSN5dPUbBJWEduc
         VjZcpj8fRl2oyQL07xxWpwcNXu8z+mnc214wH7xcau4wFSxyX4eX0atVnwVHVmETSRZH
         9f0/Tl//P2ZjXnjI4H+lgievgeCAfUeiU1EYViA0EZJ/QFtOM1w6M5uZWVunzwIspqbM
         6gQH+vQkp+3/GOGzetvboM15c7ho0Z71z5dzBbYb0hcdhj1Yhn0fefYbElYgND5L/PJ5
         rcy5aGjR/MyUnf0aIv4jmjNIaKlJxG3Ta2cKPZkbnBPJReGJJR3H28C4kFeNZc+Gykn4
         GXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6lBxMX4NkwmRJ33RUX++ZIMLcm28bO/u7Bl5SrZHEwdH78+C+LUA6zhkj+iljZJOg59XmMxaL9AGC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iEDtcJZG0rTHec9vZjXPNemQrcOjwPndal6HqR3VXIGeG4Gs
	X31c85HNrOYS6dtpgv5b/lReMv3OGMpZMMgIvYz+hsNA1AZc1ypEagdlsX+jIMyLlb6UxpDdUxP
	PvqjbzSQ=
X-Gm-Gg: ATEYQzwkwSgKin0siS6obKSd5fSdo7+H6JxUFAJZoD9r6h0HofbPih6M8qH9XgHnDID
	OfrUf1aWvJeFe0xC+0dvUkkjQLD7mSiS9WoLiavBLm5D+cpX3R+c0gtR12nfE9VpeXgGjaNSlty
	xmp6mbKEXJbNQIgvI0dMt76rYkEhWr7ZCNcpLkp6rhDIILkQUeVYnR+rAVwa2AQSdH7MzUrKcJ6
	UWmnX9xhFEuSW4ZKBkvMplAZLPMnqsO9vcDo4yxDsNzOPqu+RCNg/VovwNxP3rN01+9IqAZkOsJ
	iWCWgGStagRi4YzN61e6iV2Z22aPWXRvlmgE5GvOyYE9O353iua7pR2pGaI0eJjZbPjAfGCM+qQ
	fYoVYEq5zzagfqvAzLreLRAo51uTH5oXJF5BW8QHaRz4RaxHrqv3V9CYU4qlERZOCYC/y+1WCCH
	LuFlw+bKqX9VMCThNuMkk=
X-Received: by 2002:a05:6a00:cce:b0:82c:d8c4:35d with SMTP id d2e1a72fcca58-82cd8c40707mr536001b3a.14.1774907597268;
        Mon, 30 Mar 2026 14:53:17 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca846e08dsm8289266b3a.24.2026.03.30.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:53:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
 Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <aca7HnXZ-aCSJPW7@darkstar.musicnaut.iki.fi>
References: <aca7HnXZ-aCSJPW7@darkstar.musicnaut.iki.fi>
Subject: Re: [PATCH] ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX
Message-Id: <177490759624.2030917.6444864958465208539.b4-ty@baylibre.com>
Date: Mon, 30 Mar 2026 14:53:16 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Fri, 27 Mar 2026 19:15:10 +0200, Aaro Koskinen wrote:
> On OMAP16XX, the UART enable bit shifts are written instead of the actual
> bits. This breaks the boot when DEBUG_LL and earlyprintk is enabled;
> the UART gets disabled and some random bits get enabled. Fix that.

Applied, thanks!

[1/1] ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX
      commit: 7e74b606dd39c46d4378d6f6563f560a00ab8694

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

