Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1A399CE9;
	Mon, 27 Jul 2026 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166685; cv=none; b=QYYGqyatrFlREMIli8xiJ3r8Y/QpCevWr0L7BwT3b/UVr5bS/N6hZmim2lDfXsqonzgOYT43/09WmFVffTXfkXOj+gOVXhrZWoNSKUW1F1wJWjozsLfCEOq/yuPyE2bM02BI1iNSD3fcpeFKujDR5pYxjef3WfJNyJ5TMA0PDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166685; c=relaxed/simple;
	bh=G19kZVUlGvrTNttN34nSRYfBH53XVBtwictsbszBFM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXuKPMEHLZ2BZo0h6WYaKBfcO+ZHomaZAR8eyu85aLrjwsc2WVRkOYkrEZnQUzCsNrGGI2CDcS/sZJ7kn9d7US+4ejXiV12LprR+0INRLBQT3hRTsW4iXHiT+w9p33r2EtJusRE+6Mn6VdbMowtnInmZsITbbESuT3BJL73Opps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPDR7GRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPDR7GRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D41F000E9;
	Mon, 27 Jul 2026 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166683;
	bh=dZTU8f78XKfrQAJqzTXDY/jHOk9+LGMfSKNZj6xU1i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPDR7GRno/9OYTullUViMPOPShdS+gQiJ27iPNLgSsqiRhya/kaL/XuEy/RVidn58
	 +ffRb9s3m8xCGe+KSlFYxNyYmvLAgt5A7B46xQ3mQ9mstv1Zo5SVZjnSUG1astFr1l
	 nHZpfJBlDolUyCIkksDzN5ztHY5bXDO4U6H4a80JVsBTmX5pk3b8wfRO+fo6sKjA1d
	 YurgbkzzIG9W2JO/HROKnvaZ9wTsC4ZQ+jsd41ChtvlYPk5X+7raC9HgXrdnEyYEMw
	 c6564zCvw9FWYCy/LVNIzxp9T2OTtA7zjHduub+x9sXqwsL6zmeijUCmtnW1yKQ/Ep
	 I4duo/f5qBL8A==
Date: Mon, 27 Jul 2026 17:38:01 +0200
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
Subject: Re: [PATCH v2 7/7] clk: ti: clean-up simple provider misuse of the
 consumer API
Message-ID: <amd7U863RajvO4U6@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-7-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3reqvjdwort4ovfu"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-7-56f306156d25@baylibre.com>


--3reqvjdwort4ovfu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/7] clk: ti: clean-up simple provider misuse of the
 consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:58AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/ti/clockdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--3reqvjdwort4ovfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpne1kACgkQ3SOs138+
s6FOnRAAwacIQTHIdHeEEUATDJCerZeNvvPBnOLDDipxB7UftE/n0cclBK0p7nnW
71cEMyZzL7zva3Tu7J+G7m/Qv79N0NtzjoEOqY3Sbz/DyyCIvD44eJUU9lOfl5Vy
BFemJIHSFTfWtNIegSN4gbSmMY/zhJBVSF4WOdTcx3qjg4Q6Gtsxy54yKSMreAL1
xU0ty4QhONCOUvnq0BpZojJeHfNd+Y2Ldh6CsO6I9xD+njbEAPkCthXeNszUkRdq
FGgk6Vb+VybZMP+Tk/ynhV2AvlBNDcpjiWWztz53GHwba69t1Uhf3ClnW4NqRlt3
nAWKL0CoDSSYrmXg6R448ULsKG9C2ih5QkQOa7bF5ZIFqne4GoCnYoEv0Nf8s43H
Bzlk9PW+qVC1uvZlPX0iQBvo+k4J9esar8UGMDTN8CmN2kFJFO2Ea3VlE/EmQkla
rF/ucopeezhMRlPJpjpgN7ySxWkwiUgtsj1jVu43laahJBvw9kICApaAJkmpeUy7
AfG3HJRjtiutI1OMOdxbgDexQ8bVu4FeI/ApVvBZ0IOqHg0MyuCBu5P5++4b3H42
qPey3bLg0lHX3Kf0W4iSxrcxFepjpRNY20Jt3AO2JV3InzUt3Vl5f6J80Jse8YFu
a9NkjxEQX0kRR68CSiSHn2Ii7wUO9K3/kFhd5fcrsfyBDlNtBCc=
=tCp7
-----END PGP SIGNATURE-----

--3reqvjdwort4ovfu--
