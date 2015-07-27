From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
Date: Mon, 27 Jul 2015 10:08:23 -0500
Message-ID: <20150727150823.GB10703@saruman.tx.rr.com>
References: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
 <20150723145532.GC21984@saruman.tx.rr.com>
 <20150723150844.GD21984@saruman.tx.rr.com>
 <SN1PR0301MB162948EF7089997EFE80CA22F38E0@SN1PR0301MB1629.namprd03.prod.outlook.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN1PR0301MB162948EF7089997EFE80CA22F38E0@SN1PR0301MB1629.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Badola Nikhil <nikhil.badola@freescale.com>
Cc: "balbi@ti.com" <balbi@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 06:56:48AM +0000, Badola Nikhil wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: Thursday, July 23, 2015 8:39 PM
> > To: Felipe Balbi
> > Cc: Badola Nikhil-B46172; linux-kernel@vger.kernel.org; linux-
> > usb@vger.kernel.org; linux-omap@vger.kernel.org;
> > gregkh@linuxfoundation.org
> > Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_qu=
irk
> >=20
> > Hi again,
> >=20
> > On Thu, Jul 23, 2015 at 09:55:32AM -0500, Felipe Balbi wrote:
> > > > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
> > > > 0447788..b7a5119 100644
> > > > --- a/drivers/usb/dwc3/core.h
> > > > +++ b/drivers/usb/dwc3/core.h
> > > > @@ -124,6 +124,7 @@
> > > >  #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
> > > >
> > > >  #define DWC3_GHWPARAMS8		0xc600
> > > > +#define DWC3_GFLADJ		0xc630
> > > >
> > > >  /* Device Registers */
> > > >  #define DWC3_DCFG		0xc700
> > > > @@ -234,6 +235,10 @@
> > > >  /* Global HWPARAMS6 Register */
> > > >  #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
> > > >
> > > > +/* Global Frame Length Adjustment Register */
> > > > +#define GFLADJ_30MHZ_REG_SEL		(1 << 7)
> > >
> > > always prepend with DWC3_ like *all* other macros in this file.
> > >
> > > Also, match docs to ease grepping. This should be called
> > > DWC3_GFLADJ_30MHZ_SDBND_SEL
>=20
> GFLADJ_30MHZ_REG_SEL is the field's name in LS1021A Reference Manual
> as well as dwc3 databook. Though DWC3_GFLADJ_30MHZ_SDBND_SEL seems
> more relevant.=20

databook calls it GFLADJ_30MHZ_SDBND_SEL, I checked before sending my
email.

> > yet another problem is that this register doesn't exist in *all* versio=
ns of
> > DWC3. It was introduced in version 2.50a so the branch I typed above ne=
eds
> > one extra check, and since it's getting so large, it deserves be factor=
ed out
> > into its own function.
> >=20
> > static int dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj) {
> > 	u32 reg;
> > 	u32 dft;
> >=20
> > 	if (dwc->revision <=3D DWC3_REVISION_250A)
> > 		return 0;
> >=20
> > 	if (fladj =3D=3D 0)
> > 		return 0;
> >=20
> > 	reg =3D dwc3_readl(dwc->regs, DWC3_GFLADJ);
> > 	dft =3D reg & 0x3f; /* needs a mask macro */
> >=20
> > 	if (!dev_WARN_ONCE(dwc->dev, dft =3D=3D fladj,
> > 		"requested value same as default, ignoring\n")) {
> > 		reg &=3D ~0x3f; /* needs a mask macro */
> > 		reg |=3D DWC3_GFLADJ_30MHZ_SDBND_SEL |
> > 			DWC3_GFLADJ_30MHZ(fladj_value);
> >=20
> > 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
> > 	}
> > }
> >=20
> > you really *MUST* check this sort of this out when writing patches. It'=
s not
> > only about *your* SoC. You gotta remember we have a ton of different
> > users and those a prone to major grumpyness should a completely unrelat=
ed
> > patch break their use case.
> >=20
> > You have access to the IP's documentation, and that contains the entire
> > history of the IP itself, so it's easy to figure all of this out with a=
 simple search
> > in the documentation.
> >=20
> > One extra detail is that you were very careless when writing to the GFL=
ADJ
> > register too. You simply wrote your 30MHz sideband value, potentially
> > clearing other bits which shouldn't be touched. That alone can add
> > regressions.
> >=20
> > When resending, make sure all 3 patches reach linux-usb. I still can't =
find
> > patch 3/3.
> >
>=20
> Will take care of above scenarios and resend patches cc'ing linux-usb
> in each of them.
>=20
> Regarding acceptance of the patch only when it's used in glue layer,
> there is no freescale's glue layer present for dwc3 as of now.

if there is no glue layer, how are you testing your patch ?

> Furthermore, there is not any platform specific code required in glue
> layer apart from the ones present in dwc3/core.c.=20

sorry ? core.c is generic for all users, the glue layer should somewhat
hide platform details such as clocks and PM. It's surprising if you
don't need anything on that side.

--=20
balbi

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtklnAAoJEIaOsuA1yqREqAEP/2FI6WDDNqg9Hrart5jBxuDe
U3FuvYcuxjKUcIeETMgbwQuqUh6AIL57/GxmQOVev88kFVN9tXvZbpgEIzIJlvuX
cC3LMXvU5ehWNWuLzR6IXmRYC/XtodqMg5EKxwF4x9kfuhLv9j0MD5UthZ9F+gv+
sQb0G9pxOb+5S98AevFHpoVvnMzIxk3rKdW6UMP67K4FTqLTstO9guz1ZerwQF28
+es5expcRtnOk7MvmyDEpY9ITfY/iQCz9TV/PbOZNjfdj3gF61Y5pXT4zQRr2p9H
GUhSoP02b14aVm/E/nx2VxNhTt5B0UPchlxcjHr53F/fhXHC+fPJroD07i/mPyjC
kGdbMuopFOK6ygtOvAqYK2tO1Xy0NVfYoaS9ZEY1ImLNccPnd9BqUbkwaVKts+50
NFf8MhcXVPuyYkIGAy7prxS0JgtTsm+0pNbKu8HcEJ6R4LmGs8R1QIO7lxMPw54r
PR6GJgj1nbeBo2OZtcN8aN0+jOXQNSBTvtWYfXlbb4knvx0NTR3gedKQZ/k5UEWF
lY90zlXM/cRKU1zepAJM+h4OfgC4WLhz0Blvkz8QMnAlU7EVPfJEi/Gc97hriA+r
gLR0CdYPMDGs29IxIPe/JBRQYIQoW5VerNJDovNIvUNtACz0EmzlS3R1rOx7BeNx
CDR3YhY9Yabp+crh5f6x
=8J7g
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
