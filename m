Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879E3B42F2;
	Mon, 27 Jul 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166670; cv=none; b=BpsL4bj75Tzmla1bDZqzlxXoeASP4RMcFxBHqqcheUB81uBQ/MARCslkvLLcKVMG7tt7cE6B4jnNZzUbmjQt/vgZFVeGLBsZU1p7O7ub25Z0h0h4gIPi5gXSK/zjmxyi0O7bt+qlCff7sje9ov+89eK0oL6IuvD9FSzOr5+NtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166670; c=relaxed/simple;
	bh=U+K+QBoJG1tkDRzYVat5ZsuL3ijuTdSs3L+u19TUi+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb2ILwB2zrQw461cLGtD5o0Y631PbQIwy1C6Cfs+IUD5ueo1Gae5+/H4jxiP5wKiZj/kNDqf9+LYSvUBg1MKV1pBBnbCcggmC8TMnRcMfEdAchSVWvn5apeDLwVk/d/FtHZVPHuGXFupTG4UbtLpbhV2/S+9PB53foTKw1JkLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haCgqshV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haCgqshV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773A11F000E9;
	Mon, 27 Jul 2026 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166669;
	bh=R1J/RESx0avW+Fd/6bVNs8OltfDhTdNo7aLUSFszu68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haCgqshVbgUxU1ZFuCRavAnmnbOcSUp/gP+r3uOztDMXsFX7RWjVGyZ9XIaFPz6QR
	 gvVNYalcT8mf4dmo4Jwoiaun6tXYQQ+l/qbg84khZ+KXP2GqU5l/PB4TeBg3+G2G3+
	 wnm1jkkC/iO/LpM7E/+a3f2Up23ewmM86r7sl54PI1YUBFnPKXj8m4PKUU2ayKq9C/
	 q1WSeRfCuB3F8xUmaW3wNbjUj5Ivkq2iLU+JG4rQwpus3R5S7q54uIbBB1KkxcaoeV
	 7pMpiIQR2Gtar58vxRL4XC/OuVgBtaCoWaInz4huvaW380WLfCICQRkWgFYndg3YBp
	 hOTPMEkHFWINQ==
Date: Mon, 27 Jul 2026 17:37:46 +0200
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
Subject: Re: [PATCH v2 6/7] clk: tegra: clean-up simple provider misuse of
 the consumer API
Message-ID: <amd7QR0IGwYXwuN6@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-6-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpcm6taaw3amtboj"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-6-56f306156d25@baylibre.com>


--lpcm6taaw3amtboj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/7] clk: tegra: clean-up simple provider misuse of
 the consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:57AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--lpcm6taaw3amtboj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpne0oACgkQ3SOs138+
s6Hdng/+MMPWOkElyufdJQ/sD2uXGLUU0LCHitJ49eyaTRGzy+NEXHeVGJYyJUYb
fdCKCwV4OhqpdvA5Oy1jUyNkdPmuNQE2o+v8mCH8waFwhBJCDwI9/t7u22GjMZX7
11EWqVlA3sU6oSaUzjada2rm8lagt8gft5MSiMSggs9XfvCjZxkDoqsURqOHxzzD
zyHODFRd3k4ZBqx6Qnco1QUjE+KYCwXt2Fq6LdwdISgpAcAKp0nfP4nUhKgIhBB1
hCrYstVYtqFWMt5wABAu79HXvsLia73SoJzl1FlS5rJj4K47Wgtxl/C5Pt4K/mTd
iAWKSO1VFC+7w5R8eCgzIjsl+WbbSSbWN+PsTn6aVTObZkv/6UCOPM5LcJPgQgDA
qJ4jrmRknp6KGf1aW4O1ZPCm+HMW72o9Q8lC/9zePOenO7OxKsZ7mmE6uHxCw/dK
FFmR/ptCtXPCLb8HXW0XlzS2sQCKsuHg2enmKdI/w9+iea58I2XxtQGMjfkOx6Vd
FiCkJSSlwhWNj3/7Zlu814b04umPJr4VrvucaKODusIKPezBZEZowVNz+gXqHp2v
8/GPPH1YFFLixOOMyxL7ilSipgTV1MPIx7j4anAPY3Opz64jnyncvOFGUl+kcSeA
+7twxZLAPEBAJBNdjvmav0utaqIwiE4zzzmTcjWzlN2CpKRWe0w=
=aWGl
-----END PGP SIGNATURE-----

--lpcm6taaw3amtboj--
