From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [v5,2/8] mfd: retu: Drop -mfd suffix from I2C device ID name
Date: Wed, 19 Apr 2017 21:40:13 +0200
Message-ID: <20170419194013.op72kqoa4otn2lfy@ninjato>
References: <20170412172800.23035-3-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvtw4kaoofrofdkv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170412172800.23035-3-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--xvtw4kaoofrofdkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 02:27:53PM -0300, Javier Martinez Canillas wrote:
> It's not correct to encode the subsystem in the I2C device name, so
> drop the -mfd suffix. To maintain bisect-ability, change driver and
> platform code / DTS users in the same patch.
>=20
> Suggested-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--xvtw4kaoofrofdkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3vRwACgkQFA3kzBSg
KbYgxxAAsTa1qazeXi5IoYyKivLI1x0Nh0gxNhT8fwitlEOZkTFnT1MZfMo0swMf
idxw56JNKdkn4oS/XV1SNmrzlNJd4lQZ8ug0Ql0vhnpACvS6b00IgM+whqk38cgb
OFvBPYmj0RKtj9WFDUn0PR0hE1a7Z807ck3SDrfcTfdTda/Qnq/7ntmHe+vhbeFO
t+GwPvMPSs6gAgHVztxsyV28T7p//aK6xDNhN6aaWgwcC3zJSLc3inzm4OM14ec4
X2u4CLg6+vHbipoYk8unvF5lgw26p5GpgIqo6AT1nmSLeQC7Nz/2FFlIf5XoKC+B
M6QCEHyqHYRpCtRSMkJh1u8B3UNy1NNL2my8sVNiSQig3sefrA2mZxR8CbPkBfDg
WlDv7gJ51l7OEe8Jib13FW3PujQ7i8FxL56e7FMqi+wKgLE1KX17QkEOnNBStEpn
cszWdw/l8Tfs1cUaAij/2Gee6Wp31HHeaAdYBMbIyRywwwJoOBeOhr8p0NoHUzRk
QdYDPSp53Rrg4s/OAIiVBfbx3GzcwUkcGQAW2zxGmEJZmxiF0gVpiDB2zVVJJQXT
AWnyyw8g1Vi6IS1kGNYVCP8WWE1uZBX6b9LYpa+BpZBaY0hk6gUbKd3XtKbHGMft
l8HLz3L8zgk8PVghPJJ2JI+JP47+pG0cFGpgMqyGk89wQJ291xI=
=xnO7
-----END PGP SIGNATURE-----

--xvtw4kaoofrofdkv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
