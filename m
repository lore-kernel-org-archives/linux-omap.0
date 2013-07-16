From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 0/4] usb: musb: fix USB enumeration issue in OMAP3
 platform
Date: Tue, 16 Jul 2013 15:42:27 +0300
Message-ID: <20130716124227.GC15036@arwen.pp.htv.fi>
References: <1373282057-20181-1-git-send-email-kishon@ti.com>
 <51E4DFA6.2010501@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51E4DFA6.2010501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2013 at 11:22:38AM +0530, Kishon Vijay Abraham I wrote:
> Tony,
>=20
> On Monday 08 July 2013 04:44 PM, Kishon Vijay Abraham I wrote:
> > This series fixes the USB enumeration issue caused because of the contr=
oller
> > not able to get a reference to the PHY because of incorrect binding in =
the
> > board file.
> >=20
> > In the case of non-dt boot, the platform specific initialization file
> > (board file) will do usb_bind_phy that binds the usb controller with the
> > PHY using device names. After the device names are created using=20
> > PLATFORM_DEVID_AUTO, our original method of binding by device names doe=
sn't
> > work reliably (since the device name changes). Hence the usb controller
> > is made to use labels for getting the PHY.
> >=20
> > Here the PHY name is added in the plat data of USB controller device wh=
ich
> > should be used by the controller driver to get the PHY.
> > Two new APIs usb_get_phy_by_name and devm_usb_get_phy_by_name are added=
 to
> > be used by the controller to get the PHY by name.
>=20
> You haven't picked this patch series?

yeah and now it's too much to send during the -rc series. Here's what we
can do, we can to minimum fix for -rc series (patching the names again)
and I'll queue everything else for mailine if tony gives me his Ack for
all arch/arm/*omap* parts.

Sounds good ?

--=20
balbi

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5T+zAAoJEIaOsuA1yqRENlwQAKZVjHuUEJckzVW+WpFwGk8O
2WkF6ctrAFUT6wBFcHV/5IJXhGujzV8C8MslouATf4Ro110dXPOArbk/rMs0eaVv
PwRZ+UrvGZNThoCFIHqa3QtvlcQoDgQMRDVafK+yVC6LAZxvzOcr836uqsVenq7Q
TGyPS8hK85YThd3qOLj+vQLRiBmF170+H5XMQ8x0KEo95azq7UN5z4ZQmmHlnD5n
V3ITfnSU8MK8jSJI9DoWvcVY1R0tyVGaJr1TujxqEM1OruW3W4GGg47+i+T5nQwj
7I34eJcWWcVHvwmMTCDPjKHCgyquWxAccKMdj9+f0aDvzRfPKks9KIKaFEszLwGU
5gNammm7VFIMifhSNJDa3Sf9SQ6n/A39NGvaX1zGQg8RiRiiiijeP3xoWZ05ruuR
l8TsmqtIdSA8EN1MyRePcpMbh0/5DOCrYqk924I73lxzqCB5SD6oljvtdqNbIPGo
VWtHmNVT9hq8Gk/8LavEaC8BaotL0MEugiaTWLhse5mvdIsU44JbIe3LTRFj81OU
Zce06LKjnupEvblpFQ0taSutG7PLxTfM9ZW+pmEuY5o7dsaw4dDw/qUJTTZ53IeX
e30JIcrghBiQiTX6El0HNK0P6HWFSr+yNcJ6m+EYTMQQsj1FO/K3D7S2018SMFio
Fno27qI3H7h52QAxQp4+
=yyhA
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
