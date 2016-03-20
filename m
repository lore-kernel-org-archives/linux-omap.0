From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v4 1/5] ARM: dts: LG Optimus Black codename sniper basic
 support
Date: Sun, 20 Mar 2016 16:58:38 +0100
Message-ID: <1458489518.29161.3.camel@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
	 <1456663185-14170-2-git-send-email-contact@paulk.fr>
	 <20160229215136.GO13417@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-94AEBQ1pEYSQvS60BkB5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160229215136.GO13417-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-94AEBQ1pEYSQvS60BkB5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 29 f=C3=A9vrier 2016 =C3=A0 13:51 -0800, Tony Lindgren a =C3=A9cri=
t=C2=A0:
> Hi,
>=20
> * Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> [160228 04:40]:
> >=20
> > The LG Optimus Black codename sniper is a smartphone that was designed =
and
> > manufactured by LG Electronics (LGE) and released back in 2011.
> > It is using an OMAP3630 SoC, GP version.
> >=20
> > This adds devicetree support for the device, with only a few basic feat=
ures
> > supported, such as debug uart, i2c, internal emmc and external mmc.
> ...
> >=20
> > +&i2c1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c1_pins>;
> > +
> > +	clock-frequency =3D <2600000>;
> > +
> > +	twl: twl@48 {
> > +		reg =3D <0x48>;
> > +		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
> > +		interrupt-parent =3D <&intc>;
> > +
> > +		power {
> > +			compatible =3D "ti,twl4030-power";
> > +			ti,use_poweroff;
> > +		};
> > +	};
> > +};
> Chances are this devices supports cutting off the voltages and
> the high frequency oscillator during idle. So you may want to
> at some point set compatible =3D "ti,twl4030-power-idle-osc-off"
> here.
>=20
> Anyways, applying the dts changes into omap-for-v4.6/dt thanks.

It seems that v3 of this patch was merged into your tree instead of v4, whi=
ch
contains some improvements over v3.

Should I submit a cleanup patch with the diff or can you use v4 instead (if=
 not
too late)?

Cheers,

--=20
Paul Kocialkowski, low-level free software developer on embedded devices

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-94AEBQ1pEYSQvS60BkB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW7siuAAoJEIT9weqP7pUMrVMP/Riycq5Z5Crssczc/72uA8sK
uPbYyZCvEp2gScWwWBWoQWC3Mdej0HGpEKR+BgoB+suhEedvgdczwp13QuaQ3gLO
qzOD0/yuYGsUsdGjBIpnl++KIlyLHs8C9PHWlsa2j3LYRgIrE8qAcVN+kzboo74x
UR3/qHDoYe0BdeHhUNVm5pHr4ByGWK0SLnjK9a8UqbcOTRrlFITgCbGzlz+Oybk/
ZenYcNW5ktXsk2mmdcgYU4PpW889EJV+acPHAEU2RXBfSX7kuEpZdlTS338JsBDF
bSXgmplIqzpDQHUMcqgOxz1ZD02Q+eDcMrWYqxMRiTG7K1bAdUKlLuStVVC4EeLn
sJeZCJag+DVEfWc8X7UYiVFHI8O9w0NDHMkk15LflA3vLnxpl0RwNAdRiK5ig2lp
FX5+ep9HkOKvWKBECTOQc+2h8PtiAakPRf/ErD7TMdIMr5mMwJBj9xxj/3fxL8CO
DVqwinw6vOREe9+0DXu20D0IiMEYpcaHPLVrdOoyXVSm13HnQ+p3Kd+Sbua6XLVP
6yS5XQo0cHEg/9DupiOiNAaMHzvODm0MxKrX3A5EBN+M1zpegfSWoAkI/dtHDSJn
vODgBIekQtMIeP9z9bK1Vo5ZCBwpS+sQ1qMVDGaIkvMBLS/HfD7QAG11GGEddPH2
t/6quanX+ZlI2fYX+WBz
=ubsa
-----END PGP SIGNATURE-----

--=-94AEBQ1pEYSQvS60BkB5--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
