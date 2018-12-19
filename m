From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drivers/regulator: fix a missing check of return value
Date: Wed, 19 Dec 2018 12:27:23 +0000
Message-ID: <20181219122722.GB8130@sirena.org.uk>
References: <20181219050413.16374-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181219050413.16374-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 11:04:13PM -0600, Kangjie Lu wrote:
> If palmas_smps_read() fails, we should not use the read data in "reg"
> which may contain random value. The fix inserts a check for the return
> value of palmas_smps_read(): If it fails, we return the error code
> upstream and stop using "reg".

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwaOSkACgkQJNaLcl1U
h9Axywf/QQk28N5D/NaWEgPrbz0mPuRk1r3O85sG+B+5S6Cj3lTx5Youlcmsx65j
bOWFNIe5cSOyZL8jI4aF/9/CgR0KqsO+G3I2u3G0sdSR0opKxlSo9CIzVOOcObDv
7/wRFQoxQIpHb86LT49B3upGrqqSFAdKgI4tG1N/LAhwc0iS0ewNCZ6OWAnMIOxV
CivGGDoSTvu32kmMq4QPS2rVjj1vBDtVzX1OtCnpZTVrZT+gV/mHlY8MZmj6uUyb
qY98+Q32FCbqsBWy4i98qIdJpzz9kQz5qkPJewSkQ6emppDLBRCCdA6aFLrzZKeN
KS2FbeiuVSKHS/DqOQj67XoFJy/VXQ==
=oYcO
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
