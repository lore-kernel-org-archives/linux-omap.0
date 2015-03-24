From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv2] ti-soc-thermal: request temperature periodically if hw
 can't do that itself
Date: Tue, 24 Mar 2015 12:30:34 -0400
Message-ID: <20150324163032.GA13813@developer.hsd1.ca.comcast.net>
References: <20150103114632.GA21883@amd>
 <20150118202447.GA29014@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150118202447.GA29014@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 09:24:47PM +0100, Pavel Machek wrote:
>=20
> When periodic mode is not enabled, it is neccessary to force reads.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

This is a malformed patch. here is patch output (or git am)
patching file drivers/thermal/ti-soc-thermal/ti-bandgap.c
patch: **** malformed patch at line 68: (english)
http://www.livejournal.com/~pavelmachek


I would really recommend you to use git to send your patches to avoid
such problems. Can you please resend this patch in its proper format?


>=20
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.c
> index 634b6ce..2fde78c 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -43,6 +43,8 @@
> =20
>  #include "ti-bandgap.h"
> =20
> +static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
> +
>  /***   Helper functions to access registers and their bitfields   ***/
> =20
>  /**
> @@ -852,14 +831,21 @@ int ti_bandgap_read_temperature(struct ti_bandgap *=
bgp, int id,
>  	if (ret)
>  		return ret;
> =20
> +	if (!TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
> +		ret =3D ti_bandgap_force_single_read(bgp, id);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	spin_lock(&bgp->lock);
>  	temp =3D ti_bandgap_read_temp(bgp, id);
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVEZEoAAoJEMLUO4d9pOJWZBEH/RO08iOBFZT3xGZ6J4rWD46K
GtKiiW4LYsDUjUytNLriWW20AHOirz87v9e6PBTaPDrhoFRbXuEos0wiRQEY9NtQ
KVdgInsw3X/EDx6rCS6QN/BAJrN2N+0aNrG/dTr5DqggoY9onjIiOawnkOwf3MzN
GYyaQRvahz/UZP0sjOebpymwc0eRdPRBC+VTJnnaozXuOdFXvcHKfemHcOvwsYwC
STmBApQQENWiBJNALIozpRtJHaHLTW0A4kHpVzEz2LXkVvQMBajL+vDe7iul8//k
bfL2zhPdZfijTH9bHJBtHl85qJlzKMu6RKtMXp1P2R+mr843/4e6MNaO0dKPNxA=
=Uzz3
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
