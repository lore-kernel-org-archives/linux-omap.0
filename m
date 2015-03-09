From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 16:20:14 -0500
Message-ID: <20150309212014.GE22341@saruman.tx.rr.com>
References: <20150309205157.GE5140@atomide.com>
 <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com>
 <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <binmlist@gmail.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 04:17:29PM -0500, Bin Liu wrote:
> On Mon, Mar 9, 2015 at 4:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
> >> Hi,
> >>
> >> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> > Add a minimal driver for dm816x USB. Otherwise we can just use
> >> > the existing musb_am335x and musb_dsps on dm816x.
> >>
> >> dm816x has the almost identical usbss as that in am335x, we should be
> >> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?
> >
> > Tony's using the same musb glue layers, this is just a phy driver,
> > right ?
>=20
> Can the current am335x phy driver be adopted too? I remember it is
> under drivers/usb/phy/.

Tony will be best to answer, but according to our IRC discussions, it's
too different. Tony ?

--=20
balbi

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/g6OAAoJEIaOsuA1yqREHMQP/jt4915b4cL1R5X3yf+zHpq+
NP6a2GLMmVSKhXRQo+EqWkuJfKOyoBtTLZm/66Ayf31s4q9NTXI7Ni7R6rw8FlbW
wCWe6ZpVI4IbDPHK0I2W0tob489zNX70di6XX4+cB597HNrTfcO/7FLInaHCVnPg
wmtyvDSK9NmNDF3nU127abA52IpR9s620cL09esehIODxXl/JQ6yCtn7wgHPhdIV
ir76GLWiEO5dAZG5oLcMWFn05eFOPaQV3lBMpM4kKjJ3FzGtWVFxUMZdZgjdL/FB
MRBmA1qgop+uR6/aaQ8BicGK+9JeOgilSOuz+QPb7258CCWNZOM1nRolHIzy3hZw
vQOAUS6HF5lcyTSKAemhXMfhQEVAfy5/wRCBxztA7ygsZa5/g3CiG+lYAfStq0VM
L33Y+zrDRifNHkt+ywSZ+JGS7/aKYEB5yWqZV3z1myEyl5+0RrYXRzvzt3uxER8s
YmGXFQu/+nfBkmfNTZaqNUcvp01BpSAwFKt3x2dth6W0YUckUxcx7RkJcMoBdbEj
PwFzRocqkhbGAifD34jp7gnrGhlIjWJ4MVZ4sLTbeaGnh2ryrtRN0++d93CSk4Gb
fEhGC421AY2IzMkhqZ1niovQvquvGmuCuIZGn69gP3WAmUFfnSTqQsNL/vFy9sfP
Np1txt7ei1MmhR4JPGKW
=XocC
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
