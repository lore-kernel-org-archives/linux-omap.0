From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/7] mfd: menelaus: add initial DT support
Date: Mon, 29 Dec 2014 12:12:56 -0600
Message-ID: <20141229181256.GN29379@saruman>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-4-git-send-email-aaro.koskinen@iki.fi>
 <20141227212553.GA21729@saruman>
 <20141228233445.GD582@fuloong-minipc.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45506 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbaL2SN4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Dec 2014 13:13:56 -0500
Content-Disposition: inline
In-Reply-To: <20141228233445.GD582@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 29, 2014 at 01:34:45AM +0200, Aaro Koskinen wrote:
> > > Add initial DT support.
> > >=20
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/menelaus.txt | 30 +++++++++++++
> > >  drivers/mfd/menelaus.c                             | 52 ++++++++++++=
++++++++--
> > >  2 files changed, 78 insertions(+), 4 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/menelaus.txt b/Doc=
umentation/devicetree/bindings/mfd/menelaus.txt
> > > new file mode 100644
> > > index 0000000..5f69f23
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/menelaus.txt
> > > @@ -0,0 +1,30 @@
> > > +Menelaus (Texas Instruments TWL92330) Power Management chip
> > > +
> > > +Menelaus provides facilities to control the power resources.
> > > +
> > > +Required properties:
> > > +- compatible: must be "menelaus"
> > > +- reg: I2C address of the chip
> > > +
> > > +Optional properties:
> > > +- interrupts: the interrupt
> > > +- ti,autosleep: All regulators are put to sleep by default.
> > > +- ti,vcore-min-microvolt: Range floor for the HW controlled VCORE
> > > +- ti,vcore-max-microvolt: Range roof for the HW controlled VCORE
> > > +
> > > +The use of ti,autosleep is recommended at least on Nokia N800/N810.
> > > +
> > > +Example:
> > > +
> > > +&i2c1 {
> > > +	clock-frequency =3D <400000>;
> > > +
> > > +	pmic@72 {
> > > +		compatible =3D "menelaus";
> > > +		reg =3D <0x72>;
> > > +		interrupts =3D <7 IRQ_TYPE_EDGE_RISING>;
> > > +		ti,autosleep;
> > > +		ti,vcore-min-microvolt =3D <1050000>;
> > > +		ti,vcore-max-microvolt =3D <1400000>;
> >=20
> > looks like these should be first converted to actual regulators
> > otherwise we will have to maintain this binding forever which means that
> > any effort of adding regulator fwk support for menelaus will become a
> > lot more difficult because it'll have to cope with the legacy/bogus
> > binding.
>=20
> I was thinking such conversion could be done with incremental patches...
> There's basically only one board (n8x0) that uses this and not likely
> to be any others. Is there a way to declare bindings unstable?

AFAICT, once they hit a major release, they're stable for life :-)

--=20
balbi

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUoZmoAAoJEIaOsuA1yqRE3ogP/1G1zG8EWie+x3cJzrdfZHSp
WYQZ4fA8QL4D/GDCJzVvrNaNGf2/MWUeLYEJpZrB87OQ5NvdUnPm8FKT3Yj5KWCb
0GMEDGTMwiDpw+ZcqxZmHHYxFWbeHjqQ3CTlm4ogZYHO490pXApuMegjPNWNKYTQ
cUBpbJsh5qaqm+Fptl7JQ5lGGdgTc1tJpGEW9BdQG6KsQoG+lphR0Jsmcn9WhX2t
UtFv19h/z5x3Cgz1WHwpbDTk2RxsrPyb3fhef+Ni857l/l0dK8jPAKglTb/kCDzF
acXKbjTpH5LluD2o9XN6aUYDuQcGFAuB7KlRYDVWRk5OD088r+YGwGJDx7oJq5F3
aTwfafMzsnel+uwb0RK9fs8ZSZqT991VuI7sQoZMc1CgUEJx8bNSQbn4xhG8+Q4K
8h7wqYIe8OmXj0lC6hqpBLZqG7kO9Xp9QB/v94vi6gRZl4gdrsnodB/+C5Xxy3Og
g/DpYwqvep/1h1BpfM9yhX3Y53mzhSYqKaDGCBhg1yfmEohtw5XrYJXDcOVLx4Hd
PUy3WRIx8sRsoACqZyd/cpGaBxUfT/ppsT51SSGYFo2tRQcPNs93wkjoZrf876Te
Uof/GBhiwJ2gBv+pSPlBZ5MFAePRfS5vK+0rooof2P/0q99ck5RZ1zWZbb9wBCPp
RglNE4JQjt+6chDA0eih
=8/YE
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--
