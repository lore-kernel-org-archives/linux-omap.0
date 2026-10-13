Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA949559313
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932770; cv=none; b=q4310Nur5ReIWGk0v62rcuzMifjdX95X26bSTbJ/4e8nKi2C0pw5/svzdDi3iN/d3Av3kNSAtACd3zTAOJx5jFoNIUcBFvueYI08RxnuBKi07SWcm2bvSdPZ9pATR7FN6bAGVhZqaP2NnY2OGtg3zfC4yosZzCbtePMma8UKsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932770; c=relaxed/simple;
	bh=P0iTojnRLPumAawJoInXYGshTudeegPaLeQs4sXNs0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ps4fYm+fbsJI4ImCBD4xP8HqHaRgQDc+f+8Son0f+rNI1ofNT9jVO2pNfMU0Sl7WlYssv/xZEPQhxHiAjIfBLWWshuntlXUZmUCQ7zBD8v1sTW7HHKMvVXsWb6DCPseRtPPSf/Pzzr3Z9tK97RSeC0Tb2SbF8vFQ+EL2fbIus8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpfF/OW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpfF/OW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7481F0089A
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932769;
	bh=P0iTojnRLPumAawJoInXYGshTudeegPaLeQs4sXNs0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DpfF/OW4mKOx30gioxVGakYZvb1rnYKq60hNsIPEL0ThNR5o/pSMaAb3DYO4yBRIO
	 VkBYYa+Evu8HW/Ox2K+VQUlNzuBo0yV0j8g8eTFmG79PZxQEORjR3iyB+AEvJfGYWd
	 6Irow+pk8Hum50eltvGcVVOJLi/YiiKtD4Sg1GaVAfL72WC0ryOo6bALfeGbe7vfQA
	 c+Flt5sMqhiBooh2FiuHP6wa+qm9X6WFpZGjIZn6uBdaXCHeyGlUXqOWJ5t4p9XGkt
	 RBCcUmg/XNQIRHl+iA1pOs6DaZNSrlt4/075APcVz/R261IPRrKuYzCgm90+8L1ivN
	 grzoFspvolw1A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcc6094d7fso2830953e87.2
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2026 16:06:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw37v90n/3e+dKIAKNLyzRbNZ/JNTC23fEcOvVKFstELHHpgaC77u0EOnmyO6EWVL7GWFcVNuVTAbeY@vger.kernel.org
X-Gm-Message-State: AFq9FYLdtx0l8VHGVl92jmeKG6SWKNfxv3mPRPYp13Q+oIr4Jupsj1Cw
	jFVlps85OHvo/ByJdQ2nnIfz6tkU+JYLIXkIroEsRcBgHAXub9obuMS+7uBMMmNoj3POzQH+KY7
	UjMmdkgEK+Mz5KZp6al9VUtwBdNXbMcg=
X-Received: by 2002:a05:651c:b27:b0:3a9:9b67:25f7 with SMTP id
 38308e7fff4ca-3a9c53b0b19mr34618061fa.4.1791932768205; Tue, 13 Oct 2026
 16:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010175721.76213-1-adilov@disroot.org> <CAD++jLnTOc+n2PGpK1NDnNJXwgzTQ8shO_6NqNuADzxY8SyYsA@mail.gmail.com>
 <03f84f8678f0a6a09e10e57c77ce82f9@disroot.org>
In-Reply-To: <03f84f8678f0a6a09e10e57c77ce82f9@disroot.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 14 Oct 2026 01:05:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLmGBFJBACn5NuzjbDpNVySjjxVDbP76mHKjKetSnouESQ@mail.gmail.com>
X-Gm-Features: AclHuK-kqMedjz2wi0_AS5MYo3t5JfIsaXDJBJEGuyzQd9O3yegy0ZIw5takxV0
Message-ID: <CAD++jLmGBFJBACn5NuzjbDpNVySjjxVDbP76mHKjKetSnouESQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: add big endian support
To: Rustam Adilov <adilov@disroot.org>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:21=E2=80=AFPM Rustam Adilov <adilov@disroot.org> =
wrote:

> >> This is needed on big endian MIPS platforms like RTL930X, RTL931X
> >> and RTL9607C who use pinctrl-single, because when SWAP_IO_SPACE is
> >> enabled, the mmio accessors in pinctrl-single perform a byte swap.
(...)
> > So I'd like to hear some of the reasoning about why you want to
> > do this thing, we have other drivers doing this but without using
> > pinctrl-single.
>
> Um, what? I don't understand how that is related to anything with my
> commit message.

I understood is as the usage on RTL9[3|6]* SoCs was something
new and this patch was needed for this new thing to work.

I see pinctrl-single is already in their device trees...

If I can get an ACK from the maintainers we can just apply
this, the cleanup I'd like can be made at a different time.

Yours,
Linus Walleij
