From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM3517 usb host issue
Date: Fri, 22 May 2015 20:07:26 -0500
Message-ID: <20150523010726.GB18455@saruman.tx.rr.com>
References: <555EE311.3030507@codethink.co.uk>
 <20150522135039.GA5582@saruman.tx.rr.com>
 <555F8DE2.1050403@codethink.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbbEWBJl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 May 2015 21:09:41 -0400
Content-Disposition: inline
In-Reply-To: <555F8DE2.1050403@codethink.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: balbi@ti.com, Linux USB list <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 22, 2015 at 11:13:22PM +0300, Ben Dooks wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On 22/05/15 16:50, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Fri, May 22, 2015 at 11:04:33AM +0300, Ben Dooks wrote:
> >> I am trying to get the full-speed USB host working on an custom
> >> AM3517 device with the 3.18.12 kernel. The hardware works (a
> >> 2.6.37 kernel has been used for testing).
> >>=20
> >> Does anyone have any experience of 3.18 (or similarly recent
> >> kernel on an AM3517 system) or have any pointers as where to
> >> start debugging? The ti-linux-3.14.y does not have any patches
> >> that aren't applied to the usb on 3.18.13.
> >>=20
> >> The cpu port 1 is connected by a TI TUSB1106 usb transceiver that
> >> is directly connected to a full-speed hub (TI USB2046) hub so the
> >> OHCI driver is the only one in use.
> >>=20
> >> Note, the ohci-omap3 is loaded as a module as this is how their
> >> user application expects to be able to shut down usb when it does
> >> not need it.
> >>=20
> >> The device tree configuration for the usb host:
> >=20
> > and what exactly doesn't work ? That old OHCI driver hasn't been
> > touched in years, it's no surprise that it stopped working :-(
> >=20
> > Anyway, what exactly doesn't work ? No device enumerates ? Do you
> > get any IRQs by plugging a new device in ?
>=20
> I will check the interrupts when I get back into the office.
>=20
> There is only one device (the hub) which isn't enumerating and is
> hard-wired on the board.

alright, that makes things a little more difficult :-)

> >>> &usbhshost { status =3D "okay";	/* just in case it is started
> >>> disabled */
> >>>=20
> >>> port1-mode =3D "ohci-phy-6pin-dpdm"; };
> >>>=20
> >>> &usbhsohci { status =3D "okay"; };
> >>>=20
> >>> &usbhsehci { status =3D "disabled";	/* no ehci on board */ };
> >>=20
> >>=20
> >> The usb from the logs is as follows. Some extra debugging has
> >> been added to verify the device-tree settings:
> >>=20
> >>> [    0.000000] AM3517 ES1.1 (l2cache sgx neon)
> >>>=20
> >>>=20
> >>> [    0.869706] usbcore: registered new interface driver usbfs
> >>>  [    0.874270] usbcore: registered new interface driver hub
> >>>  [    0.878592] usbcore: registered new device driver usb
> >>>  [    1.223199] usbhs_tll 48062000.usbhstll: starting TI HSUSB
> >>> TLL Controller [    1.273000] usbhs_omap 48064000.usbhshost:
> >>> ports 0 [    1.278291] usbhs_omap 48064000.usbhshost: port 0:
> >>> ohci-phy-6pin-dpdm [    1.284476] usbhs_omap
> >>> 48064000.usbhshost: port0-mode: ohci-phy-6pin-dpdm ->5 [
> >>> 1.288689] usbhs_tll 48062000.usbhstll: omap_tll_init()
> >>>  [    1.293628] usbhs_omap 48064000.usbhshost:
> >>> usbhs_runtime_resume [    1.298434] usbhs_omap
> >>> 48064000.usbhshost: sysconfig 0x00001009 [    1.302730]
> >>> usbhs_tll 48062000.usbhstll: omap_tll_enable()
> >>>  [    1.307668] usbhs_omap 48064000.usbhshost:
> >>> usbhs_runtime_suspend [    1.310142] stopping usb controller
> >>>  [    1.419910] usbhs_tll 48062000.usbhstll: omap_tll_disable()
> >>>  [    1.423547] usbhs_omap 48064000.usbhshost: 3 ports
> >>>  [    1.429065] usbhs_omap 48064000.usbhshost: starting TI
> >>> HSUSB Controller [    1.433831] usbhs_omap 48064000.usbhshost:
> >>> usbhs_runtime_resume [    1.438625] usbhs_omap
> >>> 48064000.usbhshost: sysconfig 0x00001009 [    1.442921]
> >>> usbhs_tll 48062000.usbhstll: omap_tll_enable()
> >>>  [    1.448548] usbhs_omap 48064000.usbhshost:
> >>> omap_usbhs_rev1_hostconfig =3D> [    1.455034] usbhs_omap
> >>> 48064000.usbhshost: UHH setup done, uhh_hostconfig=3D80d [
> >>> 1.459918] usbhs_omap 48064000.usbhshost: usbhs_runtime_suspend
> >>>  [    1.462337] stopping usb controller
> >>>  [    1.569905] usbhs_tll 48062000.usbhstll: omap_tll_disable()
> >>>  [    1.575408] usbhs_omap 48064000.usbhshost: populating usb
> >>> sub nodes....
> >>>=20
> >>> [   77.609168] usbhs_omap 48064000.usbhshost:
> >>> usbhs_runtime_resume [   77.613927] usbhs_omap
> >>> 48064000.usbhshost: sysconfig 0x00001009 [   77.618374]
> >>> usbhs_tll 48062000.usbhstll: omap_tll_enable()
> >>>  [   77.802694] usb usb1: New USB device found, idVendor=3D1d6b,
> >>> idProduct=3D0001 [   77.816003] usb usb1: New USB device strings:
> >>> Mfr=3D3, Product=3D2, SerialNumber1 [   77.827391] usb usb1:
> >>> Product: OHCI Host Controller [   77.838674] usb usb1:
> >>> Manufacturer: Linux 3.18.13-00203-ga3c52be-dirty ohci_d [
> >>> 77.849913] usb usb1: SerialNumber: 48064400.ohci
> >>>=20
> >=20
> > OK, so this is roothub, what happens when a device is plugged to
> > the other end ? Is VBUS charged ? We didn't even enumerate
> > TUSB2046, did you look at its datasheet
> > (http://www.ti.com/lit/ds/symlink/tusb2046b.pdf) ? What is the
> > state of RESETn pin ? Perhaps that's tied to a GPIO and the old TI
> > kernel toggles that ? Anything interesting from usbmon ?
>=20
> I've gone through the schematics and verified the hub's reset line
> is connected where we think it is (will try and check with a 'scope
> on monday that it is being taken high, the boot-loader starts it low).
>=20
> The root has just the one device connected, and unfortunately the
> hw designer decided to hard-wire the D+ pull-up to 3.3V instead
> of the transceiver's pull pin.
>=20
> Not tried usbmon yet. However if the hub is not being detected then
> probably won't show anything either.
>=20
> I am going to install devmem2 into the root image and use it to poke
> around and see the state of the system at run time.
>=20
> Thanks for looking in to this.

yeah, no problem. You probably want to first make sure VBUS is alive
behind the HUB (iow, make sure the hub is powered up as you'd expect),
then make sure VBUS is coming out on the other end (the hub's ports).
The make sure RESETn is high as you'd want it to be. After that, then I
guess only register pick-and-poke is left.

cheers

--=20
balbi

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVX9LOAAoJEIaOsuA1yqREfiwP/izC/jKK6FdvyICHswglBSDX
OR07T9GGIpRS05ioj3STZ1yMjwZQkBExHLKSVCcsbcoghNY2sXcKkwBdmzTYXE0J
KwiiA+fMPPwnKOzw0nMr8xVkYmDkoqkeOKkhP5H4TfqpBt0UiGldGEu3jmwR+smP
JJIiJwqR+O8pfeXG4E/IdplML6NUkv2Rd7U3D9V1SquX8emTn04HuBX8pbXlozR1
CoLBTyrnxvwUnlXMCZQczmFn/9TC1W98ZdodpsN7HnYJl6SP6pRKxI0ssLhbf2cT
6fQ9zUFnRRFKs4/6EAj6kxkVXjnUHCM8TiBujTVlH32g/A/IFBvs0icKPgfzTKq7
SHJ4QXlAHie7gleWkDLEmpC+QKXyYkRpqdjY8oyfimwCIEXojgDSO3qJIdMggb+4
HL8gAliLNxXN17V/l4He+7reFyZ9ypxPEi5q3tcUokfFvRYmGhJ6JR9Q2Fa9x90L
BbyQXOfSq/r+SedGHObWT/jL3/EF9dMZXe7oDzJTdkIBxI0/oW0brAeFs6AlFyf+
GtJ2uJnKNeHcK7IZcEw5v1SLnhxvRbh25E7RYk2pJWoxBTA7eUc4TxfGl2kd+qEL
HvGZUJA3aaZO66GQB0PMZ954Jn2MIvT6kTEb+JWXkkkFT9O/Hhov2WKQ6BRCdZ0i
ALF+5jZqalvOOXzxiaUa
=KxhX
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
