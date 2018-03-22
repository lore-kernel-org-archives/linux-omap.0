From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Thu, 22 Mar 2018 09:46:33 -0700
Message-ID: <20180322164633.GF5799@atomide.com>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322135553.GA27648@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Pavel Machek <pavel@ucw.cz> [180322 13:57]:
> Hi!
>=20
> > idle lcd off	phy-mapphone-mdm6600	ohci-platform
> > 153mW		284mW			344mW
> >=20
> > So it seems that MDM6600 is currently not yet idling even with it's
> > radio turned off, but that's something that is beyond the control of
> > this USB PHY driver. This patch does get us to the point where modem
> > data and GPS are usable with libqmi and ModemManager for example.
> > Voice calls need more audio driver work.
>=20
> Ok, let me try. I believe I should see the modem device on lsusb, but
> I don't.
>=20
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> sudo lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> zcat /proc/config.gz | grep MAPPH
> CONFIG_PHY_MAPPHONE_MDM6600=3Dy
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
> zcat /proc/config.gz | grep OHCI_
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_OMAP3=3Dy
> CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
>=20
> As far as I can tell,
>=20
> +CONFIG_USB_WDM=3Dy
> +CONFIG_USB_SERIAL=3Dy
> +CONFIG_USB_SERIAL_QUALCOMM=3Dy
> +CONFIG_USB_SERIAL_WWAN=3Dy
>=20
> should be enabled to enable the drivers (and I did that), but without
> device showing on the bus...
>=20
> Any ideas?

Do you have the related dts patches picked from next?

fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")

But yeah all you need to do is have phy-mapphone-mdm6600 and
ohci-platform loaded and then ifconfig should show four wwan
interfaces being added.

Regards,

Tony


--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkgNvrZJU/QSQYIcQG9Q+yVyrpXMFAlqz3ekACgkQG9Q+yVyr
pXMyYg/9GEq0/SBSu5yR5kx1UrhkK5c/fyL9li145JlFob6VY2wEpBWSUqU3Mr/C
D1pB+3H11j30Q9HwsHAK0GWKznYQUlf50sc9NZjuldfgqbp27q2LLq9VeNA+RpnE
6zTjPSVV9iG11eYWJAR1NsajFBjgxnCleI8KFLuZE/BSKk0EwpyVqdc6fFLJ6Ap9
0F/dkhb6OJzo1ElfPKlLK4gjmxa1OIS0086WlKvxtLrhVWhjEJrxBPNicDiD8FyZ
HYbhC6aBbmwpzqWJKZbUVBjtbNAXMD+gfPGhzxq2aflHa/Ey26Wj0ITfyjCaCHZY
Nz7SwgUVxpLzrpmmRAA/sSnId/vshobYs8Uki+QJpbbkxhyDmjZpZpJc6i4b85EU
VTQ0B6Hz8efURW1LwQsk7J/TYrZqVlUIOBOyHzUUa4p996Epjs88ynXwJ1pXspem
v8vwlFtRnzaEsMw29YppxQ/GxPMa1NkIHS/uDH04ZP5napXMMWek9GVqv2EmXjXC
E8hwFPZ+Es1YsrzlH4+Va0x60DoL8uUadLIn8QQDyB3juxHbItW56rt5e5EQYCOb
N18kfURYLfBzwCcLvKYT4YCs+xt9C3T0QuVU+6HkMpFO5VgrQipxiJeBcJasAve4
h7PYWp+NTt6bI10RftBLQtm5fncWnlp5Hj5xsvbPAm88kzc61z0=
=uw8G
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
