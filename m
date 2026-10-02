Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF9471244;
	Fri,  2 Oct 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932228; cv=none; b=eByyw/4HDRI28BlW4QcW6fHFq/bW5R9bnFjkS4dn5u5C3SY66dcEi8K7m3BvxUl+fNEnIYbILK0crbYw5FRTFZPH97qypUGMiJQBi8uqHrjTw3bJTPsTBXErAJpkG0H2OrWu75VQ1+/V/k1yel/mbIWVOTktXgdTaoPK3JxYqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932228; c=relaxed/simple;
	bh=L7/L46IkndWgDw/qUmcwo+y00G6ia7esizBeW1QpjRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwgOO6NEwADByJnl4OX6vCKROfcycF1ZyRuoCkSDeTkYURaMBZlSVB+rl3yRZIyuEa5b0raBtYcyou5XrzR3iUyLLS0azHH0gMPmFIRRjvyc/KRchDmL24YFE5lzCWQ/GNnBFUcs1F1rlcp3qbpUpZt8i8Lel0otd0D45ZFzEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tac8bcu8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tac8bcu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76591F000FF;
	Fri,  2 Oct 2026 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932225;
	bh=xv3pWyeRRUFoRvp0Ps4itJ1XAqYSWp88xwFqSuNXeiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tac8bcu8UpJqVyV+6QauKiRTO/qPA2SZax/Oq93s1CxGryBRG9pPtFssaJOsPJ5vT
	 /YdEhDRImnbiHcrdTZW0i+TZ+OYGfSVX+VKBUwujc9/2BZdkx6FL5BBgn61eesmBS7
	 VV1ysUOOxaH+rAPCSJozKtBsw84U9yEBxRmGNFcB+7y/Jel13tb+wCalBvzrN1MMNC
	 UBY73LWaWYdtJYK+Mp5fNThuSzWIp3ZlFnm8Bs7itpsSrE9KmAlVzwnIf/t7Mxz8kz
	 4IbaBD6TkCxBoRN/VMOBf4inkNQJuLfX8mE6QZtarUevACoTwkr8Tr/qfj/TvhKzI/
	 HJoPTke3y4i4A==
Date: Fri, 2 Oct 2026 11:10:23 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ARM: fix typos in comments
Message-ID: <ar900Vgb1Uil-A0a@orome>
References: <20260907064849.23086-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5tp3jaaty7hry4a"
Content-Disposition: inline
In-Reply-To: <20260907064849.23086-1-hemanth.selam@gmail.com>


--m5tp3jaaty7hry4a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ARM: fix typos in comments
MIME-Version: 1.0

On Mon, Sep 07, 2026 at 12:18:49PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  arch/arm/mach-imx/suspend-imx6.S           | 2 +-
>  arch/arm/mach-omap2/omap4-common.c         | 2 +-
>  arch/arm/mach-omap2/omap_hwmod.c           | 6 +++---
>  arch/arm/mach-omap2/powerdomains7xx_data.c | 2 +-
>  arch/arm/mach-tegra/pm.c                   | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)

This needs to be split up, otherwise it's very unclear who should pick
this up.

Thierry

--m5tp3jaaty7hry4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq/dP4ACgkQ3SOs138+
s6Gyjg//Snni+P2gN8G0V2Id4wNCmsaFFJIE2m4t6AEeKDISQJSR5XkZ3sSq+kuI
BYKXs4jiZ+4Jrha0HNMPMWtfa94rVv0KtLJ7E99JGP8EcR+Gs0IZ3uCLXa0MbEiG
T4F+o/JpFWOMMZnG3tpkAyBquOY2XAKv+cSOCICe188kO1sVzDer1DJLENkhUkQ7
BG9ZNNnnyiYDrdL6dq2a04pFG6a5TrvGKO9zHv0VT/O2Yambm16Oj5l0Y+M0vtGR
9D7qloVAKwy5GhjMk/IIiQiK5ItfnTYCm/fU0cI8oxCUPV3bQYjTJe4ZjM9jJSS+
z5ETzCZv8Qi7QCCIjQGpvRgSLADOYLEpFDmfHzYEUrKYCvT7EJofZ7vAgnFiAiMN
uIdv35HZ+G8FLViLjVZGL0+I4xQeSYlCsW4N/q6JWr+j2SuDtphUwTcMomOoZvQT
/SXQkh3pUYaEme+YcR3AYnU0lfXx7R4freR4yI1fGRELxlXpIiTOMQ+ASXqfTfKf
1bFn2KTHD21W+DzAJ0f5C7nOg5jxnVEaSzflTVMFJb11RKJbO/qdLa/AVsMU/CsK
26usjIndk1A9GuaKyNbBVvipIxL8J1yljVUq78E4I6MUeahGWnv4lQeMAgRXAwbh
lLKbR5DagwKOUruPvF98fjOr0FcGybMmMEw8bNZCOXuiDngifqM=
=3/Oa
-----END PGP SIGNATURE-----

--m5tp3jaaty7hry4a--
