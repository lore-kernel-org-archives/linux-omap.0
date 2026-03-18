Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B663311957;
	Wed, 18 Mar 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855684; cv=none; b=lx77/5xypplCOOUxcQcQsktKdYF6OpR1d4ZWpzMRpulnwodXjlou2NoMT9JpNJr1SgwYDhOskoOUj1Ywl5VvnFHlqRSOgtDqYeCys5YgT3zpEqwFgMPJDlcVgjwshMzCP/nszIuDxwf5uAyPxlMBp3iHXlAfQsgfMRdeTypvt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855684; c=relaxed/simple;
	bh=3QDH4R3nfRKdMFJjHi06AU8WEhEV1jJ7Mgy1H4j1d1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxtniRVEL06z4vjq4OVS8euhfeC6TKT+mdTOmmQHPUP4N4WrwO4o+MypEOXSs0n5lFrpH15vHiWvh+vTlMX5s+ryMQIxwQnCUH87kDTxs4G4bKh3lS6VCUmoxXC7eJfdomkkPWlW9yax34ry6xFWb0NqDLhlP6CCfTZlgze+4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQSCXQHr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQSCXQHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D777C19421;
	Wed, 18 Mar 2026 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773855683;
	bh=3QDH4R3nfRKdMFJjHi06AU8WEhEV1jJ7Mgy1H4j1d1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQSCXQHruoJjSSi9d+5+zF2y2h1TXlaAFx04lsnfZPLYqTXBJJQ5BJ4nN78Tb4Trb
	 IYf8tkyVEuD5GM8u9ItcBL23ldDK2lKDKbvKwMC44yTfc8lyYmr6ekT/jwGG8DNR81
	 2OxvFUXeupT2ya8vf5jgIwXfC2UUcnFOYlYaYNj3i7tPWQ74mRIGsWcrjv8tRbC3jk
	 1xNIWPajiieNCKkiko/TZ2TEQPZoNE0ajXKHtSlfGQh7uPoye0VgB6pf5jIt7rId4O
	 eG972UmfjVfScqbgv+ZGdEPj7NUVY8kZa3So4PzVMEpkIGi/kuvoSK2prykmmwkeIm
	 A70XNskj9Gnog==
Date: Wed, 18 Mar 2026 17:41:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
	Lars Alex Pedersen <lapeddk@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Roger Quadros <rogerq@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/2] ARM: dts: ti/omap: am335x: add kamstrup emperor
 platform
Message-ID: <20260318-broadband-defiling-11dffbb8f230@spud>
References: <20260318085420.7680-1-bruno.thomsen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvD6luRSOfpvWahA"
Content-Disposition: inline
In-Reply-To: <20260318085420.7680-1-bruno.thomsen@gmail.com>


--nvD6luRSOfpvWahA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 09:54:19AM +0100, Bruno Thomsen wrote:
> Device tree can be used on the following 3 products:
> - Kamstrup READy Concentrator 1M (RC1M)
> - Kamstrup READy Concentrator 2M (RC2M)
> - Kamstrup READy Concentrator 2C (RC2C)
>=20
> Concentrators are used as 868MHz gateway for heat, cooling and water
> meters using wM-Bus, Kamstrup LinkIQ or OMS LPWAN communication protocols.
>=20
> RC1M only support one way communication (Rx only) where RC2M and RC2C
> support full two way communication (Rx/Tx) with meters.
>=20
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Co-developed-by: Lars Alex Pedersen <lapeddk@gmail.com>
> Signed-off-by: Lars Alex Pedersen <lapeddk@gmail.com>

Patch order is wrong here btw, binding before user please.


--nvD6luRSOfpvWahA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabrjvwAKCRB4tDGHoIJi
0gCYAQCgqKNjPUznw3qzdSOz55cc2BUiTId3HsDYngSIS0UangEAumTXmXcTkQaS
BFrxvbtMGuGYmJccCxnPENe1cRmgdQE=
=yxxN
-----END PGP SIGNATURE-----

--nvD6luRSOfpvWahA--
