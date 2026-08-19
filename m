Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66E481A9E;
	Wed, 19 Aug 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160120; cv=none; b=JCTBrtxKyUnYJ0Kq6GZG7Et0+JP9ZxLQGmXIE+p/FDVfPRZWY9oRjBhrgCmpG+b3bysGb8IN7zrstpMI2kIoc5QTglhfGykY0jmsIkCI2yjZTBUgUnAaa4QV8p4/6Dfz+3ZEoJ1eDkaAXRyoxnLDpClzTKwNvHbdPXQxl5+Xx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160120; c=relaxed/simple;
	bh=7hRBHDUn1BDaihXaz0zsKwnj1fCJGun3+O7woq2k+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuPptlJKjnOub30Y1LHjKQvfnz7kZiM9i2A3BbQUAZnqGD4oqYHL1tR7xDopxdP9j0JSkaJg997JrLrl+0o55xZoZS+JzwQuHB/h0bQlvtghhIVDnumGqNMefS/AoHlMt2zxDfWcW4SrwmfW32jZHiC6wAcqAz24y/yySinXX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7wVQXk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7wVQXk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857881F01566;
	Wed, 19 Aug 2026 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160092;
	bh=7hRBHDUn1BDaihXaz0zsKwnj1fCJGun3+O7woq2k+pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C7wVQXk2KVOWh8gCvhqWvZMBu+BA7sphxtBr3hnsyZC56Q4+S/6BZexfTYA0fJBuF
	 IeBq6PN0vuWsaVdU+WJsWOWc2WmVszZldmSHnhpmjlnz8HQs5jrco9gfcoJk6dHaM3
	 LM/VVeJ/0QWBmTEnmtc1vT5cAy3LScGoHiekGS/NYiEcZ4VNVyVoqWemFdSa/YJkHi
	 R7XH0GeHJwLIBgdpwSlk61fFaH1QIpBE7cU2sCXp+ZF01Nh/O1u30ZNfkJbHvuzCqo
	 oD3fjo3mtNZCs+cADMlfzN9pfKd6aVcIKokYr4gFovYpXUfxbsENPp0TdvzXulzahS
	 lrgFKxMaqWSbA==
Date: Wed, 19 Aug 2026 18:21:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
Message-ID: <97c54f93-d929-40dc-9899-0f8a0b09b0e6@sirena.org.uk>
References: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5RT14txzp7bhe1x4"
Content-Disposition: inline
In-Reply-To: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
X-Cookie: Allow 6 to 8 weeks for delivery.


--5RT14txzp7bhe1x4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 08:19:35PM +0300, Ivaylo Dimitrov wrote:
> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
> availability through the standard jack mechanism and audio policy managers
> cannot automatically route audio to or from the HDMI output.

Acked-by: Mark Brown <broonie@kernel.org>

Please carry acks forward if you're not changing something relevant or
substantial :(

--5RT14txzp7bhe1x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqF5hUACgkQJNaLcl1U
h9CwHwf/RGgFHGWvd5HWbeD/PDdYyw94nLRzChNH7R2DItBYKwxo7L+0TCrCodq9
eoa2eux+THrCOdxTd90A4o8eDlyLtY7NPeP+nQGaB4QqKzx5YzZyT98SPaBOMPPz
V5HHI5EdcJFy6M8A3DPg8oFbFuGvxOnMhLHLlT9luVs3xS80iUWS5vaJWJy+Tl6t
a3IxSljFaHJXB9/Mr6NySGI/qwpaiJR84DOOnA/Eux+1bmk1XkipoONqmU3JZSMS
Dd5q3dA/NzLXZigqdQs42Ykpo84SVEMd0SaP7SMyChx0HoR6EfQcg6P1VqEa5skK
mZUGMBSJKCS0h/as5D7LuEYNArdzlg==
=/+ea
-----END PGP SIGNATURE-----

--5RT14txzp7bhe1x4--
