Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF583B0AEA;
	Mon, 27 Jul 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166618; cv=none; b=BBvOAgnQ3YEA5DNIaHZ0xJtxzQS7V6qklFrrJ/KIePcDVgUriNpSx7tMmzjDn+jfu1/mDDOAt0Wlvp1pbYcm3YHM2ML17IN/7a7OOloPxGeJgxkPLLEqSfLx22mCHiQoatTN4ZapawZrQX8U9NH+SJ2fF9qN4rbTSSTl2VNB+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166618; c=relaxed/simple;
	bh=rLZwPd0ARbhiS/nAOPjci7zoXQUZB1m6sKuexPqk80M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVQ4fBM9drZvOMrRArd10bkDnFGU8Ol3nsF3pFheqHkOeQJX5pnlMSWsC/GBgn+n9PYsMX13Pj5lJpHn6vDpuEWrRkngL9St0UVitKgqVt/kK9Jup2CB7OEfpDqQ/yrek8qRqY4iIfl36gpT0JjIOLpxUqjnb2K9Z1kWyb7zS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsOWJdfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsOWJdfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468F71F000E9;
	Mon, 27 Jul 2026 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166610;
	bh=O2DP9sd+V3gapp2vPDfzOknQfw1soNffgDYWsjI+4Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XsOWJdfedVUvAlAsTjIsfwaiMzFbrquKnAstZhHi4+vXSekL2D60TGJVuQQAU4S9H
	 jNtGSxefNhWWdWWEPLViTwIZZ+UqrI2C2awIK3R5gajgvVMB7XLZauHrpepXb02OQg
	 5r0l5GJw/+iuhe/NGsTpdn5373eTYRXa0QolApGMsCoXIFWjxG6p0wbjO7r2ytLSS7
	 2Qrn6T/33aWyRhftWLXomiGcNvkh7Kz4pE8cnzaPkuUyCOVkSyCfIT0klJs7l1KKSg
	 nRxeDYGGkqfcDWVGxgj+N8UXZB56saDnFi0A56YdfJwsZMat9ybWEkgUWwHqDc2So0
	 E0N7FsMYg43uA==
Date: Mon, 27 Jul 2026 17:36:48 +0200
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
Subject: Re: [PATCH v2 4/7] clk: rockchip: clean-up simple provider misuse of
 the consumer API
Message-ID: <amd7CasCCYOoyXhf@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-4-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbtxxe6iq2gig57t"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-4-56f306156d25@baylibre.com>


--xbtxxe6iq2gig57t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] clk: rockchip: clean-up simple provider misuse of
 the consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:55AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/rockchip/clk-pll.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--xbtxxe6iq2gig57t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnexAACgkQ3SOs138+
s6HjrBAAqVx4wDajmCyTkTuu6eCSuKR8bW8dpLrULaaLS4gwAjsVCLv/lzY7LpDg
+d7MXmAEth+FTysFv2BJIbi8843APxU+e230/GErUGMV7l42ITOIepPHVDoFRdl4
lP2vp96vn9eXV/tUSBVWoiyaqpk/TDbaPT5GtGsGU3TrtrmTFA1uC16YmAikOOV6
EbexV8rKrsf+90wnf2ScvcZN25SrkjdHZPPiYm8ha+25tubNWQooRKGMaUF8wppr
XQSHImaQ4Z0uDPqkZsn0DUJZcSQOHPMEmXgzfdZ/FyGueKY4028P2rsYU3xax4hZ
qCxTSXsfkkUUm9jZOtuGLhgUPdVZ7Gc5G9x8VtSToJaBR0yA9Ko1L7pbPIKWoVFz
FlivG9Fx1tetf3wKKbSqPtR1ncFtJeg3UENYFlawkgdONOYTbyjH/oZ9U7fWny9p
UskCye1oz98QG0n7bpXlEQRs/GvdNZbgkgp50MENqjKDuSDn2LugNesoBSygozIU
ewfAbShTn/10piWzHhHvekgPKhwQ7Utxu9E1P8FOovFB9k0S2R3uIUHSL+MldaJt
p7pjYEC2RjPPvk7RpvVhCtsyr8Pihnx7Oh6wtaBOFf3tESxZSBgFfX/JOgD4w6IO
mNYMw4Nt5ICFcm/aSDngscGzgFSO1mi7QQIUZWFDFMQQSbgjYg8=
=q9vv
-----END PGP SIGNATURE-----

--xbtxxe6iq2gig57t--
