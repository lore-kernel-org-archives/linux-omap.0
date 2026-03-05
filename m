Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B63A1E6D
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715604; cv=none; b=T/DTLh6G1OrbP+qB4P7JLAJC2UQTQO7rVMzRO3gMe0beUcCCsz4VYIPjRTSamvV0HKDtlWhdk7T+LX+a11Ga7Jjx0wfxn3p+Aq/6evPATbV9AO0f7ErsAl2qwnnXH4BfVKmZZ3Y1xc4bNFeNSF9UGoyEyEW5xrGrDt4Fwsup8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715604; c=relaxed/simple;
	bh=MQFjFILC5mkY+Vwv4pWWykfJ7vYhfaqzdPLfw43t0cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btZgi3MUoMqd0i5ODTGIEATMElWD+so9CyJ4z9x3g8J9dqCLVQAh8jFQNzJNBifVEadBJnLhHNjLr0D+jvkKrRHNNrWrIKG9wM5ZefXKN9UDZSBUdPHZqwqEo1W4ieHqLFOaBtBgUZmiikrmZGkIzf6pAiuGdc/xIg70bFuu0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRt/V5Y+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRt/V5Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD72C4AF0C
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715603;
	bh=MQFjFILC5mkY+Vwv4pWWykfJ7vYhfaqzdPLfw43t0cM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mRt/V5Y+XF1IVSwG8+jgRQQyCvpXzrM2yGEMcTCtiKo92vOK/oYAOcv3PSeRo6LjC
	 4hpJ6MZp11xMwkEB9Ia5N5Lo4ZLUYuS892vquqkFTEEx5MKE0Zjypla34/hbRsbphS
	 4xUuDxfZOdkz/lUEsiGPSWi6n1d9I2BG/yFhmm87TI5WSOZcxOXEw6Ga1P/Ttxd5Lh
	 r3WNQsdzdQ+1TuV++pGiJjlLiHdiBYpVJMZbu/ZnVpgSeCMRnFVj2jq2WeGtTvL41j
	 C8Ir1Z9pBStxgl/rgavHxyBM4Bj38b2tMKwxcOAU+ND9sp3Lz98VfkZdiIW5f5RIa7
	 P8t+8Zc/xswQQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7982c3b7da9so74836077b3.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 05:00:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXt3ykba8+ksFzNHXvkvYlgJ7hD5kkJ3lNusZw0c32qh8FpCqNBxStwgVqsSJctntyldQLe76gVDmjU@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGT6mXXvPIuMNVO+2dDN4Sw5z8dBAWnLAdb7fgXzlIGTcMoWH
	q1d6vczDGo8gMAPXGQS0auH/REv2ZU25xAlw8sE2oL2vEfOriMBOKQvWnUuuuKwSYN/WH5u+keP
	BihA/glJp+s9ntuqY0UvEndwkQSPjK/M=
X-Received: by 2002:a05:690e:448d:b0:64a:e7e0:a70c with SMTP id
 956f58d0204a3-64cf9bd6f89mr3303741d50.65.1772715602763; Thu, 05 Mar 2026
 05:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-4-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:59:51 +0100
X-Gmail-Original-Message-ID: <CAD++jLnW=6CNK3F8T8UHR01UfTk7CUwavB9dwv-Ug266mVcy4g@mail.gmail.com>
X-Gm-Features: AaiRm53RubGlDYUWuLep_26rBrnPyLYf-1xTz_QksBGDgogCNI444BwJT_n_uH4
Message-ID: <CAD++jLnW=6CNK3F8T8UHR01UfTk7CUwavB9dwv-Ug266mVcy4g@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Setup a software node hierarchy for the latch2 GPIO controller defining
> the required hog and stop using legacy machine hog API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
