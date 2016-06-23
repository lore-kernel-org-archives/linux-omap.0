From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH v2 1/5] ir-rx51: Fix build after multiarch changes broke it
Date: Thu, 23 Jun 2016 19:48:51 +0200
Message-ID: <201606231948.51640@pali>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com> <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1585174.WKcMGT8M56";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--nextPart1585174.WKcMGT8M56
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 22 June 2016 21:22:17 Ivaylo Dimitrov wrote:
> The ir-rx51 driver for n900 has been disabled since the multiarch
> changes as plat include directory no longer is SoC specific.
>=20
> Let's fix it with minimal changes to pass the dmtimer calls in
> pdata. Then the following changes can be done while things can
> be tested to be working for each change:
>=20
> 1. Change the non-pwm dmtimer to use just hrtimer if possible
>=20
> 2. Change the pwm dmtimer to use Linux PWM API with the new
>    drivers/pwm/pwm-omap-dmtimer.c and remove the direct calls
>    to dmtimer functions
>=20
> 3. Parse configuration from device tree and drop the pdata
>=20
> Note compilation of this depends on the previous patch
> "ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51".

I think that this extensive description is not needed for commit=20
message. Just for email discussion.

> Cc: Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> ---

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1585174.WKcMGT8M56
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldsIQMACgkQi/DJPQPkQ1IJCACeKz/cuSf/mBaB43BuBBQwqXIU
6gsAoIhuqhaNZo1mFjURPiILMMJvmMd8
=h5mv
-----END PGP SIGNATURE-----

--nextPart1585174.WKcMGT8M56--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
