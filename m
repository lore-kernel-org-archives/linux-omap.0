Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652F3F54AC
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196704; cv=pass; b=uY7jrxf+rUoEYcIYZcWeV6j33cAHboc8wouTAhDQyt9MuC62QaSsWIe/3PS6fGf/fpC+wdLyt7/izCjZfWQBH2vuLF3ENoKoxSCBmt2/lZoI2AcGNFtTf2zS0K0d/5mkKSykTl+h7dhOxWmJnMQoGtnPItWD74SmihvTqV7ljAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196704; c=relaxed/simple;
	bh=EtyyesPi/SDuoE23U9tj/mxfLUReLacfZyExPDcdw48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t33lDa3QnMYmJMce70Esr5eOR8V0gcAKrfEO5nQHXYya4HjhCpRQHAAhJCa55xRYt5hhzAZk93kbsFe0H1PbSvYkCR10o2uzuXYW3vR8LD9PCLYKeex39mH7X4HdFMeI7/zRjSs/NJILnXaxayOqRfk9Mr1AXANt7ccRLzRkSOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU4BwdRU; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU4BwdRU"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c999f162c9aso4072540a12.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784196702; cv=none;
        d=google.com; s=arc-20260327;
        b=dthR7fusVXN737oltZwIw6Dru0i+T2fNK1akQiNvJGLsNWecp+IIW5oPBz48/aNeBw
         wQ+sfK0/gytRkmAepd0Q3pRQIMzEiE1d1GTIvBGbIlAdCVtoLOgUE+3+7HoCzyBpVGBI
         d2nncXubLtH1mUWYHTiPNssTHBzuo+41ZI2mN7m0znHqV01H3h74+PGwr8Ib9vskKGNN
         beWDtK3xXo90VA4GJ7O1GwD+tdiP9LBfM5G/krXJbdlTCe+TUC+yJ3Q01Ex24LhuKqh4
         JvEvbgYn/egBynI+8Fpz3xpWPwPtKj/6K+vN8bYYWWRawD1CibIaWkcC7dFQWf/Y8B6L
         nDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dg7/NRlMB8RPrm27fTBVuBL/SYMjEmUFViVbJSraohc=;
        fh=dYJkDNnLQ4SkjcojQccNzFQ4YBHP3i8HoZZqs63u09g=;
        b=AOZ3NPq/k2VMkuDAv7rbUmlX8DRqH1DrBqatXBlVnIx70Oi5/JIgQmhiqYn5Tkg7QJ
         jIvljCP0fgrHt+37TGU51IFlfxcvGX3UTDn1g+9Cx4YmL+Uj4z6/wqilz9lQrg173d9k
         8UrdSfnjpA0E3f/l61l0NEqsxfFF+9Rvwlx8nW+mC4Ce9rh+kK2anZWfOC58Baz5l/PC
         92CKdFF4bio9oqwf/mVBJJoEMl004P0c2zYGeWW4MPg4yKOc1USsoix1gng877nfRefP
         M7L07hSmhlalpfjmiQ+bpQa5NV6A8hyKFdvRSFus0Ou7AxNTudvi0rOKmpfA1vVFeidg
         /GQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784196702; x=1784801502; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dg7/NRlMB8RPrm27fTBVuBL/SYMjEmUFViVbJSraohc=;
        b=eU4BwdRUHRBC+EnxEjpcupxlfEErp2mGtGraEPpa2Gp/peUfK11lTTZaV5nhXpYxpG
         Av4SGeQIFmSlbpWZNNR4U+u64W5P9x/0aelcfoKpouR5RLJGhCuAfuB2h1mqUPcvZE8v
         4RNh8RmPLcnOgmV5fJyHXgd1TSLtinaHT/J585+DI66w4zN/n1oHSO/ykVQ693A3Aqhj
         0h2Vnth0hlmJvViVlnEpIP+Ea/2F4971qfhH3kCkpgIsm7EnA9CSFopvrgEZDQv1YjD4
         r3FD7jCrJja8j1bm52pMfndLH69OOzVKU6G8iDe5pWbSPd9UeX31IlFRiGgALowsWkyR
         Y81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196702; x=1784801502;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dg7/NRlMB8RPrm27fTBVuBL/SYMjEmUFViVbJSraohc=;
        b=WORgF+GqLAci5/qCVWmeZVO5mIqcuP9N84k06LrwLYHR4g1M79NIvRm+DESUIPNdGA
         DePmiTfeTQ09kKqpHeRUpvqk1b+N4z8mwvXZNVhKcE/eu8psMtQZzV7UT084OKcMyq/H
         pW/2ohWMu/3STKkJtj71Jzu6Upo9tz7DqRYWQ4PkAxnro0cTwRcI8RpuA4rB080znvSJ
         NFsH5zyfJzyB8xXzDd+44224orDJrahr6JWaYgj6Ktuw7zGInTCEtVB05M1wHugfD1k3
         Ayoro6KXvDcmqQ71RF/poDD0RSpIS+gCycdP6dtXPLlB82cww2XYQ8TJU0JX7jx3P6fJ
         K4UA==
X-Forwarded-Encrypted: i=1; AHgh+RqUph4SiLo0uuRjpuaDqO2nsWn9GuSnLuNZJUCogSD22oQLzNDTDOBxZCCKlEf/7OPoEsKQkGlfrQ2+@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkXaC79TdqoE4m4OFJce9sE0PSmPXHPll7lyEwbdIBhkyvuiD
	2qSYXlNU92RmltFPN0C6iwN0TrfdT/utTSyPDbACvSSgW0KbbIxgLVBwwyArg9S0zN1VB1+scA+
	3z9zA3fT2EgUwVuufVINNrzblvY7T/Z4=
X-Gm-Gg: AfdE7cmUcnt1fjwhUMR3TShT7qPeRAJjwFgLSWlSMz7/hfAbnXDvbANf8bLxS4fpKUC
	4nNCBfmDh0Vxl38Ef8NoQD396KSnouX3EERxNnijz1RvocRZfa5NhqNagibXF96M5C8CrduQtjB
	vRi6J2eHXSUqyJelfHJ2oGXhDstcCsZ8Rba6F2ggwvL7OOt2t6qqK6KC9QEU6gb56Kf6S/CbXit
	PzSzB2oqJbpbX7uQjV1lGjo6HbK9RcNTuzN5IRM2uhL8rgKIHjATEU5Zv6G0onSQfkBjjoqpLLX
	WMIUiV/p8R5mU6Ft
X-Received: by 2002:a05:6a21:e58b:b0:3b1:882a:607b with SMTP id
 adf61e73a8af0-3c34d583262mr14456931637.22.1784196702293; Thu, 16 Jul 2026
 03:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716090829.72082-1-phucduc.bui@gmail.com> <20260716090829.72082-8-phucduc.bui@gmail.com>
 <61bfa6e4-d8b7-4bf0-84f2-173384c690ea@intel.com>
In-Reply-To: <61bfa6e4-d8b7-4bf0-84f2-173384c690ea@intel.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 16 Jul 2026 17:11:31 +0700
X-Gm-Features: AUfX_myDJp0AtNfhtrN9LdRrNpl-gy0V4QN3J4UlvY6JsDJC4kIjoPtoLhld9jM
Message-ID: <CAABR9nETtBpAonGnfHMq16zkzmCAHiVND_-NdxsLJKZBomL9tw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ASoC: ti: omap-hdmi: Use dev_err_probe() for
 error handling
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cezary,

Thank you for your review.

> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "snd_soc_register_card failed\n");
>
> Some patches have '()' some do not.  I'd expect all the patches updated
> as per Christophe's review.
>

Good catch. That one slipped through while I was preparing v2.
I'll make it consistent across all affected patches in v3.

Best regards,
Phuc
