From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCHv1 5/6] HSI: Introduce OMAP SSI driver
Date: Mon, 24 Feb 2014 20:42:59 +0100
Message-ID: <20140224194257.GB11189@earth.universe>
References: <1393199401-27197-1-git-send-email-sre@debian.org>
 <1393199401-27197-6-git-send-email-sre@debian.org>
 <20140224155132.GK28555@e106331-lin.cambridge.arm.com>
 <530B6BC3.6070306@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <530B6BC3.6070306@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Tony Lindgren <tony@atomide.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 09:56:51AM -0600, Nishanth Menon wrote:
> On 02/24/2014 09:51 AM, Mark Rutland wrote:
> > On Sun, Feb 23, 2014 at 11:50:00PM +0000, Sebastian Reichel wrote:
>=20
> [...]
> >> +static int omap_ssi_port_runtime_suspend(struct device *dev)
> >> +{
> >> +       struct hsi_port *port =3D dev_get_drvdata(dev);
> >> +       struct omap_ssi_port *omap_port =3D hsi_port_drvdata(port);
> >> +       struct hsi_controller *ssi =3D to_hsi_controller(port->device.=
parent);
> >> +       struct omap_ssi_controller *omap_ssi =3D hsi_controller_drvdat=
a(ssi);
> >> +
> >> +       dev_dbg(dev, "port runtime suspend!\n");
> >> +
> >> +       ssi_set_port_mode(omap_port, SSI_MODE_SLEEP);
> >> +       if (omap_ssi->get_loss)
> >> +               omap_port->loss_count =3D
> >> +                               (*omap_ssi->get_loss)(ssi->device.pare=
nt);
> >=20
> > You don't need to do (*struct->func)(args) when invoking a function
> > pointer. You can jsut have struct->func(args) as we do elsewhere. This
> > can be:
> >=20
> >   omap_ssi->get_loss(ssi->device.parent)
> >=20
> > This should be fixed up in the other sites too.
>=20
> in fact, we should stop expecting that service and drivers should
> manage their own context_loss detection
> Examples:
> MMC:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D0a82e06e6183a252608df48cc4793b83e2d73dfd
>=20
> DSS: http://marc.info/?l=3Dlinux-omap&m=3D139272358619064&w=3D2

I'm currently initializing get_loss as NULL, so context loss
detection is currently disabled. I will try to find a way to
detect context loss once the n900 modem is in a working state
in the mainline kernel.

For now I will keep the get_loss() with the changes requested
by Mark.

-- Sebastian

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTC6DBAAoJENju1/PIO/qazFUP/jM0kCY2bCaADzrkXHG8YS2O
dLWXkeL1zmpoz1+27HLU2nou1s2GtWjKWqAh8jhGq3VGyf73KHx3EI3WYC1IvVN6
PPdq3cigsgddy2jookDT3dFBQg9Zeit3aRE10Qv7/FHmENOm9bANNnPmhqSRZbWB
f833uXYvFEoHIeCbBvJn76Na1VKQI8kaGh6lU0uPIMw8u/SXCEIZTtRHtKbJspRJ
Gt8dUDZytLif3KCYeqdJYb+It9lP33GF5tkAp12aPX4ypj/dQ0lwXng/Gs238N3S
kXUkbaGDKmYlVIRVYkoexU1j3uxwT66X/kPVkSGwaejRiF+Vfcppe09KnyGARhT9
y6G7NsXV/4P0b17KE9kbhf1F3MUNztmWaP5UEa1JuBJTyYWzDc0o7DfRR1RGXdDb
zfFZSkJZctL7VDlZR9bhFYfbpZe2psO13I7PPRBBwldkBBR5KQ3UYgk7lYjHOz4v
hc+wlNwfs6vFABKeRRTQLV7OAUH5EkTwfMYSwmpv4Kvt1Q4kQY5OajxdMESbGiFq
wBCkpdLsonuAfjb/+L2Hl9yJwedKCgO8s6lBN384SMsrOt3L/5d/NyuKTExl7SYv
viRW3Lq23yctbZNL/X9ejtHhOCXde5Nt0z4LfZ7Gs0UT5MFFJ8TZ5qRgk1KIccCn
m5xq8PCi/sjHVmm42Jmb
=NXbo
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
