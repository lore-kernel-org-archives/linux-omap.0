Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F187346A19
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631069; cv=pass; b=dNqWyjyg41oRLwo7VAtpx80XeeVyQHb9VdNvAk/pSKC5AsYr3Nf5byc5wYIpLFh+mB+/XJ/s/AdcSwqZ2w26p6pQTfkchtbmZmxOIMQT2S1h/Gu/fqfNqAbQAboWKD8bZ2FWNfnEk2hYjZYc8EtcOQPdz37ytbyq2Xwd85Gb3kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631069; c=relaxed/simple;
	bh=bC10K83OlDdfvr2htwpjLlKwvpR995Jtaa8b2VaNWRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjUke2LAvMPXZjEUzngqXNcMYZOlbM1hl/V7uP1czWy1fz5bKdO0ovQacjfUN9CEctxLAySjqDXhf2TzcKLqGrd8x1A+ias3v7mpwj4CU10oUbhvrqpfKOtqagRPr2TwwfAMmq9vGUiy2g3YFA0iDFp8EUIznuFQdfq6cORjSeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHe4hmOl; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHe4hmOl"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59de66fdb53so2546608e87.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 01:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770631065; cv=none;
        d=google.com; s=arc-20240605;
        b=QW30HjSl2yL6l8AkukDzmyz4ihlVIkDl8+0Hx/YxGPQXjS+f0jfKuYgYYpNTXS/DQF
         JrPRzRz2mdds3MW5cbawpXrco+8D/FQimP7C7xoLma6VgEYnb7YrtxcftBgGBTNQVZ+1
         sOkwiA7jZwqK5VR+7u3XtRgVSFu45ZC4PkIQc5q3vndUsrQEF6Hvs870O7/jsSpNIwCj
         PFVUm29lwQH3Qd7kdF10HBFDTGUx5aeHPUL+Ai0Ls0+mDETWsza6DZNaqt8Tcj5RK4qa
         5atfPUhka6WD7FQ9+xuHVs6ghWv7jFc0j5E+VD7ZQkfMd0Bu2UugxAtKviFo75OWmI8b
         k3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        fh=oOjKyjgN5A6OFSHfHOZ1WRS/d6jFLu8Y60G65z0mQ2c=;
        b=RMwsa+/8cIlcD22fk2CdqKGQ96VokWLYoFPm7v59LDxI+pi0pFz6zA9rkzF75xGR5o
         GirSM/hY131gq16EgtjhqvDh8r2ZlJ717dNGoKem5d5g29OK8LfFJpL4llm6gJ+GtS8A
         jOFR9T0oyEDVdhV4Dn2JQrrLSNpR9dz35XEOn699CBT8UIB3D4qlAmWkVmbImicPcE8I
         oWf/lGFjSyQ2m/vXPbB5XM3ueCti5oiB1kYK+Z2o2zt0ohd3Uopj7iayWSa339D1eMlT
         aB4WNpdHF07gwzp5PP+zLq9F9myAcC1HsbRKMOCzK0sGrwSDbenOCYN9mNLHHiegxP53
         sfng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770631065; x=1771235865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=IHe4hmOl9w7pUpUQyLkq/OgztYofxuV5/j5kZqVf8IuLW8jsfSkKju7oFLOuFmO+Ok
         OuFB7tI5XhFwXmudwca2G0nYRBQ7eEr59JH2p9nQqOTDdW7Y2gLLMsCnKuWV4LpK8sMg
         QEhJgWugZkGH8AlPG3KIjl+KmD0zJUnuheHF85f1h7T24sKIswi0tGubJyQrgfXVOHcH
         068szk1RA7QB0OCEWzd4kP3VEp4dtKPFLkidYA4mXBpOOysC+6s4HXG+8zne7P8+mUJC
         0JfCkcMfokYv8neInNUS7ZSf0KHQvK4NmCQEumO+4rTfN36qUquObsdAu9osKWCZSwzx
         gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631065; x=1771235865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=NIXgGE+2SeME2HNHxfcOeMwnrpz4itiN0j89eU8eH3dCtSiUQjpNlRbh9NjSJWfkLu
         d3wN20yVm0pE/M1j7JOWM93IOH3iVuVUEbNA+f6x8cof4ktjGTdn8zlve1cjiVLXXAds
         O6a230gppUL5OjeiiMzeIpTfBu7zag+Oe9x0NkNUB+ZMqlfld6v5rF0NgZQ+rdzidKtJ
         ef0hAStj32iqV6spjvHkcIexSqBVvtVoeKtnme/3KgMdS/aeU3SdjZf8QBe3H1oMrdbT
         UyvmUR4pomn/twaOzTUsolDrBAi4dEStj4Ied4USQXRUALvCs+GgmMCxPUTEp5dnqhWM
         KQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWz4iNFFZkXaCY3EveMByAmgZ6XD9/vmX3XmN0eePPKmgbwZNeN+TzpeCRNV7HVirk/UanLBy9NItBe@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3IGpW+xQDEZfoyFZ3cf1xpeyecRrdaxe0tK8BXfjUHXzv+uN
	+u+8Q42RtkT0Oz6v3q32lLe2qo33Icjmv23GirRZv5p2Pz+oBTEXIpZ5h8uoVUhvhgSLnoJjxwK
	a+sU8hN3dlfWH9oe1rNt6pc4LVCfAMyomO30QsIaN4g==
X-Gm-Gg: AZuq6aJAoP6IX6ZJ2gEySmwyd3Wi0ERnQUSYa6I2tcUDUfEIXfs3oyJI8LEH2KpvU7O
	u3d2CmvnhdpevK71/QQlE9Og87NT/Q0Bj2BjmB803fOlbHc/D+PNApDxXqkboYiaFptM46m8tgE
	Tyc7XJrF422omRQXqPG6ud52c10iWXd2KJpOIewVGWY1MtL+ksf2U0zLWJsc+qfDcwOKTHrnqmi
	VfE/gjcCoeTEojWcUJ4u+5KSib47P0SBLXvvZqDG753qi6zYeRUUyEBtr2n2r6IO0Uxj6ST
X-Received: by 2002:a05:6512:230e:b0:59e:25a7:e46e with SMTP id
 2adb3069b0e04-59e4517351bmr3165761e87.36.1770631065180; Mon, 09 Feb 2026
 01:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 10:57:09 +0100
X-Gm-Features: AZwV_QjtuvXehDumL81rfo3XecEhBGMIVZdeTW9qGb9n_Rk2fTCxSh0YYaQSYSY
Message-ID: <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v9:
> - compile-tested on x86 with MULTIPLEXER=m/y/unset.
> - fixed Kconfig changes so that CONFIG_MULTIPLEXER can be selected.
>   through menuconfig / .config as intended.
> - updated trailers
> - document null return value for mux_control_get_optional.
> - fix build error for CONFIG_MULTIPLEXER=m, found with x86_64
>   allmodconfig: replaced ifdef ... with if IS_ENABLED(...).
>   (Reported-by: Mark Brown <broonie@kernel.org>)
> - Link to v8: https://lore.kernel.org/r/20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com

[...]

I have already applied for v8 and it's going to be in my pull-request
for v7.0 in a few hours.

Please send incremental fixes on top instead of a new version of the
series, then I can pick them as fixes for v7.0.

Kind regards
Uffe
