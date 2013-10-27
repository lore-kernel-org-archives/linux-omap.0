From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
Date: Sun, 27 Oct 2013 17:31:27 +0100
Message-ID: <20131027163126.GA25517@earth.universe>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
 <20131027114753.GB14901@amd.pavel.ucw.cz>
 <20131027122347.GE15154@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131027122347.GE15154@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, 'Beno?t Cousson' <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2013 at 05:23:48AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [131027 04:48]:
> > > > > +#if IS_ENABLED(CONFIG_OF)
> > > > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> > >=20
> > > I have been told for other drivers, that IS_ENABLED() is
> > > the prefered way to check for configuration these days.
> >=20
> > CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.
>=20
> Good point. Looks like there's IS_BUILTIN that's for boolean options.

Using IS_ENABLED for boolean options is supposed to be supported
according to the comment above IS_BUILTIN:

/*
 * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
 * otherwise. For boolean options, this is equivalent to
 * IS_ENABLED(CONFIG_FOO).
 */
#define IS_BUILTIN(option) config_enabled(option)

-- Sebastian

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSbT/eAAoJENju1/PIO/qakkwP/A16K3L2a3ZV6ytDoFG1lMG9
xfKPgI6Y6GZRjU9a4EUPE/qV/NS7BEQl0VUyxVgEYJ4NOCxnSIM/RibTxGlmV5mj
TJz8116axWAsS5mKgQx+zxw/r+dXh2RuZe0ClE2kh2k+ba50iDc7QMRtJlbTumaW
TPcUsGY+2lHVVSQjlTdRpq6v4IcsrOTVYrYTUfPdk6ichUJiqtheCni39zBLvCZ/
Eat//nBa5UW3iajcn3uX2xkwVBiTZNNjFGPQJqmjqGDF4EltkTm5db+EdmdFtrma
I8a8M7lOrhpIva9uEMwz/NC1FPho5l35Vp0emUFWIHqmIDjD8i3dk6s2gnOrFKZ/
n+8k15Ed22nhw5JWoCwdh9bIu2u9drr/6m2JI0YSWagw99+oCtqScNG5KjQmSMgn
YdiAbrOvAFpbj4scu8ntmpj6baUs8FMXFEf+zbclJwgSh+T6AYf6er1hziHUKqrt
WIXR6+AoDYoiX0z8zFoaecx2TDT1B4mjbCUSyenFvwO8mlpyVDigFaBcCgy/Jjfk
+1aYeXqqa4RjeD7a5VWTJf4cMnxe41W8PW3OJxDnXhFMSbhKLYhMTmorkvLS4qsd
uSysrO7i/YGn7TDypBWIimjRIl/nwisHdleRipSvKXloPn3vMxVGCYqM4CE/LpSW
Vjoarfs0iyeDNS6KVpGm
=iXiI
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
