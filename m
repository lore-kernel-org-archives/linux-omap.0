Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9133D3D0E
	for <linux-omap@vger.kernel.org>; Fri,  6 Feb 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382232; cv=none; b=m045zI27oavDdawNxZy3I0+KDF07Oz/3UiXZNGU8xfNovBrZzHOERJV6IBlTRnj9L/cPD1AAz8FPDk/9rGg/Im665KB7xet24ErDPfyy0c5v2axSu4H57JXkmIXXQOURwLtAHGLqEjVencZCClf7zCae9K41YplF7g44QXiOuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382232; c=relaxed/simple;
	bh=v/19RVbcpuTIGxbuXeb4ZtmU7F+LfHpGctBk8u5FM8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8yEekE13hb2z9DeVYkyfUmZYc4KQID49XbNsIf8swZx25MiE2spkj5bDjd7uopyfI7A9cox1r0DjhDWB7Mjs5NKy489GqvBUVdprubVCvkLhUch0Ph2FTYAfxu33Iff3OBLeqC0ybPcZ8z/oQa680Gu0crZZy4rVcQHSU5njIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxWs6Qdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxWs6Qdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B062C19425
	for <linux-omap@vger.kernel.org>; Fri,  6 Feb 2026 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770382232;
	bh=v/19RVbcpuTIGxbuXeb4ZtmU7F+LfHpGctBk8u5FM8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CxWs6QdxzudD+cADgI9kk72SezQfAEZu887Psbqkxq/9h9EtSPi0xz0EQHY+Me2aR
	 G+caqMzOWs7+a5VY9Mq/L/iJ/fmxylOrWLefczBR76QI4/B8FxMFDO02u3bbh1AKnm
	 0Kq7UeSAHZPS/8PpyqYqdEco8yD0D5TdXlXsS/a2uNgXtlWMDBgTRO9gzpZuUHeAb5
	 eDXy58knIoq7MyqhxJtHMG47KZ8NfgvdiNnJx2KpQKPhGZQKNDrNKFHndEq4Ye2sDp
	 zxJ5cOhaALpaBhtylTz8vMWCDWXSOVqNcJwUQANeTcFACvB7FRkAvw0/q8a/q579+a
	 cp0RChCm7tO8A==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649b1ca87ddso2187731d50.3
        for <linux-omap@vger.kernel.org>; Fri, 06 Feb 2026 04:50:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ/ZUppMzvsKzuB0sD6X0KsR0mPe7aCMBC35fuYFQvBxou7jVrY/9utJ6xJcB5tXSo/O1J53YsHrYy@vger.kernel.org
X-Gm-Message-State: AOJu0YwSk8yJc5tZxuV6R3eADH9UQsqby7h+qkd1pFrAPtgCNW2ZxVB8
	TvsoQj90MToqSjtRbYZIpQfEi3oF15vrvHpnfRmUvQpbS2AK+D4bs6h8ZNWlnBI8HD82jD1ir30
	eBUYCrby5l2wKcTAOL1tj/CdY+xKdlj4=
X-Received: by 2002:a05:690e:40f:b0:649:c36a:a9d5 with SMTP id
 956f58d0204a3-649f1ea5375mr1789712d50.32.1770382231852; Fri, 06 Feb 2026
 04:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-upstream_pinctrl_single-v2-0-40f8063cc5a2@aspeedtech.com>
 <CAD++jL=OXJdJZpjbo0_C03vcgPe5btum-J0uifvSJkMaUWG-=w@mail.gmail.com>
 <OSQPR06MB725257E71F0B7F7F1013263D8B98A@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <20260206042215.GA5376@atomide.com> <OSQPR06MB7252ADEF2CB075BC40AD7DB68B66A@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <CAD++jLm2a1-G7QQBb+u68DH_RT6kc4=vpqZWQcirvWrcRjw+5Q@mail.gmail.com> <OSQPR06MB7252D5BCD40BDF2A91FF41438B66A@OSQPR06MB7252.apcprd06.prod.outlook.com>
In-Reply-To: <OSQPR06MB7252D5BCD40BDF2A91FF41438B66A@OSQPR06MB7252.apcprd06.prod.outlook.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Feb 2026 13:50:21 +0100
X-Gmail-Original-Message-ID: <CAD++jLkqpRrcgQ2JvbHJY3NQ=KHi8T91aOg2KvAmkVAXAEzH-A@mail.gmail.com>
X-Gm-Features: AZwV_QjznRiO3R7PrXKwCTjHHZVk1DsnLknrKSsSuWnvcVQBwBcOJl2iW8ROiqE
Message-ID: <CAD++jLkqpRrcgQ2JvbHJY3NQ=KHi8T91aOg2KvAmkVAXAEzH-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: single: bit-per-mux DT flexibility, probe
 robustness, and consistent pinconf offsets
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 12:34=E2=80=AFPM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:
> On Fri, Feb 6, 2026 at 8:24=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:
>
> > > I understand the preference is to keep pinctrl-single minimal and mov=
e
> > > the bit-per-mux handling into a separate, more targeted driver built =
on
> > > top of the GENERIC_PINMUX/GENERIC_PINCONF helpers, rather than extend=
ing
> > > pinctrl-single itself.
> > >
> > > Based on that, I=E2=80=99ll look into refactoring this into a
> > > pinctrl-single-bit style driver that covers bit-per-mux / bit-per-pin
> > > layouts generically (including AST2700), while keeping pinctrl-single
> > > focused on the simpler register models.
> > >
> > > One additional point I=E2=80=99d like to raise is the handling of pre=
-reserved
> > > MMIO regions.
> > >
> > > On AST2700 systems, the SCU register range containing the pinctrl
> > > registers is commonly reserved by a top-level syscon node or by firmw=
are.
> > > In this setup, devm_request_mem_region() can return -EBUSY even thoug=
h the
> > > registers are valid and intended to be shared, which currently causes=
 the
> > > driver to fail probing and leaves pinmux unconfigured.
> > >
> > > When moving to a separate targeted driver, would the preferred approa=
ch
> > > be to treat this condition as a warning and continue probing, or is t=
here
> > > an alternative pattern you=E2=80=99d recommend for handling shared SC=
U-style
> > > register blocks in pinctrl drivers?
>
> > Can't you just base this entire driver on syscon which uses regmap-mmio
> > to abstract and solve this problem?
>
> > The syscon is entirely designed as a singleton owning all registers
> > and handing them out to subdrivers.
>
> Agreed that syscon/regmap would be ideal. The main issue with
> pinctrl-single is that it is fundamentally MMIO-based: it always
> requests and ioremaps the register range and performs raw MMIO accesses,
> with no regmap integration. Adapting it to act as a syscon consumer would
> require a larger architectural rework of the driver.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pinctrl/pinctrl-single.c?h=3Dv6.19-rc6#n230

These comments were under the assumtion that you do what Tony & I
suggested and create a completely new driver for these use cases.

Sorry if it was unclear.

Yours,
Linus Walleij
