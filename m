Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FA379C50;
	Wed,  2 Sep 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372319; cv=none; b=qoxZailmDusT4qip4Dq7mESRpN6MjFOxace4TXn0HJw8okx3hxe4J4mR7eNE/JoG3XXDVMYJUc+AK83io+6itkzGnafK7dlS3eu4AS6hNUlKk8GpqpmY8VWwAzD+xHNRdt9fk6hOHzbg4OK4+5dT5QAkn9aR6wK0BIwg9NHK8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372319; c=relaxed/simple;
	bh=EAOjOysK/UQQZ30yx7T4qd9/B1FDX3DQKZPXpSGNptc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISRfD5a5X7rhjIWswKEpKZgQUPOTbCEdC2gVkxwPEWjfGG9LMI2gtbOMZZeNjQOy3QRvs292HVTfE3+kqM/PPiOq2svOmqWOGZ8tRTXzGIldmXOuXXV3OsBMFiWRsBNuHT/rCubqbh+6Z5Ovj0PNp5HxQhSOybmUSR4ImjSA7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz3cATyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz3cATyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF11F000E9;
	Wed,  2 Sep 2026 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372318;
	bh=15xEXXnKLnd+5L/7sd8a1FeoESz8v7sAYVIIPTRm6pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fz3cATyHIaYRCYqeyKBmFaQsqEX1IfxIHqQwjx3p+kT7nUYmlVUNjmeoGfGQ5rvdU
	 cIkg4bls3ZqFOBssoK/Ivi3xJMSUFQcNtle0tn7FtV6oQjZSsDyZUaIZENcziTsn6U
	 fK1YrkOYyrynptnlcXEfVkeN1CB/dLT+JTeC9t+Dv+LoIfSqJvL7KDROQ4cXBJZC4G
	 an8fzJ7QSTpfemf2XeogRpffdev33qvlJ4wM2VaoFSMxGyL9Rxe0lBwn4ONzvLZfsv
	 ENUTcP/R0uOdYAxu3tHsiXdWT9nS41eCmixxzY2aPgL6/lSAhft8nWjWT++Lvyzcjl
	 mwvigmihKRySg==
Date: Wed, 2 Sep 2026 19:05:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH 1/3] dt-bindings: omap: Add BeagleBone Black RevD
Message-ID: <20260902-destiny-explore-06e02a05ba6c@spud>
References: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
 <20260901-v7-3-rc1-beaglebone-black-revd-v1-1-f521950b777a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6EdmUdAQpYbrmyO"
Content-Disposition: inline
In-Reply-To: <20260901-v7-3-rc1-beaglebone-black-revd-v1-1-f521950b777a@gmail.com>

--n6EdmUdAQpYbrmyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 04:42:21PM -0500, Robert Nelson wrote:
> Document the beagle,am335x-bone-black-revd compatible string in the
> appropriate place within the omap family binding file.
>=20
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/arm/ti/omap.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documen=
tation/devicetree/bindings/arm/ti/omap.yaml
> index f694dcbf2348..9666c455628d 100644
> --- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
> @@ -104,6 +104,7 @@ properties:
>        - description: TI AM33 based platform
>          items:
>            - enum:
> +              - beagle,am335x-bone-black-revd
>                - compulab,cm-t335
>                - moxa,uc-8100-me-t
>                - novatech,am335x-lxm
>=20
> --=20
> 2.55.0
>=20

--n6EdmUdAQpYbrmyO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaphlWQAKCRB4tDGHoIJi
0iK3AQDE+1/FhU9jm0CykKSfdCf60QxVtuIepMirjQpUV8B4HAEAw5Pml4EtfVcX
v/RJ2t91P4lFWfi9nEPW5eNPksQldws=
=YF4w
-----END PGP SIGNATURE-----

--n6EdmUdAQpYbrmyO--
