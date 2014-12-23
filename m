From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Tue, 23 Dec 2014 10:19:36 -0600
Message-ID: <20141223161936.GA9147@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33048 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215AbaLWQUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Dec 2014 11:20:24 -0500
Content-Disposition: inline
In-Reply-To: <54991A25.2030804@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> Hi Felipe,
>=20
> On 12/22/14 20:05, Felipe Balbi wrote:
>=20
> [...]
>=20
> >  CONFIG_SCSI_SCAN_ASYNC=3Dy
> > -CONFIG_ATA=3Dy
> > -CONFIG_SATA_AHCI_PLATFORM=3Dy
> > -CONFIG_MD=3Dy
> > +CONFIG_ATA=3Dm
> > +CONFIG_SATA_AHCI_PLATFORM=3Dm
>=20
> Isn't this needed for the rootfs on SATA devices?

there's no known boards with rootfs on SATA. Until then, we can reduce
the size.

> >  CONFIG_NETDEVICES=3Dy
> >  # CONFIG_NET_VENDOR_ARC is not set
> >  # CONFIG_NET_CADENCE is not set
> > @@ -154,8 +151,8 @@ CONFIG_TI_CPSW=3Dy
> >  # CONFIG_NET_VENDOR_WIZNET is not set
> >  CONFIG_AT803X_PHY=3Dy
> >  CONFIG_SMSC_PHY=3Dy
> > -CONFIG_USB_USBNET=3Dy
> > -CONFIG_USB_NET_SMSC95XX=3Dy
> > +CONFIG_USB_USBNET=3Dm
> > +CONFIG_USB_NET_SMSC95XX=3Dm
>=20
> What about the NFS root for boards with only USB eth?

USB is a module already and it breaks PM when enabled.

> >  CONFIG_DEBUG_GPIO=3Dy
> >  CONFIG_GPIO_SYSFS=3Dy
> > -CONFIG_GPIO_TWL4030=3Dy
> > -CONFIG_W1=3Dy
> > +CONFIG_GPIO_TWL4030=3Dm
>=20
> w/o this devices wired to twl gpios will not come up and likely
> will miss the enumeration...

for example ?

> > -CONFIG_USB=3Dy
> > +CONFIG_HID_GENERIC=3Dm
> > +CONFIG_USB_HIDDEV=3Dy
> > +CONFIG_USB_KBD=3Dm
> > +CONFIG_USB_MOUSE=3Dm
> > +CONFIG_USB=3Dm
>=20
> So, you don't consider USB a valid rootfs storage option?

read the original defconfig. This is *only* for usbcore.ko, EHCI is
disabled, XHCI is a module, MUSB is disabled. What will you use for
rootfs ?

--=20
balbi

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmZYYAAoJEIaOsuA1yqREmMwP/AjhOWfTY5UrkYzyhtyl8s3O
C/47L4/RhA1DPWOstdfaEfxRpUuSprQpZCl8STGDQm7puz/+TgSbCDz5V0ILpz01
5tJklWQpRlvqENS6aWTHQuyxBShUXBTSKfW4u8HGedzWOxOqTJ/9+tdsBAXPo4nR
Lqs6z9urXk1BWfqZ/fDpTJZLStfaQ/zx1olULMlZeQZp9h/UihEnKW+DZqj7Da+y
4/HY0F0gwCEfTUUiDmwqdMVGml6RKLM3yuGnA8N9pdQMW4bowS7o+4OIXUb7sRZD
+77J0fMOSQzQ33gJglYYVzC3h+DW8Xqc9A5bPWvJKVoz7C58OxIvIwp4AUnVeaiR
R2rPTkR4DWUhyx0NV9/TMft6FWZCt1gx0pL0mo/5gxxnKkJmdRcznam0wnmtVmLH
7xTpeCxtr7XEUQeP7gslOvaRDDvuUeMWThAjF/uJPUtEGleSTUQBv8seLzjCBv6g
ZtjjnQCVadG47hFNazeHtkfpX8SptxAZkOv3ZbpmkpAxT/IeTyxKR03KzvO5BeKt
9zUie4qn8JWNKgdjmNYqI0j29nnM5nsfNRLFHORh7XBnqt/AyoTAuSwfJgfddilW
lwAifZf399e1jfqaTu6/oz4JsFBlyzckdkr6syphpQ5G50Tu2xn+y4qxeM6awBOE
+Mn6yWOhqcAY2cJA42Ls
=GSPg
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
