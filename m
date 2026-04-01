Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637054418D7
	for <linux-omap@vger.kernel.org>; Wed,  1 Apr 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064813; cv=none; b=B6YpJu7OHhgE777PzxZ3aqY1I5+XlrJm3DhYNoDRz3/cMz23IfHyFdTWy++hEhMEkSyj8umBXFtpyz5AGmoPY5MytsgJWRugeVWk+6b79QZ296ujD96CW/NN4+DUkFbsxEAg/DUoRb53//lqQbkPSMs/Q1XMVXTyUuekHzIaL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064813; c=relaxed/simple;
	bh=9h3k+SWXPgCXh3URQw2m2EnXgwEp8fqiTGDr5MkY+Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GKLpaqjp037L7fWKnQQmMLQ4ZKVdlkX4eJPgqLIkrOKb9Jbjw6eavlI8baegsKf0LzchHQoBmIg2GAryycrzcD+HcqMU9QjzSEHfM2YPVM3v98AE+VkamSrjYz2ZNblP0KMmkYOV+9OA0MJI0GIWgWE1ro07YFIz8c4GU2egjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kz7bYdSB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kz7bYdSB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2589c26e3so29047545ad.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2026 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775064811; x=1775669611; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUGrmWIs1eqe1Uc4sRH3g6ZJwCj+Y/CkFLvTuPn+h5I=;
        b=Kz7bYdSBCn8LoFfzqJsW5l6vF0lGMPkB1Ay+7wg2mQfu5i5K+Z0pXhuvp+9mDXUsCN
         /sFLOBjFPsf1EAOkc6mBhCHyCwK1cx8MGNLMcbdPhrXBhkrNN7hZ17PdJCU6pcHNUEej
         ZzIEZ97AUAbAVxbs/Le9/nP6Vn13WxWI7w0WyxLKjuo6rfrCJzDjgVE/5mLBkiDZgCf9
         wZ2PTAvgORD8Z/X4E/YtzJznt/HxeDp3h/cWUEi37WHeJkEeBhyb2fJI8N7R0Jukm6++
         JBdVRAEMKo+PNVxWZ58Xmvt+/yEV4ihREPD7I3mpEcZOmyumLH1yW0d++a/AVcxkzs1F
         BuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775064811; x=1775669611;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUGrmWIs1eqe1Uc4sRH3g6ZJwCj+Y/CkFLvTuPn+h5I=;
        b=IZYNGmj5vMswxZId2ynS6Ic6Mv1Nl4g2O9uY4T4xr+jGS29ZhCzHKPZ2r9rFO7KXeh
         QCur6dVyj23ml77M158rx7Ex/6rFxG4hyEANbru0bDpfyANjEfuXEfI3h89ZpEMfOgCT
         UDaii9nmIEOFQA79DI/yupBMxEdPQEvBwgp49kHiSK0v8I7zlIERj9dxcYfro131a//a
         7+ZQP1jDLPjv1+p/sM0lqux9dRhHfCzCnB6ubjuURzb5nhAXvW5mv37I4uy9yJMJAujP
         j00thwVIBCtzdkNDDp12F/JAx3Ti18E6OVTPvRzWlJ/SUR6x0UhzAwPGF0wo+Mqp5rJR
         PIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLivP0/AfX95HRoemIdYXB2zo6B+7tP6pCcO8u6ED1ly9260S1vFRFgNmSMhQj+eeTfJqgu3BbZrg5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+2I6vmXfAksBPDLYM6g8vWyS5YhyxERMRPN+7ywyNkB1BuQNY
	Lmu4UavzhRpp24CbnnQE+Qgzl3R1LlJAFQBzpjIBrcxyjw1TJqpnaJHYGhZPzqPHDjo=
X-Gm-Gg: ATEYQzy0KwzunLH6In/7OhTGbNw212hM7ptO/2qiEaE/txFXbNCj9m4iVMFRHIw0iNB
	Fk5vnOx7UqoGRKZpP+2FRBQ8jvwTF952IQFbIJR8lEQ7Tz1G0QCtT30fu51OdvDT3u5Rh9MoZMQ
	ahOYwxdb9ia3zYlztS7UteUDMsslDutLMBBw0OMl2dHSjNSaQkLd5/y5XrIgLOUplp7XItX8oGH
	HD0YIyAGW5TWAEIhu3Gzli/l6B+goqMBwJ25dPWBrC1BiIYc3r5fHFzVvuR5N2OAenRhTEfXWSq
	n00V3tSaEIlSIct3tBebL0iRJ7KdNVqMZ7Ym4FArojE8/ZBMoUsBTXK2f4dBuSs1flWpWgVCymJ
	iFnMl5fCRUXCCKCX6m1ChHULztZUdN8aJPjRC08gq69uoR5tzZQL3nqKsalmnKhgavVDLf4IfDs
	JRwvFr3ZJONz6VPPj+7K4=
X-Received: by 2002:a17:902:f54a:b0:2b0:6e12:bb21 with SMTP id d9443c01a7336-2b269d4af02mr44706185ad.41.1775064810785;
        Wed, 01 Apr 2026 10:33:30 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbca2sm2974705ad.73.2026.04.01.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:33:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux@armlinux.org.uk,
 aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com,
 andreas@kemnade.info, rogerq@kernel.org, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, soc@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] arch/arm: Drop CONFIG_FIRMWARE_EDID from defconfig files
In-Reply-To: <20260401082533.214103-1-tzimmermann@suse.de>
References: <20260401082533.214103-1-tzimmermann@suse.de>
Date: Wed, 01 Apr 2026 10:33:29 -0700
Message-ID: <7hcy0ivb4m.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/davinci_all_defconfig | 1 -
>  arch/arm/configs/omap1_defconfig       | 1 -
>  arch/arm/configs/omap2plus_defconfig   | 1 -

For omap*_defconfig:

Acked-by: Kevin Hilman (TI) <khilman@baylibre.com>

Kevin
