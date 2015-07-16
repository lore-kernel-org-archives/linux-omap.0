From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] V4 regmap: Use reg_sequence for multi_reg_write /
 register_patch
Date: Thu, 16 Jul 2015 13:52:54 +0100
Message-ID: <20150716125254.GE4039@sirena.org.uk>
References: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Cc: gregkh@linuxfoundation.org, airlied@linux.ie, dmitry.torokhov@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, tony@atomide.com, lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, support.opensource@diasemi.com, bardliao@realtek.com, oder_chiou@realtek.com, laurent.pinchart+renesas@ideasonboard.com, lars@metafoo.de, dmurphy@ti.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com
List-Id: linux-omap@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 03:45:51PM +0100, Nariman Poushin wrote:

Please submit patches in the format covered in SubmittingPatches,
version information goes inside the [].

> Add support for writing sequences of registers / patches with specified
> delays (in microseconds). Logically separates the functionality using
> sequences of register writes from the functions that take register
> defaults, as adding a delay field on the reg_defaults can increase
> memory usage substantially.

This change doesn't do what the above changelog says.  It introduces a
new struct reg_sequence and updates the multi write and patch APIs to
use that but it doesn't implement any delay functionality.  Please
resend with a clearer changelog that describes why the struct is being
split out from the reg_defaults struct and makes it clear that this is
just a rename.  It's probably best to also defer the addition of the
delay field until the second patch where this function is actually
implemented.

> +/**
> + * Register / Value pairs for sequences of writes, incorporating an optional

Register/value.

> + * delay in microseconds.
> + *
> + * @reg: Register address.
> + * @def: Register default value.
> + * @delay_us: Delay in microseconds
> + */
> +
> +struct reg_sequence {

No blank line between the kerneldoc and the struct (as is the style for
other kernel code).

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp6klAAoJECTWi3JdVIfQdeIH/0xR3Zsana0o8euXAzPqm3ok
r9IlQGzEyF7pZWEuAaLuEL89f9F/OWOXBU/BpmW+bSatlq726j5a4TiMqrODwoVn
YwFLn8RqnmtBjM6fBpYKRf+xwNeKvcWPPDp5WkFueV4XQhkLD7HVLM9NEfRSjPyM
GTQboL9PRQYD8PXA/ACHYVtSQu7kSUlLTEP2LAIkmlQ65Bp4lEHDHezwIA4aMwVM
404hpcSnYhuHGg2K3UjoFJeRPJVxsJRQavm8BdKHA7rjGY2irwo2wUt3keQRAKpI
0iGWhWR/Va/3sLty64k6gJuxe2Wm2lpNVlVf/dSKfEU2NTL3faayq6YGEEBtPHI=
=UO9S
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
