From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [4.4-rc][PATCH v2] ARM: dts: am4372: fix clock source for arm twd and global timers
Date: Tue, 8 Dec 2015 12:03:55 -0600
Message-ID: <87wpsolsvo.fsf@saruman.tx.rr.com>
References: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448898998-32749-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
> But now they are clocked by dpll_mpu_m2_ck =3D=3D MPU_CLK and, as result.
> Timekeeping core misbehaves. For example, execution of command
> "sleep 5" will take 10 sec instead of 5.
>
> Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
> it for clocking ARM TWD and Global timer (same way as on OMAP4).
>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and SC=
U nodes")
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

this seems to be the best fix for this problem, yeah.

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZxuLAAoJEIaOsuA1yqREOp0QAJpHXO1Fyog8LbLIXpSEkCWV
o2GSNMzg6ZIJW2GLZSCi6kkQqBSQ5v4M8HaY/3C5ta3uwyVmOWeHL+ZhDd7RpKE2
aKIWhH7lP++lxxGqv+E4SlEn3eTitJI5lVo+rN+z1cCuhDREcKYgydsfDFigfgKu
7u7Rts9OxI5vdXnrGsF3sifnElzVkAdOPJge7285y3V8z7OiuJifxVk05+4nIinX
UO4QJUbvYxeZtl307Hh3qUpqU6ODxn+kzFnsccfQl4VV1F55NjDV6Mzb0eHc0G0W
Y+1jzPvUjHsfHsk2/CtO9Fyo4R8QAv6IKjnhr4sapVwmhzJl8g8PEP0GLOcnA7N7
oKpAvPyP1XwMW7APKgNO5WgYc/gtT2z/Z9Sek/FadC5bDTZtGrELYq0QEKMTKNQK
cf2IO/4hLcezifFEhkkNqhngegL6Odp53WvbFQRi5WGBuEMBseFhG3C9Q3SdnCTn
LTmBOpDSVoWjqdE7RwlZa5/f4+Fx7Td0Gzl+fzeD4X1Z6+g4Rsd5zNipIg30mASZ
MTjuneCdTab5y531NIZhVqehQOrzbCvA4nF7OYIa3ZLWI2xwXP5OqPYQIUiXsgsx
YpVjmcx+Uqa3Ml1cWDOrU+Wik5mZhXPlI+m/GlGcrH3MzZ5chLcgrJZx969tc5Ny
uv1NFfXrBv0nt6EjhbRo
=e6TM
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
