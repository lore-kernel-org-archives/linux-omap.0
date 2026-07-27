Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C63B0AEA;
	Mon, 27 Jul 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166562; cv=none; b=mHEg/TEQDlaf4cZYrmllo1y28vupZo4jnOxQ8XMIcuOxQq2Y+2UyYlzVH3PxGEH/Shqs9EZk6/jja+mo9rhBFnuiy9ScIn9kUSmR/I2L2j1YINeDBf08XhKlUT6tM9y6iMBguZpT72Wb0UEhA9dzxmjNrDmw0nN1UYWALV5Blco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166562; c=relaxed/simple;
	bh=0uGo7n49a4/PaiQgsMOSEwMnykmYlC/p8tJ6OVNzUoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoVRCC3ka67rq8uYs8NXaAeT4AlRYYwJIaNE+XoDV66spleajbePAyyF5aA7sZ7GwQRezFUo7y+xYkJwZz5+p3HUi0dXQaza463+LWQlHMXau87A6KTtzwNxfKoFyYY5IJAhsPrWjkSi4zCzdORpYnkygaC59iQRe2LiDcaOwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR0PAk25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR0PAk25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B419D1F000E9;
	Mon, 27 Jul 2026 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166561;
	bh=rH0dfJwx6TaUJRP9778eSVp+cuHpBPdxCqvvTxPFEdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VR0PAk25kOTzE8THqAMeXyIQ4iDVWM4cRIM07AXEHoe/7C/k/ktnbEHFIWB8fJeQj
	 VjNd1r5ZFVqeMOoBTDTlUS0MEY4OGSnwJAXzBIEUvMnewMoWOWDHjMULcPcaoSLK2z
	 a7aPaVwplqFn+8mNoq1biGH2vNiSKFWmL/hRwdRp5ZvQmBim74pLuCmuTKHXGiSvPZ
	 sNEcCsoZnPdqbHixGkvHC+yysAjMjqmx2WTTOlNp1Rh401XT3XgyxxE4YCaK4bqBT1
	 3kbMqNHU24jY2NCnD5v0NKGwkjWGgtF99j1vSPP9hJpBZccswonp6S8m7iTYTGNC3R
	 daVrbOWXZhdyg==
Date: Mon, 27 Jul 2026 17:35:58 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Heiko Stuebner <heiko@sntech.de>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 3/7] clk: renesas: clean-up simple provider misuse of
 the consumer API
Message-ID: <amd61_Itb8wOTq0H@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-3-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7jdk6oml7vjgb7j"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-3-56f306156d25@baylibre.com>


--d7jdk6oml7vjgb7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/7] clk: renesas: clean-up simple provider misuse of
 the consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:54AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/renesas/r9a06g032-clocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--d7jdk6oml7vjgb7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnet4ACgkQ3SOs138+
s6HboA//b1oIVu6KgMhWD7qHih0fVg+6Q3uvEb6OaReWRKDnD3Nqllw7sGwwDz5D
kcOBUi3cZBA0RzeiEphBBZ9Tp4kHSIi7RRYW3W+RNHqYHHe1tkqUyJwbrKVawxEA
e6CZMYf754GInAjT1QnThDGLTCK2ufz9jo2ljLyBhPkS1kuqJcLHIrXO52LdAvEh
BwCzJDc5lpSVOnsaHh+bx1qUFRgcI5p/LOyfkhhFMGxpT4OnHZMJlZRdKfQti3QZ
Pbk73asqPr5USZXPiPj8RRce9EwuKvq5+UppVu6MHKiP/Kq6jwPAcgVGYBf1+w2n
cKtNv4/xKTEDBwcaZQ2I5VyCsoA4dLGj+q2ZvAvdtjI7xYziBrwRzQSYhZYtMeaK
mSEmRzoZuOjcfajc1Gi4r920wTMcRgSnuLodSVQGxThjnDD7pPZSeP/PiXc+Q7pG
C3z656rLQjarmY1iua5rt57KAwkr4kC0iuoHnGJuj2jcxOINB870xeTmjP15jzKB
KjhvHs/g9wItAZcDYVaeQlN1sWv7doDJNp7U4b8xqB9ZIk29RcHYfdaSlTbxtVuW
CVbxn10yKOVPws4Aq/M7vai+p8nxcSA4MdK6obo8lvcLf3h0s+BFhRkDQ0CEmfIr
bolWFbEuM9bXdBRTMeA1FjyuThd6KZIokWYXTHif5SMV8hrTwf4=
=VEtD
-----END PGP SIGNATURE-----

--d7jdk6oml7vjgb7j--
