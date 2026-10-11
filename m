Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A29331A65
	for <linux-omap@vger.kernel.org>; Sun, 11 Oct 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749670; cv=none; b=dTsDc4E4MAmgBGZEHZHYObDcMklsK4RMRkm/3Rv4VhN5eDMK44xw5byr+fz7GQJEid6UPhUs5pivQ7Pn5ZACXZw0ukKv0q4t2JUCYEppC0Wy+wtXmf6MipMv9ocNbAxuYfnBfEAeDB32ZGk1Vw2oX8g9PxNrNQBXCR6gh2yVhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749670; c=relaxed/simple;
	bh=wFATd3AKREDjpA0f6zO3k2HYKpHRpHqvKk6gTZrn6/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvzRDelOjsqUR8vzMsaCufnEXwkMPzoRWOk1qFTf9Kor0OMTcHl8/i/jVXkX+Ul0CeM/P1PH7ubo2/Antzs05o/jouhMSUGvU7AE0NHoHi+ldB79cIDQEpzjhkhYHmRSUWHMWu8oiBvrYe+S4urASC7q1SeMii9XZe/Vo0dWzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHptSIYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHptSIYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0B71F0089C
	for <linux-omap@vger.kernel.org>; Sun, 11 Oct 2026 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749669;
	bh=2B6yxoun5grNXYDPaHbatpr3XqvAdqs6leClJ2sd5R8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iHptSIYnEoXY75N5KOzg4E/xkRfjBaZIkYloNhEOKhQbrhZTB3u69gX372ImDPVVS
	 Dm+InQ/5B9Nya4ueKj0KzFOwsMZk70RXneY/mpGcJ6AWHhgGx8hnMVli9xwNyQ6g0+
	 0MZIIDTj1E+a8qGy2Suu/StXxvqCy52wB+Fx0r+Zktp3ifU2OAnqX+j9PDLcy+yLZa
	 AbPSNM+89qrc4PwzdJEykbdom9hzduReaWJg5LUrVt8s3ArsQXd0Cl51g4jzMgUavZ
	 a0Qbfiwv9XbC8CSwAa1O/iNpZs2YmWbdnPTTFMx3twMa0bdU8QpUcEw6xN6kdN2CA2
	 6p2m8SXEcdyyQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bccc96684dso626720e87.2
        for <linux-omap@vger.kernel.org>; Sun, 11 Oct 2026 13:14:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByjjjo/xtsV87EbfeZQQcTTvC3ErqAuhtXCDb77nab8UPR7E8tbxXqSNg7YFT+Tz3CvDUkOF6D1mH6+@vger.kernel.org
X-Gm-Message-State: AFq9FYIjTSHLBbUf52WWeDv6FIqcwUXDyhIcDMKXDrCkx/s13b7iaAhq
	w6UrhbAsfCUbOue+nlf1hk+FgzVjpUH/kH8hk22b6XrAILA/8+ntM8sJL3LKR5LKuw8iD7H/7cD
	xQRfkTEyhe+AUTVGZZC9UsUVy0VCVb5A=
X-Received: by 2002:a05:6512:1155:b0:5bb:7beb:20c2 with SMTP id
 2adb3069b0e04-5bcde8d90d7mr2470503e87.67.1791749668067; Sun, 11 Oct 2026
 13:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010175721.76213-1-adilov@disroot.org>
In-Reply-To: <20261010175721.76213-1-adilov@disroot.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 22:14:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLnTOc+n2PGpK1NDnNJXwgzTQ8shO_6NqNuADzxY8SyYsA@mail.gmail.com>
X-Gm-Features: AclHuK-Ke9siXQxkd32F58VdGeapNv-uCnv-gmOvNgN2Tl6ULJ5GCCFCFZi_kuk
Message-ID: <CAD++jLnTOc+n2PGpK1NDnNJXwgzTQ8shO_6NqNuADzxY8SyYsA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: add big endian support
To: Rustam Adilov <adilov@disroot.org>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:57=E2=80=AFPM Rustam Adilov <adilov@disroot.org> =
wrote:

> Add support for big endian pin controllers by taking into account
> a big-endian device tree property.
>
> This is needed on big endian MIPS platforms like RTL930X, RTL931X
> and RTL9607C who use pinctrl-single, because when SWAP_IO_SPACE is
> enabled, the mmio accessors in pinctrl-single perform a byte swap.
>
> Signed-off-by: Rustam Adilov <adilov@disroot.org>

I'm not so sure about expanding the usage of pinctrl-single, we have
said that this is used in the cases when you want to stash all the
hardware data into the device tree (such as which groups and functions
that exist) and it seems mostly done to save memory for the kernel
so you don't need to compile in that data for all systems.

The argument that this is "simple" if you just have some hardware
data in a file is moot these days IMO, because you can now just
give that data to an LLM and it will spit out any group and function
definitions you want.

So I'd like to hear some of the reasoning about why you want to
do this thing, we have other drivers doing this but without using
pinctrl-single.

One of the driver maintainers have to ACK it too.

> +static unsigned int pcs_readw_be(void __iomem *reg)
> +{
> +       return ioread16be(reg);
> +}
> +
> +static unsigned int pcs_readl_be(void __iomem *reg)
> +{
> +       return ioread32be(reg);
> +}
> +
> +static void pcs_writew_be(unsigned int val, void __iomem *reg)
> +{
> +       iowrite16be(val, reg);
> +}
> +
> +static void pcs_writel_be(unsigned int val, void __iomem *reg)
> +{
> +       iowrite32be(val, reg);
> +}

Why this indirection? Can't you just assign the standard
accessors directly?

>         case 16:
> -               pcs->read =3D pcs_readw;
> -               pcs->write =3D pcs_writew;
> +               if (byte_be) {
> +                       pcs->read =3D pcs_readw_be;
> +                       pcs->write =3D pcs_writew_be;
> +               } else {
> +                       pcs->read =3D pcs_readw;
> +                       pcs->write =3D pcs_writew;

Maybe they should all do that actually, can't we rewrite
this so we just:

if (byte_be) {
  pcs->read =3D ioread16be;
  pcs->write =3D iowrite16be;
} else {
  pcs->read =3D ioread16;
  pcs->write =3D iowrite16;

I don't see how the wrappers help and I hope the compiler
just optimize them away anyway.

Yours,
Linus Walleij
