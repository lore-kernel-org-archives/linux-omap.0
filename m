Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049963793D4;
	Mon,  4 May 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890924; cv=none; b=sjgt4y90+lmOdlj8SXM+UCc4QrA1k4fvHPTIW9+FUbitZ0jgGfYZE0ZQo9+jtYVbW4h5fESSw9iM1yZi+xin1bVREAuOe30r1Zhyb11qvhuPMxe513jheLgbJdg6BclXuVRtW7G7R8PD72Xm3pHgM7fahrVQZcfyF+ZmT0EHueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890924; c=relaxed/simple;
	bh=8pMt52NWWR9RsCZPU2OIuMb9huhWDEe19E7XadE/oGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E9XjT81dzIaW10GjXn8X0HQnyaUEQv1luRcKvO9TVawhluU4Rgq6gh8l+yxNNF8o5t7tr4/h/J/axYgUNqjnNdG/Mn/i/skvR9BNH7dLSoHnZAbgA4+p1QXtcjpN5WQaHdGrIb3aBaqthlM22xch/kAPR7TjdvVyl0mFEvlIZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=D6/tAwb9; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="D6/tAwb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1777890378;
	bh=8pMt52NWWR9RsCZPU2OIuMb9huhWDEe19E7XadE/oGY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D6/tAwb94e2bfjbOT6gXMv62PDYUFCvTYNI5GD49aO+3mid8eqAtUrRfHYV2okf94
	 Z71J+pmeGym/hzHMNk0YKBitVdt7MPmIX8h5pjnpweXoCOnJqmEhO580qf27fvjIij
	 5vESKsQjz1D1j+mIZmSYSbgRrW5SXq1Gp+Kn9gQ8=
Message-ID: <3eeb3094f1a763ec42a24f0d0edaa0321397543b.camel@crapouillou.net>
Subject: Re: [PATCH 3/7] pinctrl: ingenic: Fix type in
 .pin_config_group_get() callback
From: Paul Cercueil <paul@crapouillou.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij	
 <linusw@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang	
 <sean.wang@kernel.org>, Tony Lindgren <tony@atomide.com>, Haojian Zhuang	
 <haojian.zhuang@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Date: Mon, 04 May 2026 12:26:11 +0200
In-Reply-To: <9f50c234c44af9075b5252ee7e59452ed2179b27.1777562725.git.geert+renesas@glider.be>
References: <cover.1777562725.git.geert+renesas@glider.be>
	 <9f50c234c44af9075b5252ee7e59452ed2179b27.1777562725.git.geert+renesas@glider.be>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Geert,

Le jeudi 30 avril 2026 =C3=A0 17:33 +0200, Geert Uytterhoeven a =C3=A9crit=
=C2=A0:
> On 64-bit platforms, "unsigned long" is 64-bit.=C2=A0 Hence checking if
> all
> "unsigned long" configuration values are equal should be done using
> an
> "unsigned long" temporary.
>=20
> While Ingenic is a 32-bit platform, it is still better to use the
> correct type, to serve as an example.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/pinctrl/pinctrl-ingenic.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c
> b/drivers/pinctrl/pinctrl-ingenic.c
> index c7f14546de0528de..29d7f4e54bc7b126 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -4334,7 +4334,8 @@ static int ingenic_pinconf_group_get(struct
> pinctrl_dev *pctldev,
> =C2=A0		unsigned int group, unsigned long *config)
> =C2=A0{
> =C2=A0	const unsigned int *pins;
> -	unsigned int i, npins, old =3D 0;
> +	unsigned int i, npins;
> +	unsigned long old =3D 0;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	ret =3D pinctrl_generic_get_group_pins(pctldev, group, &pins,
> &npins);
