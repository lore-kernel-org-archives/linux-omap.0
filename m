From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 20 May 2014 23:10:47 +0200
Message-ID: <20140520211046.GA3476@earth.universe>
References: <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <5379CD24.6040508@ti.com>
 <20140519160447.GB4849@atomide.com>
 <537A55EB.1080507@ti.com>
 <20140520051203.GB28812@earth.universe>
 <20140520054852.GA12384@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36231 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbaETVK5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 17:10:57 -0400
Content-Disposition: inline
In-Reply-To: <20140520054852.GA12384@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 10:48:52PM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [140519 22:13]:
> > On Mon, May 19, 2014 at 10:05:15PM +0300, Tomi Valkeinen wrote:
> > > On 19/05/14 19:04, Tony Lindgren wrote:
> > >=20
> > > > In many cases however we do have multiple compatible strings that
> > > > describe how the device is wired. See drivers/tty/serial/of_serial.c
> > > > for example. It has "ns16550" but then it also has additional
> > > > "nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial=
".
> > >=20
> > > All those sound like SoC components. In that case it sounds fine to h=
ave
> > > the device compatible contain the SoC name. We're talking here about
> > > external, detachable devices.
>=20
> Yes I agree it's also hackish. But playing with the compatible flags
> avoids adding other custom workarounds.
>=20
> > > >>> Not use what you're after with the SPI example though, but sounds
> > > >>> like that's something different.
> > > >>
> > > >> I think Sebastien's example is just like the issue here.
> > > >=20
> > > > Hmm is there some existing example in the kernel like that?
> > >=20
> > > No, Sebastien's example was just a hypothetical case. Here, using your
> > > way of having SoC specific data in the .dts, we would have
> > > "sharp,ls037v7dw01-omap-dss", and in Sebastien's example with a touch
> > > sensor we'd have, say, "synaptics,xyz123-omap-spi".
> >=20
> > Yes, that's what I wanted to say :)
>=20
> Hmm I think we need to add few things to the hypothetical SPI case
> to get it even close to the panel example. Like assume that no SPI bus
> exists, [...]

The important thing is not, that there is an SPI bus (hardware), but
that there is a common SPI client framework (software). That's one
of the problem's I see with the modified compatible value.

Basically I see the following problem with the appended -omapdss in
the compatible string:

 * You can read the -omapdss as "to be used with omapdss driver". In
   this case the compatible string is just needed for driver loading,
   which is frowned upon DT binding maintainers AFAIK.
 * Alternatively one can read it as "connected to omapdss". In this
   case we add unneeded redundancy to the DT. This does not belong
   into a compatible string, since its encoded in the DT hierarchy.

And btw. Tomi's rewrite hack basically works exactly like this, just
without adding the redundancy explicitly into the DT. Instead of
prefixing the comaptible string he could also add a -omapdss sufix.
That's basically a proof, that the suffix adds useless redudancy.

> [...] and that potentially multiple different Synaptics drivers are
> trying to share the same compatible flag for a non-existing generic
> binding.

If there was no common SPI client framework you would need two
different SPI client drivers for two different SPI host controllers.

Obviously its a bad idea to have no SPI framework, but that's not
important for the example (except that there should obviously be a
common panel framework) :)

> I think then it's getting close to the panel example :)

-- Sebastian

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTe8TWAAoJENju1/PIO/qaYxgP/joS7fClYFQXSFXi+oe1Xfe0
n3Hl3futAbZ1cgauu54pWTbnwzv6JdfedmV6GXAfrKkwBZCVKR6P/dN2TFOYHUdV
lPJN/k3VSieJUx2sUTTthegaIGymiZwEtrJGSCv7b9Oz6vjTZAYKR24MEUA9DTXR
mfOM1DX7sCP7DugPyeP7vcAQ1dr8E9IhRYIEEbyzafi5dkgO1ojUbYCugKDk9NL3
jrEdw1Cbmw+1EUV6ATjbLVF/GiTmU1QunYGh29oGamLrnI6DrfU/I/FqYwC9Dxnp
mjoYxyQ3Qk+FzGvYmD1BdwzHe/3oOuL0aOps6ytq5C+ktU3uPQxEATzlVEgZRBzD
pMEh9JkQKqPyWyc/T83TFrBzuKvw3gVvy2un7Hirur9FE7TVaiS0yuZyR0o9IWI/
WFlufQckSzQFcKA9nCB7k5foy01c77FQ6KKsEbNgx+MLOyDcAA/kYTeuGlQzl3Fu
RkFmwmlx4HvI3dO1CUQY+YQn+4FUKsvd3CDnYvvkdklrQw5aZV9xiIBLBGGfRzEk
zoJgo+6jFfeimP+fDzIuMVWocLfxZbXKN+PJ7Mt2AHIrxNdYDYZPgEQTv6ANKLtM
evt8Zc6ootQzFCvZCp4jVMcylFjP8nWPnM5ZJ0g296UAanSXtDWqP0hMd92NgYl6
2eWfaMhblzgbBhL9ICaI
=oeEM
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
