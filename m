Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436563B0AC8;
	Mon, 27 Jul 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166497; cv=none; b=APqnKGlwscdH4iZMOl1jE1UstPYJKm29GXp1E+SjH6b2WgzKe+PK3u9NF84923HgxgrqVKy49qVOUQU6h8dtiIeihDUCTKysH69elgRSfWEaL0YrFAaIkh1ZIgWpSTZBCpTF3g0a/iLGkSMbMyW1WukTHSyutjQBS0DLSDduBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166497; c=relaxed/simple;
	bh=fdHzhx98F8QAqNbJOftJK94xoGSYtyz/Fx68+3/0nuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrw3a3zJcccp5JvgnIC3OHzB/b9E5u7wW8787P9bDYX/vvM2p0gfRBSuELtFBasWKx3VmjgPezW47k9eELTRRsvotTdCkAcuEQQaJy1IiGPGQEGPDKJGKmfM49kc+FnntDc6oVEEWD0Xuiiq7+IpypG+tTlrrtjpY1UFYfI0/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/huRj+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/huRj+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A101F000E9;
	Mon, 27 Jul 2026 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166495;
	bh=OSE8IoasrD58unzxSgBtl5+T5ruydJA2kXXGe4djiMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H/huRj+FkZT8rxFDSm2hICMewRtrDeCyVfV74XdKso+0RoccHn2jC5Mgzz3404BZL
	 4rBoIWZ92IlWdwpSV4/xTuLCcx55APa3ZaQ7tx6veMsqKxODNwZLwYtfRsq/QZxKWg
	 ivcvEse9xj/uKusBGiIvnUAidQrYBrfXv5qyi14PubnBkkhkPZchGK/8KAHmT2CX0R
	 MjZnwgdsVvEI5LxQ3bGb6iGdvS6kK8Vdm5/KZFJ8Jlsm3+0hHixn8vncVvUbpDNR4j
	 GCTq+lnN0eoFPD+JcKEPwNyymg1LkELLWJlFPPLTMqtkl35+Di1c+2k4ulBPXcMlI5
	 /A6pMq8nXNOgQ==
Date: Mon, 27 Jul 2026 17:34:52 +0200
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
Subject: Re: [PATCH v2 1/7] clk: mvebu: clean-up simple provider misuse of
 the consumer API
Message-ID: <amd6lIpfUb29Gal_@orome>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-1-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2f3tnfstgthwesf2"
Content-Disposition: inline
In-Reply-To: <20260724-clk-provider-simple-clean-v2-1-56f306156d25@baylibre.com>


--2f3tnfstgthwesf2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/7] clk: mvebu: clean-up simple provider misuse of
 the consumer API
MIME-Version: 1.0

On Fri, Jul 24, 2026 at 11:03:52AM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>=20
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/mvebu/clk-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--2f3tnfstgthwesf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnepoACgkQ3SOs138+
s6GLgw/+NQfYR/3Wzn80ngNgyBG/2ubRWiFGqh6kqFPvkRAEs5StLHQNS2eDIqKm
4V74umZnlJA08SglJLRkgRdPWy+4IBuipiGQpD6n+UrmGEUg5DBDlajeQEytQwnu
IUq4BryldySDYFXKTEzzDV5eTxf27wG1sqFMBLL4aqV58o4vSK2q2d8CDZ2CjgXZ
XhD30hil1dvV280lPDjBg3vWiL0SqOSl3NubqUYHvEApRYWSGHVMjwcnJVSkq2Ko
mwNHlMNFVQUCcWLCRLh/qkXe8dKuJex/e6XIBjIhX4tdXdAyvQ+5hRUnmqQPWe7S
xlMnQSbewWsuJxDwEMUmcAAD8mAzNf+t4dFtNfLlvtdVSjpkEyIkfzohLqbnG1s4
JSIPmI03mifLMctCpfQ2qDWitTMns00tAvkK2SzfS9GyeW0W6yVxFCU+2UsTwse7
CZR63ywGOUmQGB1Xw0LZKsp1/6t4ESMq+T6DPc54V3g8K4+JCUnYSKCxqa+Ck3Xx
P/tJNBJjPkqLP6rvag1AZm3z1x5BsI3nWYZ1ZtyGMFRQxIf3RKeuo7taW+R3Bq1n
tRGbbx2QW5AXgjCmjvLNYzFEkvDZIJbWEfPjLORLuVRVle9vnzCE2BpPZT3L55pG
ayihIatqmM9Cba66uZL/tn08KDmubR0X0Fbvs/Orc5WCvlkaug4=
=XS/f
-----END PGP SIGNATURE-----

--2f3tnfstgthwesf2--
