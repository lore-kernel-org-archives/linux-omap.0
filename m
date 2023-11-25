Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D0D530;
	Sat, 25 Nov 2023 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA2oAxev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94713C433C9;
	Sat, 25 Nov 2023 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700912764;
	bh=oR2hnb3Bl7ZQBHF7pVNVNr9cSvQhx/EmQ5RXPSn1AV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iA2oAxevVVzBwx3RZB+eHCPV6AU3wc0KpHP+/3ea1rvlMCmh5nZJYmi/iwitnbUFp
	 is/DUnoUG8ps3ZSmb6wIZAzh+JRKRIkNQ9HY5+C1r8llcK/zy14F/PrIwKqX8Cb3Pl
	 MufYaPC7v77pkDRMQM/CckTjVMdzHJiC219nJHk5UITsHjGo2JO96rTXD25sgR5Iz9
	 +IdE26URAC05uOcIr49cGi+M0oXBgbkmOrr2yiFU5Waqyx5vvV7cT0tkX3xHUxSE9L
	 c4AZ2tMdDBOV6IyEJK8w5bTg5yNlfbYQwQPqFlPkfiXR+7gtFqlSv/v7DILCokC1vL
	 6VnIzvTdWwh0g==
Date: Sat, 25 Nov 2023 11:46:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: mfd: ti,twl: Document
 system-power-controller
Message-ID: <20231125-ramrod-turbine-084ac36a7916@spud>
References: <20231125092938.16535-1-andreas@kemnade.info>
 <20231125092938.16535-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BHb+UNfFvgB7JgAZ"
Content-Disposition: inline
In-Reply-To: <20231125092938.16535-2-andreas@kemnade.info>


--BHb+UNfFvgB7JgAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 10:29:33AM +0100, Andreas Kemnade wrote:
> Add system-power-controller property because these chips
> can power off the device.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BHb+UNfFvgB7JgAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWHeeAAKCRB4tDGHoIJi
0u0cAQC7MOQrodkISngJv/6KoriZmS4apiDChQBzyageiRRAAAD8DrOxoF3Qllj8
+Dd0oMKVoims9s51dkpBqxbXE/1UpQQ=
=AWYU
-----END PGP SIGNATURE-----

--BHb+UNfFvgB7JgAZ--
