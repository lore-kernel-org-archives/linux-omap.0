Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E53F513
	for <linux-omap@vger.kernel.org>; Tue,  3 Feb 2026 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077623; cv=none; b=TdWQtXT4bVzPNskKgTdWKlalhKDia4eX/zA0Jl/6EPnMGtvqk1FBDciB4G7p78MKxl8+tbm23u/arnq+hgPlNKItkqGqXiJ/RZRfSiW/gfnCqm1aGOcNJCOCEThMztKl/TUuwqgIAxwoqZ1BTMwalub5yO6j5JsQhulSSljZyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077623; c=relaxed/simple;
	bh=74/WSz0klXArild+qNTMXu5HAVoXnsR2VdubFzeU5OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgG+GnahuF9SbuQR3FBAwgY6B8nRiUuv2ebrKtrnt/QFH5DndCsdicjqGXhgxyWjYHRpqv/pG5PudxuA+ozKOYys+2XSJ9u2vGOkcwwSzCgz2z5Yv8C1xmKglK4keQFM5OyeEHVZl9lyKO3U63A6miWK4Ugtmy2xvpBQAGEVKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLKNESQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLKNESQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C6C4AF0B
	for <linux-omap@vger.kernel.org>; Tue,  3 Feb 2026 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077623;
	bh=74/WSz0klXArild+qNTMXu5HAVoXnsR2VdubFzeU5OA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SLKNESQlId2a8NRBPqQGZn5WQjpkO5B1FQAiWsXcyI2CQfb2MOzMr8PyOLEITeCtC
	 ah/G74xhRjV+qR6QUViFKxyCgI2yV32+bx9Fb8DsFOS/6Fazi7g+XSQQvvmTQUg/J7
	 6jr2y2e6Ow0o373DXuwc4umHP1HyRVq7oln5T+yfrDISudc3Lgl5zlD0oFn48YAudH
	 6G2lBoo7GvTwP9S4ZOb3mipAwYeslFdCIX7ULeH8NbLehbuiHk7Dimv2MAG2JqTT7U
	 wWQiE5zxT1111IeOerlvWrvsrqTGiiAhilgJy7FaXD2n3pA2wLa3r01oovsdoK+P8V
	 bsbASbxsi8V9w==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649bff225d4so1656519d50.2
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2026 16:13:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6yMzIqrRBfJy5Pfp6XLgq3pymfdLtT+laLLcUjbhV5Crxs5NoL94gsyrzjCU1G+fDst9yXLcazU8Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9efCgfRKy7HFxuDbyghwb2wTP+mxLdmrpGmYzz1uJKWXRG2YN
	du4tLYYYzo73dOLGlzdDYzZT2z0mpIjx2uYKewa3aIbL7OZuSd1zHTKRaBiMSXKQ+NGtncqg9eN
	Rq7qHG59S/cic+Jxr4eNwEAabw4qTGOI=
X-Received: by 2002:a05:690e:1687:b0:649:b1d2:4915 with SMTP id
 956f58d0204a3-649b1d24adamr8861755d50.48.1770077622616; Mon, 02 Feb 2026
 16:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-upstream_pinctrl_single-v2-0-40f8063cc5a2@aspeedtech.com>
In-Reply-To: <20260123-upstream_pinctrl_single-v2-0-40f8063cc5a2@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 01:13:31 +0100
X-Gmail-Original-Message-ID: <CAD++jL=OXJdJZpjbo0_C03vcgPe5btum-J0uifvSJkMaUWG-=w@mail.gmail.com>
X-Gm-Features: AZwV_QjrSedGM9ncbmebsgpUkO7L1UvY-Meo5qc4rUg0SMHd3RslWKmtaKN7o7g
Message-ID: <CAD++jL=OXJdJZpjbo0_C03vcgPe5btum-J0uifvSJkMaUWG-=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: single: bit-per-mux DT flexibility, probe
 robustness, and consistent pinconf offsets
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrew@codeconstruct.com.au, BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Billy,

thanks for your patch!

On Fri, Jan 23, 2026 at 4:41=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:

> This series is motivated by the pinmux and pin configuration register lay=
out
> of the ASPEED AST2700 SoC, which exposes several limitations in the curre=
nt
> pinctrl-single behavior on bit-per-mux platforms.
>
> On AST2700, pinmux registers are laid out contiguously per pin, with each=
 pin
> occupying a fixed-width bitfield and pins packed sequentially within shar=
ed
> registers. While the existing pinctrl-single,bits binding can represent t=
his
> layout, doing so requires manually constructing offset/mask/value tuples =
that
> do not map naturally to the hardware model and are error-prone to maintai=
n.
> In practice, describing pinmux configuration in terms of <pin_index func_=
sel>
> better reflects the underlying design, improves DTS readability, and redu=
ces
> the chance of mask or shift mistakes, while still preserving
> pinctrl-single,bits as the preferred and fully supported binding when pre=
sent.
>
> AST2700 pin configuration registers follow the same per-pin packing schem=
e as
> pinmux, with both multi-bit and single-bit fields arranged sequentially p=
er
> pin. However, the current pinctrl-single pinconf offset calculation assum=
es a
> linear per-register layout, which does not align with this bit-per-pin sc=
heme
> when bit-per-mux or function-mask configurations are in use. Aligning pin=
conf
> offset computation with the pinmux logic ensures consistent and predictab=
le
> behavior and avoids incorrect pinconf operations on such platforms.
>
> In addition, on many AST2700 systems the SCU register range containing th=
e
> pinctrl registers is commonly reserved by a top-level syscon node or by
> firmware. In this configuration, devm_request_mem_region() can return -EB=
USY
> even though the registers are valid and intended to be shared. Since
> pinctrl-single is a direct MMIO-based driver and does not integrate with
> syscon/regmap, failing probe in this case prevents any pinmux configurati=
on
> from being applied. Treating this condition as a warning allows the drive=
r to
> initialize while still reporting the shared-resource situation.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

I would need the pinctrl-single maintainers to review this before merging.

I personally would not try to extend pinctrl-single for this, I would
write a custom driver using as much of the existing helpers as I can
and use the pinmux =3D <...>; DT property.

Yours,
Linus Walleij
