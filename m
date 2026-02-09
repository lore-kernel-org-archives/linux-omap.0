Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50B3793A0
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644430; cv=pass; b=Ks3u319coqgCk8kYzfLuRtZdL5f8P36usDkSMftlGMw/IVvgKaQdOoo3U2Yc8oLM/N84sCw2uYDQla1Lo9Ljq4Thb3y5LCR5lWCja+XuU1FSuY5MP42owgUypg7pHZXLKi6b4TEhUrqL0hW6gEmT3ZyoH9kxWeV14xZwViKyfbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644430; c=relaxed/simple;
	bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msTbUuvUsRFPJfm51erWSKb2lbq23kBMU1ymQF0jobfNFMqOjegbo4d/w+0Jf0kwWw99FNY+CWHUObeO3IzjIEcRymlZIbA1E4syuAm0xNySDKo9wQwiIqxEx0N0HZnCt0p/ipU93J7TAENKByEZQi/dd2Tev2W1mFQntKAzV3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVmlO7/c; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVmlO7/c"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso5122302e87.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 05:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770644428; cv=none;
        d=google.com; s=arc-20240605;
        b=UPxwIG0S8XZZdkfXYdsGsHnlgWKJo8Z7kp0J45Hx33xvwFkPe6vGCtmpAyxzeJ0cKG
         2Hx9TA4RQ9h1UgVbgYhEzvMMf/LooPFBvHYjdvKgcHClxjwANKTQ9KgRCdJ7ojKuQZZ0
         JGRPjf7ImtydBtXrRAAazLqpJfcnUGP5XnLASdcl6T230Cnc9nf7Ced5YDe/Lmk2C+Pv
         JHYWvsn+UTTzxf+p6lXCQrPrjQV2UVU1SiHM2GpLY4G3p6V74PJ+XAhVp6etaeJpDbgi
         YV3COtqjy9LIf2pLkcLn3j7w0qjf6ZwARiEdTBvqRlzj4YyZnpbdoGGQGpdr1FOzTJSU
         G59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        fh=cmQoaLourWvmxGXSRq03LDOKew3DxR7wKjlv/HHky10=;
        b=dw5VvYA7cFpmD610pVhbfrMvzWW5iwSTiwzpkg+X701q5Yli8wl6KK6IkOMHiy2pwW
         MBZVX+l6eYO6s7pW92XQOQs6wy1QrEVaQlcXQ/g39M9bvcw5Jq2VwEJKwjMeK6R/zevn
         ekfL17K1o36Hd1NGCMv5yZiLrmaD0mCLHwW1GdXmWxuk8qTO1t+oa2Y12L5ieEXRvMoD
         /C6R/eyfC8I9nXwg7bPH49XM8+0kCkMBv9sfPZkuN14ExrvymRcdyYN5AybRYGhAymm5
         1tzHM1PbtYeSqBp1CIRjK/787Nj9sTGq31elirZhcqkZneK3+6ktFyb/XaBj16zUj0V/
         zW0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770644428; x=1771249228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        b=wVmlO7/c/GSzfyMCmKmhME4wSvfRsH4WQN0e1cbLojozqWPrMW+1uGV7KqY6fW0eFo
         IrVeuXkuC+b/MBsmxDugJsEJNB8vc/nz+dXEeO/aslFTKRxL0o7kj3hTeF56hBYBmTjL
         M85uVHuczS4dmxXE1BHXmNOZUcuTdpbRffmxYfrR6DfwqPcMK0N94JJRIIVSvxhDsaxm
         GbmvS/L692MsMmf3YcRDrWXovROPzHM3eUb0shWa/mTU5qdU5SO2uiNXNavlawKxeZxH
         Nlieu3NSNcIqYYsHMPeA+/LeYbNG1cWq35JoNU6ElSn5tdpxaOimZy/3dRu1pRxeQU+N
         jWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770644428; x=1771249228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        b=ToWYw2h63x5C6sPfaUzcBkQImobE8mE9jakULM66xUyDX76zxwui4YldXKyVYVFO3u
         wSGVOjnxzgqZW22bV3/cUZ9B/ZvIyvkG4xn0dUn1hdSSTLS5I4VPdKA6Zk0zLbFrF92K
         fkczw12PjBuJnGPUJHgSc82lj+OLjq6fmElv6SyXxCJOMzdlrUICYrCFs+92AnokmNS4
         rQLc+rCfwktkpN7Y4niBUrwuHbdoXIy4BTlcN2matcEcc5ItjDUV1ITcKuCPWw/h7ChP
         ZUIOWzNG3NmNYLjc8bbbzT4eJl1dHNyE6MBlR7xudX1y7eb5Xkfq4bOh8ENB97HWWDCf
         Fudg==
X-Forwarded-Encrypted: i=1; AJvYcCWEnZ+jgWHBPS3gWoS+87VfXqRQXIkDdWOaSD46UWEK+BVhhC1F+lN1iaeNlCGHTocyaGtTwsZjUN1k@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+8gFIS7IXRaBZJ2MQ0z8LshVtnupEQ7Y3z3cL8KtVU3oDxzF
	JnZUHqqzbyFmjUWShnOjIO+NeJOP2cgaWbvJQK/RSTak3YJYj5HAPzC2aKYxEYSZNT5q05o7pd5
	HRV8xI7/Up/MuGFu+XxKKCn01Gn7J9N1MjRmhyid/dw==
X-Gm-Gg: AZuq6aJsj7cUTJoLt1qpT4QGJ9K0tBL8WPQ2Lnh0DGB3yCNa+R2g34WJc8YMBspc7Kw
	yU1baj3GLHrRWXO1z41g6L6O6hs8rQLXLKTar/x+HZ87VP3b8WuuCdygPDKk978ECz3q69tOdbC
	tdtpTZlJlrZukEG7aD3JTDGV4AeYfs2v36BmMtguriAFLANnnel7JVI00XwYKqxEA7TJ1QPvGqw
	5jVlgDCyLKj0QG4tkNrJJ76Z+C22GbmpZSmdf/99mVyS+sfdkFxWzxSlVJzQbi+mBsfaLMk8ObE
	KrDkNxT5oPyoKkIBxM0Wj2kogjY=
X-Received: by 2002:a05:6512:23aa:b0:59e:3fca:fd68 with SMTP id
 2adb3069b0e04-59e45049262mr3618201e87.15.1770644428108; Mon, 09 Feb 2026
 05:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com> <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
In-Reply-To: <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 14:39:52 +0100
X-Gm-Features: AZwV_QiBKZ8ysCcM3dIWhiLTRzG7BAEGejTSAtpE8_Z2Od0YK-CzC2pfzVA8zOY
Message-ID: <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
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

On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
>
> 2026-02-09 at 10:57, Ulf Hansson wrote:
> > I have already applied for v8 and it's going to be in my pull-request
> > for v7.0 in a few hours.
> >
> > Please send incremental fixes on top instead of a new version of the
> > series, then I can pick them as fixes for v7.0.
>
> Hi!
>
> Sorry for being late with this, but as the mux maintainer I'm not
> fond of
>
> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
>
> and would not like to see it in rc1. Can you prevent that some way?

Sorry, but my pull-request and branch was already prepared.

Please send an incremental patch on top then I can pick it up as a fix
for 7.0-rc1. Unless you want to manage this yourself via your tree.

Kind regards
Uffe
