From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: AM3517 usb host issue
Date: Fri, 22 May 2015 08:50:39 -0500
Message-ID: <20150522135039.GA5582@saruman.tx.rr.com>
References: <555EE311.3030507@codethink.co.uk>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <555EE311.3030507-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Linux USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 22, 2015 at 11:04:33AM +0300, Ben Dooks wrote:
> I am trying to get the full-speed USB host working on an custom AM3517
> device with the 3.18.12 kernel. The hardware works (a 2.6.37 kernel has
> been used for testing).
>=20
> Does anyone have any experience of 3.18 (or similarly recent kernel on
> an AM3517 system) or have any pointers as where to start debugging? The
> ti-linux-3.14.y does not have any patches that aren't applied to the
> usb on 3.18.13.
>=20
> The cpu port 1 is connected by a TI TUSB1106 usb transceiver that is
> directly connected to a full-speed hub (TI USB2046) hub so the OHCI
> driver is the only one in use.
>=20
> Note, the ohci-omap3 is loaded as a module as this is how their user
> application expects to be able to shut down usb when it does not need
> it.
>=20
> The device tree configuration for the usb host:

and what exactly doesn't work ? That old OHCI driver hasn't been touched
in years, it's no surprise that it stopped working :-(

Anyway, what exactly doesn't work ? No device enumerates ? Do you get
any IRQs by plugging a new device in ?

> > &usbhshost {
> > 	status =3D "okay";	/* just in case it is started disabled */
> >=20
> > 	port1-mode =3D "ohci-phy-6pin-dpdm";
> > };
> >=20
> > &usbhsohci {
> > 	status =3D "okay";
> > };
> >=20
> > &usbhsehci {
> > 	status =3D "disabled";	/* no ehci on board */
> > };
>=20
>=20
> The usb from the logs is as follows. Some extra debugging has been
> added to verify the device-tree settings:
>=20
> > [    0.000000] AM3517 ES1.1 (l2cache sgx neon)                         =
       =20
> >=20
> > [    0.869706] usbcore: registered new interface driver usbfs          =
        =20
> > [    0.874270] usbcore: registered new interface driver hub            =
        =20
> > [    0.878592] usbcore: registered new device driver usb               =
        =20
> > [    1.223199] usbhs_tll 48062000.usbhstll: starting TI HSUSB TLL Contr=
oller   =20
> > [    1.273000] usbhs_omap 48064000.usbhshost: ports 0                  =
        =20
> > [    1.278291] usbhs_omap 48064000.usbhshost: port 0: ohci-phy-6pin-dpd=
m       =20
> > [    1.284476] usbhs_omap 48064000.usbhshost: port0-mode: ohci-phy-6pin=
-dpdm ->5
> > [    1.288689] usbhs_tll 48062000.usbhstll: omap_tll_init()            =
        =20
> > [    1.293628] usbhs_omap 48064000.usbhshost: usbhs_runtime_resume     =
        =20
> > [    1.298434] usbhs_omap 48064000.usbhshost: sysconfig 0x00001009     =
        =20
> > [    1.302730] usbhs_tll 48062000.usbhstll: omap_tll_enable()          =
        =20
> > [    1.307668] usbhs_omap 48064000.usbhshost: usbhs_runtime_suspend    =
        =20
> > [    1.310142] stopping usb controller                                 =
        =20
> > [    1.419910] usbhs_tll 48062000.usbhstll: omap_tll_disable()         =
        =20
> > [    1.423547] usbhs_omap 48064000.usbhshost: 3 ports                  =
        =20
> > [    1.429065] usbhs_omap 48064000.usbhshost: starting TI HSUSB Control=
ler     =20
> > [    1.433831] usbhs_omap 48064000.usbhshost: usbhs_runtime_resume     =
        =20
> > [    1.438625] usbhs_omap 48064000.usbhshost: sysconfig 0x00001009     =
        =20
> > [    1.442921] usbhs_tll 48062000.usbhstll: omap_tll_enable()          =
        =20
> > [    1.448548] usbhs_omap 48064000.usbhshost: omap_usbhs_rev1_hostconfi=
g =3D>    =20
> > [    1.455034] usbhs_omap 48064000.usbhshost: UHH setup done, uhh_hostc=
onfig=3D80d
> > [    1.459918] usbhs_omap 48064000.usbhshost: usbhs_runtime_suspend    =
        =20
> > [    1.462337] stopping usb controller                                 =
        =20
> > [    1.569905] usbhs_tll 48062000.usbhstll: omap_tll_disable()         =
        =20
> > [    1.575408] usbhs_omap 48064000.usbhshost: populating usb sub nodes.=
=2E..     =20
> >=20
> > [   77.609168] usbhs_omap 48064000.usbhshost: usbhs_runtime_resume     =
        =20
> > [   77.613927] usbhs_omap 48064000.usbhshost: sysconfig 0x00001009     =
        =20
> > [   77.618374] usbhs_tll 48062000.usbhstll: omap_tll_enable()          =
        =20
> > [   77.802694] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001   =20
> > [   77.816003] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber1
> > [   77.827391] usb usb1: Product: OHCI Host Controller                 =
        =20
> > [   77.838674] usb usb1: Manufacturer: Linux 3.18.13-00203-ga3c52be-dir=
ty ohci_d
> > [   77.849913] usb usb1: SerialNumber: 48064400.ohci                   =
        =20

OK, so this is roothub, what happens when a device is plugged to the
other end ? Is VBUS charged ? We didn't even enumerate TUSB2046, did you
look at its datasheet (http://www.ti.com/lit/ds/symlink/tusb2046b.pdf) ?
What is the state of RESETn pin ? Perhaps that's tied to a GPIO and the
old TI kernel toggles that ? Anything interesting from usbmon ?

cheers

--=20
balbi

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVXzQvAAoJEIaOsuA1yqRE2q8P/jCu4QJystabnXH59nraOfVh
fbeXwFcbR9LnY8iu7/kHVGbq53SxKYwNAnuTt9OXCbohAT+KWeZvUF8U2vSFcOqx
+SVrxs4LW6gm3LATfq3JY7nHQLZZ2SbS334fu3TvqXrIo/ZLenURR0w8U3iikHgx
YzQ6vFOpANUbA/F2vQxUQmpB7EyEbhH81u7Rd/3wHd1LHKaEsdPrER0gBFJur9HL
UumHYT4ReFDj5T12oMxkMRQZgLjfKM7yV8/MYL9dTCO9hyoxRh3wRyIeD1aeyMMh
mruq1ILTvPAZ/BkNmjWWzU6oLZUCR65oyCB7um/Pw1N3LiTTMLbj61EYBolziXZc
0+PQ4rbJDdGk8VO9d9So/5dy6mEcUtNm0BAXFSxuqdLOJ7Hzfkj/RHGSHqYbYw93
6Kk+ySjY5I6JhRc397HGWrK4zGqipbVF6wduwM5huU1kphsx+VjMCIdrrVD29Kbq
XYn+pxdspTNNwjlwQWxp/+kegMDN9pOL228C2pmAGfxrtoKHFj92FjG1peWZvx/c
ASs5OhIxwHnQ9lA0JsD73WiEc/uEfzJbFK0FEHcLeMTUNOxO1h7k2M+OEewsjylX
tD9SsNywe3Xuav5NDyzVZCuq65VxNf2UFDf9zJ8NYXAf0pjklBYhgiUhvBu/gF7j
UU8vn51r0gSkLp6ZWery
=GSBo
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
