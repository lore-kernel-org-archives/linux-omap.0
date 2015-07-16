From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 V5] regmap: Apply optional delay in
 multi_reg_write/register_patch
Date: Thu, 16 Jul 2015 21:55:22 +0100
Message-ID: <20150716205522.GC1602@sirena.org.uk>
References: <1437060982-26519-1-git-send-email-nariman@opensource.wolfsonmicro.com>
 <1437060982-26519-2-git-send-email-nariman@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437060982-26519-2-git-send-email-nariman@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Cc: gregkh@linuxfoundation.org, airlied@linux.ie, dmitry.torokhov@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, tony@atomide.com, lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, support.opensource@diasemi.com, bardliao@realtek.com, oder_chiou@realtek.com, laurent.pinchart+renesas@ideasonboard.com, lars@metafoo.de, dmurphy@ti.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com
List-Id: linux-omap@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2015 at 04:36:22PM +0100, Nariman Poushin wrote:

> +
> +			if (regs[i].delay_us)
> +				udelay(regs[i].delay_us);

This is a bit funky.  While Takashi is correct that we could be running
in a spinlock equally this will mean that we could end up with some
really long busy waits.  It feels like we should at least make an effort
to complain about that, print a warning or something.

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqBo5AAoJECTWi3JdVIfQ0T8H/3Trgv/8UhuhU1HOESHpqCXX
MuVbzMSojiAow5FIrxnRWkVDRHACysPGN2PLxttBerFRr+kYB/CViMvYb0mdZjti
z+JEb0r63lY4v5a3y6p30UxOCvNnl48Vvw/mvc2rEfGBVrPdCOAt/Gcuu9WbjFOr
H6pwxOttrGwwaR+7v4skFgJRfFAJCDNg0F6F7l6Z0JCeAZf/8rDO+qVFCVzydoMo
uBQ+VRDBwIXul2+uPNjIKwKRVOH2kRpFiB8OUcwrvBIy/q6cPRuZ7V5+Y/eXkvNv
gfzc7DDuGZUM9OMOovCFD7sr6nWnsO4MwiLL77/3uiXE1UY0dwMmJoM/RS+liJg=
=ExP8
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
