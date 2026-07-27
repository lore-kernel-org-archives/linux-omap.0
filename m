Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA73B3C0F;
	Mon, 27 Jul 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166653; cv=none; b=MfuJKschddpb5jrGxJogJDhjwut9RZwCJ7zUIoValy5/Q58QKCsz1CFwsE/GGpuCwNV7XbmrCCm5Hyro79/iEoN9hTDQDCMrjQGPLGzEqoE1fJlFy2nbN7/JYndag8xwzDq0Xego1Buhl/5q8W+zsk9nIi30BWEYthHiGB1KlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166653; c=relaxed/simple;
	bh=+6DcaI6fD/4XI7A4bTzf0AZtWYR55ONtSngBB1yeqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqt4XUMXJbVw4Ryk0iI9AERu/pSR74TJR5eDs93F5KbnObhjBdoryT6DY+WFI+Fn2jTa3Qh+F8ADTesnVjk51dBBjTVAjLTWUqqTnOsZcrtoOoF5fq9CTN8QUk/GOx4vP9QneXngj+5ZfCero0dcPZ5WXXlbgGed3VlPLtK5nMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTRduarj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTRduarj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFEB1F000E9;
	Mon, 27 Jul 2026 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166650;
	bh=klO53puD5NrabNv6m54OJeAQmMgu1fEnyntD/bbDp2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QTRduarjBINEjNCTHYzdt+uzf2InnWa+Tvtj6OVfVlItRjitkODqtYLYwm8hVZcP0
	 rBJqwYGZ87Sdfd0PqEqM8qTTLqNP5ipQ9BYi3BqWDrhCFDBHCId0APNjcPmoXjYIY9
	 6OwAi/yl8qAmkJ5GR419G86sTKFJnDC/LmIZjHFzDXe7GN8N4Mbmw+ht2NzM86YnuT
	 +PYV5PzWPmdLLG98bTvXMCMgJFDlDbOM/owQKngIoE6ysunVrwTG6sV9pj29wGGR/K
	 BqO5EFwTaJ2WxhJ4vNZIlyEt5dVWkEgbQnzzKjN4DJR0i8ezLj0kcy0JXuYgSpOfmW
	 nvxKL8YfNWY4A==
Date: Mon, 27 Jul 2026 17:37:28 +0200
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
Subject: Re: [PATCH v2 5/7] clk: st: clean-up simple provider misuse of the
 consumer API
Message-ID: <amd7MPUztiwFv-LC@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-5-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcdjwua2gpwoo5z7"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-5-56f306156d25@baylibre.com>


--pcdjwua2gpwoo5z7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/7] clk: st: clean-up simple provider misuse of the
 consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:56AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/st/clkgen-pll.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--pcdjwua2gpwoo5z7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnezcACgkQ3SOs138+
s6HsZQ/+LvB4jTxDrUCsLxlcfpOR2jSnZ7ksqLoOTN2khBxKv458+/ll4tskMIkb
sqjSbWWmhJUsgxJlcxT0YUYtrzAIYW2vindM+Qpmtbbel/zeSqQqMCAjYS1E/CF4
Cb1bsos8jD5VECJHRmvidSX9NOHxqY2C7YncrVaorAwHRjYDZYvVGS4insZ2ZRuZ
+nDMRwl6T85AAAnws+tTJxqFzA9x2xxs4AuRyT8mdcrbJ3naftwbOhCynbamSmK1
OliDoEHNeX9a+RcySySbTWVE76dGtJ/7oBXt5y8I/DcoAFyO3sKvVaefvJe8QgHO
wsbnrS+azLWghtUj6tYEjI8AxZk7jH81ywzHhzU6Gmzt19qtUSFY4gFUepf1o4Jt
BOdR9UW2WWqrtf+7ol5QMGSIeoWA4mDBo1NQ570UdRDQ3fPN2buc2nwY7AxzEP9O
QOksTDoZ0XcT9LLPHiwZdJk3KwRJRkoyMQfg7h0I7leDQEqyciRRjBCkZVrR8tel
+TRYfhhSjhbz52BIg6+30i8iI1whVsla0IPP9cu3rgkjcSx057RAfDgfZxXMtQl8
XUKiofLK67yQ/JvWrk4YE1PtOJFttjzeLR3nkgNrzhd0TKIYgEyz/5osP8CLrejl
zpwGOyT2m/F0ixCLQxcbPRn98rEXI+vRr1AhPshhdDVI1CrqJkk=
=gZ4y
-----END PGP SIGNATURE-----

--pcdjwua2gpwoo5z7--
