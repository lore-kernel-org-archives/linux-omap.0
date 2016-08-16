From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 3/7] dt: bindings: Add nokia-bluetooth
Date: Wed, 17 Aug 2016 01:28:55 +0200
Message-ID: <20160816232855.qgempm64zgp36ufd@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-4-git-send-email-sre@kernel.org>
 <20160816135155.GA20948@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqolknfnakynch3i"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816135155.GA20948@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--gqolknfnakynch3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Aug 16, 2016 at 08:51:55AM -0500, Rob Herring wrote:
> On Sat, Aug 13, 2016 at 05:14:34AM +0200, Sebastian Reichel wrote:
> > ---
> >  .../devicetree/bindings/net/nokia-bluetooth.txt    | 43 ++++++++++++++=
++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetoo=
th.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt =
b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> > new file mode 100644
> > index 000000000000..a0fceabb4cce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> > @@ -0,0 +1,43 @@
> > +Nokia bluetooth UART devices
> > +------
> > +
> > +Some vendors have custom versions of their chips, that can be found in=
 Nokia
> > +devices. These chips are controlled differently, than the non-Nokia ve=
rsion,
> > +so a different binding is required. All chips listed here implement th=
e Nokia
> > +H4+ protocol.
> > +
> > +Required properties:
> > +
> > +  - compatible: should be one of the following:
> > +	* "nokia,brcm,bcm2048"
> > +	* "nokia,ti,wl1271-bluetooth"
>=20
> Perhaps these should be 2 separate strings. Something like=20
> '"nokia,n900-bt", "brcm,bcm2048"'. However, if they are in no way=20
> compatible with the default version from the vendors, then just a single=
=20
> string is fine, but it doesn't need to be aligned to the vendor=20
> compatible string. So just "nokia,n900-bcm2048" or similar is fine.

The default bcm2048 variant uses different initialization process
and does not use word alignment as far as I know. I think having
"brcm,bcm2048" in the compatible string is wrong.

I guess "brcm,bcm2048-nokia" would also be an option, since the
chip has been built buy broadcom, but it has a custom Nokia
interface.

> > +  - reset-gpios:		Should specify the gpio for bluetooth reset
> > +  - host-wakeup-gpios:		Should specify the gpio for host wakeup
>=20
> Should be interrupt instead?

Yes this is mostly an interrupt, but I need to read the current
line state.

> > +  - bluetooth-wakeup-gpios:	Should specify the gpio for bluetooth wake=
up
>=20
> State direction and active state for gpios.

ok.

> > +  - clock-names:		Should be "sysclk"
> > +  - clocks:			Should contain a clock phandle for system clock
> > +
> > +Example:
> > +
> > +/ {
> > +	/* controlled (enabled/disabled) directly by wl1271 */
> > +	vctcxo: vctcxo {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <38400000>;
> > +	};
> > +};
> > +
> > +&uart2 {
>=20
> I want to see a common serial device binding doc before accepting any=20
> device bindings. It's not going to say much initially other than devices=
=20
> are child nodes of uarts. Perhaps something on baudrate settings.

Neil added a short sentence about this in "[RFC 2/7] tty: add
support for "tty slave" devices". I just took the unmodified patch
=66rom Neil (*), so it's not in its own patch.

> > +	bluetooth {
> > +		compatible =3D "nokia,ti,wl1271-bluetooth";
> > +
> > +		reset-gpios =3D <&gpio1 26 GPIO_ACTIVE_HIGH>; /* 26 */
> > +		host-wakeup-gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
> > +		bluetooth-wakeup-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
> > +
> > +		clocks =3D <&vctcxo>;
> > +		clock-names =3D "sysclk";
> > +	};
> > +
> > +};

-- Sebastian

--gqolknfnakynch3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXs6G0AAoJENju1/PIO/qaBjgP/3NyQR71NcKE8H7e5PalXd5P
eC4y9TDx92CP3bQK5sHt1LBrt5v5R3oi7ddUB5tQNi6w431CZlaDUf22SlqhWap3
sZUhHCMJS1ulTtaNMDY2egxtB9YDlYc5iudZaFIzidbiMno0go1E3YPlNVY/HSYC
rmqcvQhEEx9CqntQEaVPb+cEQFaMPYYQ7AuQWg4kK8lYcZ0UesHDeu9Je1OO10wn
OiHPho5zBcnc7Yut+1uDq0AUCGOAjIPsxQsdvZQy3K5VHZ+zE/lPGAT8wikq9tF1
jc75ZnlIPrt+yd3kShCPXH0qfLBDvwJ9xWaimYeGOQWwRJl4BbQn5jzz1yIsZF7w
Cyn0lwM4xN/OYGsHQz2aY0+f6cw6d9qgut3Ky7Z/0nbmw+TwDL/WuA9a0SB8aD4g
RZnaYMczXwGCsWqE7rrQ9z5PLl+X2BVezOBravQf80m+Eh1KEFoyFX8X+GQyHVNh
/cA3FZDSkdcnyoo8ASy9+M+gb0m/QeuMo60GbsTIe5f/CjfTAlcLMLzpKWTeZLhK
6bGooSx7THMv7MRW3fbV6Wzj3AUYyZzqj64hes6mWmyNuUdqClKmBZFj1tr3kTc2
76OXDXUluZXTQz5go1MmkyoQo0yNRDTMzvG2kObCWFzP9Zsv2RO9F5U4ug/wfQgi
GayHKqcsj8A/Fbusa3ey
=6SXu
-----END PGP SIGNATURE-----

--gqolknfnakynch3i--
