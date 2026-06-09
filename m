Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17A24BD03
	for <linux-omap@vger.kernel.org>; Tue,  9 Jun 2026 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042862; cv=none; b=jFG+fntK3WVdWlsw7wWkhyyfka6lIIoeZU5K1ygBL0ww4bqj2nxu7blRH1sxJ18xECxfnlJbWxg7ifUSlA/eteu9JeVVwIHfo/DIfSK2G/4Jn0d4cH6Y2jun8lQFjWO54aDRamTLUjBN5htHbtf9YgP4tUt4qp1NsbO2nXTrsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042862; c=relaxed/simple;
	bh=pfst8Pl1eMIbnL+CLz2qwcP1CNCJ01jwiT7Pi+Po1Q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kQ52aoKL8XNtx0T/JCQXxsJJufTuKsxTsH/yX+vUg7mpOrNS+YHCCvvMGQ9pEPmjV881HO4/H6Q89Xo8gfy+EDcxtFP2M+Rf7WmUyxLFJ51VkTdy+8l+nEPzQWZfTEvltPrczo9A0JOx68AtJ8+PBCknhqH+qgECzz12zOGBmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JSqBpBgO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JSqBpBgO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842338c18e0so4246125b3a.1
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2026 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781042859; x=1781647659; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuxYNglbzg4w1eq48zhKqAxq6WHek0Yx27zZwn93ut8=;
        b=JSqBpBgOpUPU4YnujU7ZlBFkeoQAFz5S2qGBkqf9kyY99omh+7WQ81++jex9DzmoFf
         156HOgHlK3g42NnoqAxLcIQ675bAOoOGfk4AgBZCqaw/CmvopbvHnUI8wYSOIHd3fNEF
         91IP7masUWzLKhb/qslGjsgxpDW1WQg/D3TGvayx5APOHAfJ4bP21kie+4H/u3cb8kPD
         J2C+kpHCKqoMbd+O/uPf7S+DJ7r3Y0FUBNoGxrjYIX05JscBcvTR0Iwlo18igSn1hAM0
         PAWgp50XcBY/z+hCAGkHoQ9YoON24rr8BiakSIVp9Zkaz2OYKP6eKoPdZd9xz7DxeQvc
         rCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781042859; x=1781647659;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuxYNglbzg4w1eq48zhKqAxq6WHek0Yx27zZwn93ut8=;
        b=IR73nKUv9U9nElnXSLTr2kvJzNHO/tZGx5AC7idcL5HU/OFjdHZs74ArHEJWB5Epuk
         VDBWebEH5bqqRBbYxT8mZ5Lg69MEGMNZURmqDSFRAFlUxqcxOnVkMdZ0EEtBCSueOpDy
         boC1MacRSrGHlKOiPgzjjRVX+E+pnOKKP4CLYKheO1BQ4VTJVb87PiZ4ElOANG6r/VBr
         Kb33sNtXcH0uF07MQvhgq85Zr2dvqNm1mzrSuaRpOPWlN+VNRWqtuxeJWsnYs94FMQZI
         8dBM9LnFfyKjgONJb7QND08SRTybJZfDjTQIxIdA7129sP+Vai21ufYjc3wUpNKEWx94
         jTaA==
X-Forwarded-Encrypted: i=1; AFNElJ81NDKP4plRv8fGNOsT5HZlSVVgRID5CrVm9BrNuKVtN3S4Ajou4hBiKnpte4rCXjKDEbEFEbpDT4lQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9AOYKVUFt2cWxqCS+ifJX4q3+LYh5QetSR1WPYkzSyp+m316Q
	PvD8Ex9KVSZfd1HH8CyBH4rY+QHrJKENqfJgSJtEzdVSeLuRVFmoKAd1ac76Ll/8DM0=
X-Gm-Gg: Acq92OFNIKTcKfqyiuotUEzdWJ8Xtat+FH5xjENVARpXECTr/2r8i9qsrqCcmxEN7yQ
	tQ3vvYgMman0hzPrG5N1RV76utmRGWfTanUfvyNDzjvdRV0KaYS48vX5V+2wd9PCZ9aHy2IRPuV
	OwSS03WENUmsvNIGmnnnXfAl4bhnrx3KzSD48R1BlLPExVYVTJW6q+/apqb7/fbrn7IibXjNrHz
	fRn+fBQSI1VvDKCFzq+A5RGi0GFKMsPdmFoBP40SJs1qn1FKOeN+DmVtKVLeTQ132eUyZoWcLn2
	w0RwhCzkMjepms3r6m66AOzq7HD2WZD6BBxHz+JVWTDeEmWzilmbpbJmibWyuTc9wbLyZfnfZbc
	Jf6cU8u6Mtf7VxV39olbsYUrsG2lLMAsWBY0/T5cf5LlasK1mX8fk3S6jooe+53Q7pBs32OS7XX
	twWuzF0dpc86tnYbEdBAJSbPfCPOg04UM=
X-Received: by 2002:a05:6a00:84e:b0:842:708f:39a0 with SMTP id d2e1a72fcca58-842b0e1e4c6mr24016847b3a.8.1781042859082;
        Tue, 09 Jun 2026 15:07:39 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8428221cc48sm23176324b3a.8.2026.06.09.15.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:07:38 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Thomas Richard <thomas.richard@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Aaro
 Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH v2 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
In-Reply-To: <f3280b6f-7cf1-410b-9711-6dfaae2596f2@bootlin.com>
References: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
 <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
 <f3280b6f-7cf1-410b-9711-6dfaae2596f2@bootlin.com>
Date: Tue, 09 Jun 2026 15:07:37 -0700
Message-ID: <7hcxxzmkpi.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Richard <thomas.richard@bootlin.com> writes:

> Hello Kevin,
>
> On 5/6/26 2:13 PM, Thomas Richard wrote:
>> Add USB tree description, including the Gigabit Ethernet controller
>> (LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
>> devicetree and set the MAC address.
>> 
>> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
> Could you merge this patch? Or maybe you have some comments to do.
> Jakub already picked the binding part.

Sorry, due to travel I missed this for v7.2, but I've queued it up now
for the next merge window.

Kevin
