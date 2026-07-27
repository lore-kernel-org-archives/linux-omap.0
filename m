Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C300391E5C;
	Mon, 27 Jul 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166537; cv=none; b=iKfMO0BrIOiHkyXLBkpFJ7GSEpQMQjXwlEalH8n7PHGaegzw/z8IyMYIXHxdy9N8HwFjhTjLn6kIvkTis/kkylb4RH9m4Nc7jYFr7CxJl3o9ITHLMPLUDffeqkiK6JTugkAOx0ZiW8VyYKTnaLEYcBn+XfimVPle0SVuo2vgD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166537; c=relaxed/simple;
	bh=9heVrqxfqGplyLky9CvhBHYemf/wCYw0kxCA06R//Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMZoz66M1cw4NhS9rvNFOiIfWc/BHl8FUtF+to1VfZMD+SaGym0bBuTuWy4tATRjjvy/vYbgBsv1w0oz+I/vSwLk0TqRbri5D+KINVFUZW1rjWNb9rqUVEH1mfENESDNUlXs49TFcGXvuLXCIXyNi0pHVqa84Oo0KkwtfOgdAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPGyshAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPGyshAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53C21F000E9;
	Mon, 27 Jul 2026 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166536;
	bh=6pimLA8PXpe/KB2O0/HbQ+QwyvJSF7KITGTCYTL5PK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPGyshABvDxW3Ih+0CYOdp7ZetMFxAj2p4xEAoU4nrm+vWZ44ccOoqz64YO5hUEEG
	 QvHaF3VO65kWPjOh2uqE1OaZIMSaFqAu3K9HnsjbqXYyuqX5n8xaapj4qeHA/5wr+4
	 92YRfeMwxNcWOCMZr921uKVmanLykM2B8wSC+vT45+s6HjCs+MOT/P4ytTm/yhm1nB
	 mBYgbIvIorqVh8Iqh/Z60kRsAA4NObO39857pZVg5SmgqnrOHER9MrVKuDU2FJuO3Y
	 3rt3l1Z/Hni31UcWyk/3RJbV88Q9trPXsexJgI2uyXEDHzVwhEul1+RiSgFf6KyOEI
	 R4zKa6Bw3KdsQ==
Date: Mon, 27 Jul 2026 17:35:33 +0200
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
Subject: Re: [PATCH v2 2/7] clk: qcom: clean-up simple provider misuse of the
 consumer API
Message-ID: <amd6vhL9bX0YmjE3@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-2-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zq5ldklgurjwxspu"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-2-56f306156d25@baylibre.com>


--zq5ldklgurjwxspu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] clk: qcom: clean-up simple provider misuse of the
 consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:53AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/qcom/clk-hfpll.c | 4 ++--
>  drivers/clk/qcom/clk-krait.c | 2 +-
>  drivers/clk/qcom/clk-rcg.c   | 4 ++--
>  drivers/clk/qcom/clk-rcg2.c  | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--zq5ldklgurjwxspu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnesUACgkQ3SOs138+
s6EEqxAAlCFaxoVTCA1CfgRp8dzwZafYmIYgEsE0ClMOdVhcykkwkw+zzREQzNWw
zrNc8zItDXLD59chu4jB1t5x3EUCI0fm0ykDZzAvFdWGIam/VRhf+5fFE0LlKMLC
b3C/IFiDNgi4b+iSQYBVAxsPIxXXTiCtua/+8Hfkc049kvL5g+q0Z+snYb6nWRvt
+It5/oxa3V/Gbb02LDDOyoJudwBB2AuMyBWQIgpLly214d7YySjLH75z5RIjzklN
XeD+uB6bfmKllsYQzn8Gg3IXQS0JDQMaAUGWMQV828p5fiDPRZFo/fHXN+2wkLk9
wDdJTU4u6WcZ7s//S/KMekniPws8XtvC2Qf/X0JC5WeZbKW5cPn5KGIZfEjaZfGv
MVVB7C6coPw4pK8S4enaKy+iEvCsbWSTqa9D1Zlj5yo+7X0gghxJ02FFeahPb2pH
QS6xzkZZkIWaihgjvJ93QmV01HmV8YIY5c2gPayBfjHacGtT+VeY4CqQrhpH8q3Q
wR2akmStfmHdp4RUHXCUKHwG3hVi0BOJtFxYjl2yTQPPesgNk7MP8tmObDyK0wRD
3ObUnCOiWqqQV8JbpMo3d9cbrdcnN0S5fTEb7ETSaVVTzwn4YXQpjSPWeiGLQKVE
RxiLGS6vCX5VSLCFMhFxQwB2bcol+N4e+sibrz68qhc99kNk1aU=
=kezw
-----END PGP SIGNATURE-----

--zq5ldklgurjwxspu--
