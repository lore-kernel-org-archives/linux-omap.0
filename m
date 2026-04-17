Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C062857CC;
	Fri, 17 Apr 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442161; cv=none; b=NLiW8UbtFrkYxFUIJ6MIiAnQP3Ma8bqqIGmy5PwTQ4yZIESwOYH2hKQoFDHyW3qIJIGTMTz9Ved3i7kVN2BZzOh0A/UInTKmERFvkfZ9hrI3xNKeRizRYcJoJy83uGxU7ew3HKkMX/96/DKxPQ7VlTJYGKm4D22rNN8ahm1XIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442161; c=relaxed/simple;
	bh=MFHe/JodABoKXerKi3atV7xZGaeASc16N8fsC8Nf3QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCnXrlNVxvMdS8zWzARAvXWlQEf4bLEi8z1NsreRtXNT+A+o4v5KNv7AFbEUYww2cYdcKrkb6ifOSorvxjtbPhs4YmlAN4Tns7vKdRENIdazAZzZEaltEuioQCuOakCBB4gLDaOuZrl0p8lVXaSBfr99MJGGubXUhJOxkhln9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfGr/WSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfGr/WSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0146C19425;
	Fri, 17 Apr 2026 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442161;
	bh=MFHe/JodABoKXerKi3atV7xZGaeASc16N8fsC8Nf3QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfGr/WSpV76MKFAJdAlX8fWJ6OXLwxRuUDkaAyDOY0S+TPFyyxaHPV+rUxyH+sWky
	 m/g/bk6uXffxV6m8fMvmPHxM6gkiDXOm+NazvVXMvyJOsc4ftX7/ofZy4qdGWTggA8
	 lYYpfhX7blhzkPeuHg9YeZwz+oCsEQIRFNHca1ZAdRzBbalMTlPGdHb6VATDRSeTIh
	 +zfZQO+FH23fRXbH+fuBT+n0rcTNIY96Apxpn7jUmqtdbN7/rb5czLli6oNqgJ6xgr
	 Jjhis9/jHYZlFECOg3L4unzPG7z4i5P/D0nTZXIOZ2uY+6/LBvGOhkM/oAR8rmGp9F
	 4iwPeGhPAW5ew==
Date: Fri, 17 Apr 2026 17:09:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: reserved-memory: Change maintainer
 for BPMP SHMEM
Message-ID: <20260417-molecule-pending-b6a181b49abd@spud>
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
 <20260417131549.3154534-3-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nuU7S7AzXyEfyP0v"
Content-Disposition: inline
In-Reply-To: <20260417131549.3154534-3-thierry.reding@kernel.org>


--nuU7S7AzXyEfyP0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 03:15:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Peter sadly passed away a while ago, so change the maintainers for BPMP
> SHMEM to Jon and myself.
>=20
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--nuU7S7AzXyEfyP0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJbLQAKCRB4tDGHoIJi
0sjcAQDBUAS4q8bdLt4473Lh07kzn84oMHmG+AK7zOJ4U5NsFwD/aO7wDYB3REwc
/p7ATF7mluF/bwqsdq3R/8rZL/p42AU=
=1eL7
-----END PGP SIGNATURE-----

--nuU7S7AzXyEfyP0v--
