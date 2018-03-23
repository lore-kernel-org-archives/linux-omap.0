From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Fri, 23 Mar 2018 11:54:55 +0100
Message-ID: <20180323105455.GB21644@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Do you have the related dts patches picked from next?
> > >=20
> > > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> > > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> > >=20
> > > But yeah all you need to do is have phy-mapphone-mdm6600 and
> > > ohci-platform loaded and then ifconfig should show four wwan
> > > interfaces being added.
> >=20
> > ifconfig? I thought I should get /dev/ttyUSB0..3?
>=20
> I believe they are QMI via qmi_wwan, not TTYs.

Well, qmicli expects device path... and I see nothing on ifconfig. Any
idea how the device would be named?

But I believe it just does not work, see the qcserial experiment with
new_id below.

Best regards,
								Pavel
							=09
> > But qcserial driver does not bind to that. If I attempt to force it:
> >=20
> > root@devuan:/sys/bus/usb-serial/drivers/qcserial# lsusb
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 002 Device 002: ID 22b8:2a70 Motorola PCS
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > root@devuan:/sys/bus/usb-serial/drivers/qcserial# echo "22b8 2a70" >
> > new_id
> > [ 2059.267730] usb 2-1: unknown number of interfaces: 9
> > [ 2059.272949] usb 2-1: unknown number of interfaces: 9
> > [ 2059.278045] usb 2-1: unknown number of interfaces: 9
> > [ 2059.283233] usb 2-1: unknown number of interfaces: 9
> > [ 2059.288330] usb 2-1: unknown number of interfaces: 9
> > [ 2059.293457] usb 2-1: unknown number of interfaces: 9
> > [ 2059.298553] usb 2-1: unknown number of interfaces: 9
> > [ 2059.303680] usb 2-1: unknown number of interfaces: 9
> > [ 2059.308776] usb 2-1: unknown number of interfaces: 9
> >=20
> > I don't get anything useful. Do I need to boot android before booting
> > Linux or something? How does your lsusb look like?
> >=20
> > Thanks,
> > 								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq03P8ACgkQMOfwapXb+vJcvgCeP0bx8pM7K9J2CNFCx3PPxeCK
P6YAni1zNMq2ONQ/mltLRMv+NGKNx80r
=hW6w
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
