From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC 4/6] drm/tilcdc: Add DRM_TILCDC_INIT for "ti,tilcdc,slave"
 binding support
Date: Mon, 2 Mar 2015 15:04:27 +0200
Message-ID: <54F45FDB.3010408@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <6cf3243f87975ef349dead7af136870fa406ad6b.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lFAukBA62WarVqfD1QEcToaV1JWkN4qNg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6cf3243f87975ef349dead7af136870fa406ad6b.1424961754.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--lFAukBA62WarVqfD1QEcToaV1JWkN4qNg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/02/15 16:55, Jyri Sarha wrote:
> Adds a DRM_TILCDC_INIT module for "ti,tilcdc,slave" node
> conversion. The implementation is in tilcdc_boot_init.c and it uses
> tilcdc_slave_convert.dts as a basis for creating a DTS overlay. The
> DTS overlay adds an external tda998x encoder to tilcdc that
> corresponds to the old tda998x based slave encoder.
>=20
> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/gpu/drm/tilcdc/Kconfig                  |   6 +
>  drivers/gpu/drm/tilcdc/Makefile                 |   2 +
>  drivers/gpu/drm/tilcdc/tilcdc_boot_init.c       | 270 ++++++++++++++++=
++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts |  70 ++++++
>  4 files changed, 348 insertions(+)
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_boot_init.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts

All this is needed to support the old bindings, right? So I would
suggest scratching "DRM_TILCDC_INIT", and create
"DRM_TILCDC_COMPAT_SLAVE" or whatever, which would be a user visible
option, enabled by default.

This way one can just disable all this compatibility stuff if it's not
needed.

 Tomi



--lFAukBA62WarVqfD1QEcToaV1JWkN4qNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9F/bAAoJEPo9qoy8lh71VM4P/inrU3CQ72H4iMe8d4vGZM65
S6T/UbIxxbO0JLehtWPww0U8ORKTCEMh1JCMJsNqqJjElKbcJ+MvZmsJPaMpwTJ+
jJTzeQv8IBliOsxQxxU2t9E65UN8JaKaKNLq8+uBSE+h+ARcx+udyJnnuNWVU0JT
OHfN7UL6GtFGf1pBWtM3nNJAqBXUPPU1BIhG97mPCSqiDIxlrIyokLH93NW6PNY1
SPyam4M2B5YMBoUht9EUUk+h2n/WiD4ElHFNA7+Iqjt7JKDWxLm2gAHs/08Hcf6B
pVk1Qyi/sSOt8yhYiTwnAtbTV5aUqPWXJNyEjEsx8zlfox7U6weusj7ljY4giuMM
l86QnWBtWMlVIVBMM6wGZTLKq/i/X1dw2tq2BsOTm/4ro9aAWEoHwM9cnIMPhqDi
r4o0jLMQxcrk2Vk7eGVkftpL5dPmEQtzwnjewlJtGlGYAcVbYunxQfQAw/LR7V+l
WZJr+1ZUn4ZtIUxJKp6djgZR1Uig88kvGTZEJEWoC/ilmgSYY3K0PvcyVpjLNky8
j1i86V3BKIdGO+zjVhbj8uay5W/u2+N9Gc/D5Vqn0MHJyvZZE57ElCR8BmyNF+Qe
M4c9rb1Jk648W/b67mgRCYKQkkMLCiWP2T296TplLZUeBRkaHFFnAkGqugKA70Rr
6qpvgTkmvw22JwrfB73j
=aaYL
-----END PGP SIGNATURE-----

--lFAukBA62WarVqfD1QEcToaV1JWkN4qNg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
