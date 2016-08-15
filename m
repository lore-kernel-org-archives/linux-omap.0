From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Mon, 15 Aug 2016 03:12:10 +0200
Message-ID: <20160815011210.vnqwdpapzx2q6gzg@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <CAP=VYLo4ptVzhPjKoiiakbCgBSmpQndNzf0LHWxCZs7LiZ7PYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iwkwabbleb7dt4qo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAP=VYLo4ptVzhPjKoiiakbCgBSmpQndNzf0LHWxCZs7LiZ7PYw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--iwkwabbleb7dt4qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, Aug 14, 2016 at 07:54:28PM -0400, Paul Gortmaker wrote:
> On Fri, Aug 12, 2016 at 11:14 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrot=
e:
> > This driver adds support for Nokia H4+ procotol used
> > for example by Nokia's internet tablets (N770 - N950).
> >
> > [...]
> >
> > +config BT_HCIUART_NOKIA
> > +       bool "UART Nokia H4+ protocol support"
>=20
> If the option is a bool, then you don't need module.h or any MODULE
> macros, nor do you need any __exit or unregister related code.
>=20
> Alternatively, if there is a use case for it to be modular, then maybe you
> want to change the above to a tristate.

Actually it is bool and modular: It becomes part of the module
configured by the tristate CONFIG_BT_HCIUART option.

-- Sebastian

--iwkwabbleb7dt4qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsRbnAAoJENju1/PIO/qao90P/1T1PQHcpiCCBVTbEOqsV+dU
DnaWi3DoEz6h4LSvS2CST4wv2BYKdczrdTeuyoakUnQ0676mC4lzS/lwYJzz6Xy1
hQAhfkZIjp3Erlz0j1ExezZAcgfjQwvoq7Z1jaJSEI1vvVLTrS9TIF/wpX0lIWeB
U9zwB9bp6gPucP10OCYCAEHHqnKWEV8WmyKgaUd1qqJROuXOhPmLCKc0+joLwCKF
67/GqWsSkBdYz/2/l0Y+RQx1wOzyOWrBq518mJVW36MIvqGnDA74nx8uF3FqP6sV
hdoZpfEeUjmIgUbXbJSsHBw8l76WdOsSCsHkwcGV6tpdMucOmMG7Iz8NRm+B5BeR
FhSYVbiwz8gkF2MQ5F1f4sfnXTaZtRB1NKRcuC7kFPR9Kw54OPJweVYY+aW2yWlf
VLpKRrvBga1iFC6ZtOcfTcNlEEJNAQbkPf5ak9JQvsy/vnIvVnIs6kr2juskVv87
2zcBExscF/RYTNJRP7gTwEeTGXdcYxYIrU4lB9nC9LHvdP6uNWVOXaw6TkowEZLI
xIXtl2rbKy56JCBnZkjPkhGuWkV2FpYV6ZYrBR9sm0R/UI82g095WgKOiSxfY1AJ
PWsPJiWa//9UAOSVk17ViRWzZLJn9Zw7JMJzAtWVa2oRjO80hBuogYiQIzllpfR9
f2hwJYn3Fd661eeUMjN0
=U6z1
-----END PGP SIGNATURE-----

--iwkwabbleb7dt4qo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
