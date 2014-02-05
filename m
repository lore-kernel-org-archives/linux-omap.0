From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] ARM: OMAP2+: Add support for thumb mode on DT booted N900
Date: Wed, 5 Feb 2014 17:31:17 +0100
Message-ID: <20140205163117.GA15996@earth.universe>
References: <1391603582-11371-1-git-send-email-sre@debian.org>
 <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHYPw2Ep9VP6Tem979ewcztdxkHkG8eR_U31U=f5ibsVa5AS4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Wed, Feb 05, 2014 at 02:12:56PM +0100, Pali Roh=E1r wrote:
> 1) Why are you using if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) instead #i=
fdef ?

This is the preferred kernel style as far as I know.

> 2) Why do you not write warning or info when omap type is not
> OMAP2_DEVICE_TYPE_SEC (e.g qemu) ?

I assumed, that the workaround is not needed for this device type.

I just added the warning for missing CONFIG_ARM_ERRATA_430973,
because its very likely a misconfigured kernel.

-- Sebastian

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS8mdUAAoJENju1/PIO/qasvoP/3MRUyQywZc1tk/+f5GncWpY
LuBc3rOtX1mStsPurWSQUQB5mYgzkrn4Dgjv5fhVoe1mHsSc2Dc9Y20oahmibNi9
h3C3dBFbt5QsQVJXsPMK0i+RZLdKcCt3F34EtT4iywT6d56JUAKH6+NxTYJj97Tj
CPaJvcG0nEDmDfngEQkxfsOWfjfkbKOiT3rpeI6HjDtx/KvDsPfUKbIQImeizSSp
BtUhaQI/FT7jpoDwlx932ZFK4gXHVdD7nGAOWI5gFgeHi64W9ikk/Gb5RrVKEfPr
4P9waOlkjhDespMjSMu8kGyxYqWAc/dnEXh95UwJrzBC2kM5iRJBP9CKXiX7/0Rs
RHd3HxvwYrTLrfdySIqwafJwNNQqVHYCNL9a0X8byHbEpQbPtcuav/+IGZn+lmg8
sUVrWt63zEBU4w9Xfc+U1UjpQR57gIwns/AF4sIH7g8BwGIlHPfbTGJI72tRIUBR
z5Yrl2jrCVZPqj6AetvY37iMBt8q/IfMAb7jmLU7EqN3X6qKiP8HPEzeyF4OM12j
nGwqBhGMDYJxCuC+K6YToTRJKDH64HV3Jg5QIyGdlZUA7g0d/Kmf/vIBjDLGH6ZA
SS6VlUkmWo1PmdeCJITX/gXQ/so/7SE69ZVUFu8NC/Hfi5uF3yvAuINp47IjRevW
syQjUgQ+yqHkNEbWYQPu
=3mGD
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
