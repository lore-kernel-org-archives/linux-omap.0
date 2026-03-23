Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A693C8715;
	Mon, 23 Mar 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286985; cv=none; b=Q/e6vgymhJiHz/Cb6xk9aIdRLNfaiR86Iuq0oMRrzgnOq+apPG7GMYKl7xlL8nbwHIgOEAXuwVlP7TTGbsTqyexPQEgF4w2VTclnQL7KhiphHiBxMX9BRN0//VSTtDAturVD4cMQws5PDpFfuq9OQF21RgS/cZAGm4tg9PMJiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286985; c=relaxed/simple;
	bh=4ipWah4l1L4H99Gg1W2ON7iUdL7OjwQmg/qTlb4tpvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkquABCU3gKZzJuYwrSLNnwSXu6jL7+CeeLp8tv1B0T+BoEGKBzSB7AJSM44DVCbuldFdCoMxCbBzA5W3Q91r+uiN0Q21dr56u26HnRnuMw9UhpbisWG2sWrCqagY+RF+oBNJX2XKVrSxbb6nlmywIKtq2s5uYnLoeR2+nLhjvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPX3R5qo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPX3R5qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ED1C2BC9E;
	Mon, 23 Mar 2026 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286984;
	bh=4ipWah4l1L4H99Gg1W2ON7iUdL7OjwQmg/qTlb4tpvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPX3R5qo9XNPyW6KNDPO4r9cyh6vcbUGD69Agb5uSXgrUbXS5nOLa7UfTNGPImeDP
	 xN3qZ7nDDIdB6nh1IpFnwQ4ZB1pM86S4SC8wSHH4/48cISJtJ+sGelT0Esm3iSa35j
	 FDos5s5KAH97nwQpPGJjvjiCypDBupVMVQhI0dgIyU4l5by5cL2OhTRwOE5xXJxNzD
	 Z3WTTYvzeDXAmVWwKSHfSO5WDCMvlzjUzXtl/Km+KA/s5BYSnszcP7H65cuM4aH+pq
	 +rH4g0FBmJiB7sD8fi4m5tP+jpe3yISCkaQAj5ppNSUpjpFEcZ1ewX5rKjYQRj9juN
	 YO/hzbMd6+aQg==
Date: Mon, 23 Mar 2026 17:29:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] regulator: pbias: Add pbias SIM regulator for OMAP4
Message-ID: <9d5a922b-3d38-45bf-bee0-50673a250489@sirena.org.uk>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
 <20260323-omap4-fix-usb-support-v1-1-b668132124ac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kx6/S7Rx19hzc491"
Content-Disposition: inline
In-Reply-To: <20260323-omap4-fix-usb-support-v1-1-b668132124ac@bootlin.com>
X-Cookie: This is a good time to punt work.


--Kx6/S7Rx19hzc491
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 04:02:42PM +0100, Thomas Richard wrote:
> Add support for the pbias SIM regulator found on OMAP4 (for USB I/O cell).

> @@ -108,6 +118,7 @@ static struct of_regulator_match pbias_matches[] = {
>  	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
>  	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
>  	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
> +	{ .name = "pbias_sim_omap4", .driver_data = (void *)&pbias_sim_omap4},
>  };

This is a new compatible, it needs bindings adding.

--Kx6/S7Rx19hzc491
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBeIIACgkQJNaLcl1U
h9BWAgf/Z+R7Meg189FFhgG54AxsMEXHl7o6PnVqNsVJHYOUvyvIPZx20QyCvjPi
0qcsl95vNpCQR4w6jIqwhx6lFVdAA4pLHM3gYOkqZgutwVUNvDU753cBXBlhAIBt
5W1R6KdBwqAq85yYT25nYdMBh4GZvsYRdTZ0UvzeDOexp/eJqg5l4/KL6axX+1eI
4MbX4skaMTo5JbizI/esA484T9oCGY/DJEpRWJ/pshKWzKU7ZWXrrsPfPUuu8euK
thjxWKBDbhC7b5wkbu0kYaHHXZBQGJwF86UJprSHDf3tEYlPli7f3j/m/4weyuBL
a4eZqz2JBVAeG/oPBIvoUgvlqtx5PA==
=RUMF
-----END PGP SIGNATURE-----

--Kx6/S7Rx19hzc491--
