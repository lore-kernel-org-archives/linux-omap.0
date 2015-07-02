From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: DTS: am437x-sk-evm: Switch using
 simple-audio-card for audio support
Date: Thu, 2 Jul 2015 08:19:31 -0500
Message-ID: <20150702131931.GH5837@saruman.tx.rr.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <1435838286-30491-3-git-send-email-peter.ujfalusi@ti.com>
 <20150702122337.GE5837@saruman.tx.rr.com>
 <55953421.30009@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55953421.30009@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2015 at 03:52:49PM +0300, Peter Ujfalusi wrote:
> On 07/02/2015 03:23 PM, Felipe Balbi wrote:
> > On Thu, Jul 02, 2015 at 02:58:06PM +0300, Peter Ujfalusi wrote:
> >> The sound support consist only Headset output on the board and can be
> >> handled by "simple-audio-card"
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >=20
> > Still works fine:
> >=20
> > Tested-by: Felipe Balbi <balbi@ti.com>
> >=20
> > one question though, should Line In be listed below ?
>=20
> Does the board have Line-in? I don't have the board, but I know this patch

yeah, it does :-)

> works on it ;)
> We only had playback path before also.

indeed, should go for -next only :-s

> > Also, unrelated to
> > $subject, but if I wait for a few seconds between runs of speaker-test
> > (iow, if I allow mcasp to idle) then I hear a slight chopping sound when
> > starting, perhaps we're unmuting too early ?
>=20
> Is it only with this patch (via simple-card) or was it the same via the
> davinci-evm (ti,da830-evm-audio)?

/me goes test again

also without this patch :-)

--=20
balbi

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlTpjAAoJEIaOsuA1yqRE2koP/3hXDB6mGWORmB69vlA1wZab
yv8h3xQHdbqECw/PIK3fqRNtrd2Ir564keKH8LWj5+EQIamlEiYK+Qop5TTBXupk
RYDtMGyW18qGQhmKKY9CYCxQrkqsBBNDUpDgNwNA6Ppz/fDkSc76CrB8T3qRu57U
FNbw+jtHrNMG6LY/N47EOlblCScWWohVdqRZrGB2EzqO32emBHXbr11K+cbesDwn
PVK/6KlGyMjszjkOX3oPG5YaL4DEm4arEJGcI7+O0hPlSTyv5fObf/YDDc8G0AFV
mzRSRHJIs/i4FhWXMlA9OkiqUx9G8e2Mg0UzBAETS7dagl8HX4H/cbJR4wCf9Wzz
8igKfZNpoP+7pxQGHU7BTYNlcScMLVnXL0xi2U5zFcLx/qVciP+HAbKNDIawbEmx
Ouj23q69rugYwKW/Yd1fKSNhCQCfF1DbtPTPaDZkym5JPAvF1fDakcr0zRSws+g5
XoCiErdZW5ScD/O7KZXksC5iy6RtWyQXf/HUwnPhKigi+otuisk7usvrpsqgR4Ju
Ld2pkaDUt/bJwJrCdV4LLju9uKTS8k5eAgbtfzYqVCMTvgNoZ7vQOXJlE2dqgV9R
kaNNGWW/VUr4hs95pDg2Q1Lq2aIFcUxKiY4mNt3d9UourB0ZtaUv7R/HF9EqWfxP
INl/PCTIKv3OKTMU8H5l
=z9e4
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
