From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
 implementations
Date: Thu, 11 Aug 2011 21:50:30 +0300
Message-ID: <20110811185029.GA15970@legolas.emea.dhcp.ti.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
 <20110811141528.GL28500@legolas.emea.dhcp.ti.com>
 <20110811150718.GA4924@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110811150718.GA4924@n2100.arm.linux.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2011 at 04:07:18PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 11, 2011 at 05:15:31PM +0300, Felipe Balbi wrote:
> > On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrot=
e:
> > > diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> > > index 166a7a3..15e8970 100644
> > > --- a/arch/arm/include/asm/gpio.h
> > > +++ b/arch/arm/include/asm/gpio.h
> > > @@ -4,4 +4,14 @@
> > >  /* not all ARM platforms necessarily support this API ... */
> > >  #include <mach/gpio.h>
> > > =20
> > > +#ifdef __ARM_GPIOLIB_TRIVIAL
> > > +/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/g=
pio.h */
> > > +#include <asm-generic/gpio.h>
> > > +
> > > +/* The trivial gpiolib dispatchers */
> > > +#define gpio_get_value  __gpio_get_value
> > > +#define gpio_set_value  __gpio_set_value
> > > +#define gpio_cansleep   __gpio_cansleep
> > > +#endif
> >=20
> > could that be a selectable symbol ? Something like:
> >=20
> > CONFIG_HAS_ARM_TRIVIAL_GPIO
> >=20
> > then on Kconfig you just:
> >=20
> > select HAS_ARM_TIVIAL_GPIO or something ?
>=20
> That makes things more complicated, because that involves digging through
> a lot of platform code in a couple of places to work out exactly when we
> need this - and it crosses the boundary to arch/sh too.
>=20
> So I'd prefer to keep this simple.
>=20
> The long-term goal is to remove that symbol entirely, but in order to do
> that we need to kill of the "optimized" on-board SoC stuff in those (few)
> gpio.h which don't have the symbol selected.  This is rather necessary to
> progress towards the consolidated kernel.  (Re-inventing gpiolib by moving
> them out of line isn't a good idea...)

Ok, I understand.

--=20
balbi

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJORCR1AAoJEAv8Txj19kN1gmoH/R1WSN8sSKgid5yhSh2YUTDQ
xFbvXeesnLzcKTQQeIb8+kbgBKoE71gmQKQqFOqQ2O+cPL1eJ3lb6UUPeB4dasvJ
kNmWF5XSfG8ZLTeBGaJT+EloWacHEGcAxGVrSDWOtS1W3EhBYQVjNQc3R+G2w/GQ
Io27JOt1Co7+ymzMX3JlBw5cacMxzEVxoXZ4vfmU62IILjMZwE+3cEspXz/yxtA4
iHQt/CGWIHHSAGygnNtwePfcvC/tu3S/+0tBCzr0qfgDBh1fTXxmTsGWcyX4fmjI
NRuJEIJ++R0uBZP4EbDtYOkPZk4EO3N3rBk8EmSjLfZns1aOHPlej3n/DfY/quc=
=98YQ
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
