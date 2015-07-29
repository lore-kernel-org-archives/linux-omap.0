From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
Date: Wed, 29 Jul 2015 09:14:14 -0500
Message-ID: <20150729141414.GC28569@saruman.tx.rr.com>
References: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
 <20150723145532.GC21984@saruman.tx.rr.com>
 <20150723150844.GD21984@saruman.tx.rr.com>
 <SN1PR0301MB162948EF7089997EFE80CA22F38E0@SN1PR0301MB1629.namprd03.prod.outlook.com>
 <20150727150823.GB10703@saruman.tx.rr.com>
 <SN1PR0301MB16293B756B29E7352BB6A83CF38C0@SN1PR0301MB1629.namprd03.prod.outlook.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN1PR0301MB16293B756B29E7352BB6A83CF38C0@SN1PR0301MB1629.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Badola Nikhil <nikhil.badola@freescale.com>
Cc: "balbi@ti.com" <balbi@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2015 at 11:19:01AM +0000, Badola Nikhil wrote:
> > > > yet another problem is that this register doesn't exist in *all*
> > > > versions of DWC3. It was introduced in version 2.50a so the branch I
> > > > typed above needs one extra check, and since it's getting so large,
> > > > it deserves be factored out into its own function.
> > > >
> > > > static int dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj=
) {
> > > > 	u32 reg;
> > > > 	u32 dft;
> > > >
> > > > 	if (dwc->revision <=3D DWC3_REVISION_250A)
> > > > 		return 0;
> > > >
> > > > 	if (fladj =3D=3D 0)
> > > > 		return 0;
> > > >
> > > > 	reg =3D dwc3_readl(dwc->regs, DWC3_GFLADJ);
> > > > 	dft =3D reg & 0x3f; /* needs a mask macro */
> > > >
> > > > 	if (!dev_WARN_ONCE(dwc->dev, dft =3D=3D fladj,
> > > > 		"requested value same as default, ignoring\n")) {
> > > > 		reg &=3D ~0x3f; /* needs a mask macro */
> > > > 		reg |=3D DWC3_GFLADJ_30MHZ_SDBND_SEL |
> > > > 			DWC3_GFLADJ_30MHZ(fladj_value);
> > > >
> > > > 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
> > > > 	}
> > > > }
> > > >
> > > > you really *MUST* check this sort of this out when writing patches.
> > > > It's not only about *your* SoC. You gotta remember we have a ton of
> > > > different users and those a prone to major grumpyness should a
> > > > completely unrelated patch break their use case.
> > > >
> > > > You have access to the IP's documentation, and that contains the
> > > > entire history of the IP itself, so it's easy to figure all of this
> > > > out with a simple search in the documentation.
> > > >
> > > > One extra detail is that you were very careless when writing to the
> > > > GFLADJ register too. You simply wrote your 30MHz sideband value,
> > > > potentially clearing other bits which shouldn't be touched. That
> > > > alone can add regressions.
> > > >
> > > > When resending, make sure all 3 patches reach linux-usb. I still
> > > > can't find patch 3/3.
> > > >
> > >
> > > Will take care of above scenarios and resend patches cc'ing linux-usb
> > > in each of them.
> > >
> > > Regarding acceptance of the patch only when it's used in glue layer,
> > > there is no freescale's glue layer present for dwc3 as of now.
> >=20
> > if there is no glue layer, how are you testing your patch ?
>=20
> We directly call dwc3_probe() . Please see usb node in file
> arch/arm/boot/dts/ls1021a.dtsi For your reference :=20
>=20
> usb3@3100000 {
>                         compatible =3D "snps,dwc3";
>                         reg =3D <0x0 0x3100000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>                         dr_mode =3D "host";
>                 };

first time I see an SoC which needs nothing for its IP wrapper :-)
pretty cool.

> > > Furthermore, there is not any platform specific code required in glue
> > > layer apart from the ones present in dwc3/core.c.
> >=20
> > sorry ? core.c is generic for all users, the glue layer should somewhat=
 hide
> > platform details such as clocks and PM. It's surprising if you don't ne=
ed
> > anything on that side.
>=20
> We do not support power management for now. Also we are not sure If we
> need clocks and will look into it when we start working on power
> management.
> I would request you to accept this patch set (after modifications
> which you suggested) so that usb functionality doesn't break.
> I will send an incremental patch to use this frame length adjust patch
> via glue layer as soon as we introduce one.=20

sure, the only problem with that, is that if you end up adding a glue
layer, your old DTS sources will likely stop wotrking, but we'll get to
that when we get to that.

--=20
balbi

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuN+2AAoJEIaOsuA1yqREjs0QAI1C3KqBpoZtgbqEqXNPEwn4
HtRVmPIhkqN1ihuJhOKlrgQh8dtmAmmixFGDB8msYIwSMLU545obT+QJ5xO2vP3g
XIyFbUjBs3FckcnkaiZuPsrCv1xXCJmhgo0ZcRFfXlW0fbmIvIpd1j70jVztIHxL
KNWmQDX21WZHRiCf+WOpOkSaSF1oQ/RoBPmb8u+vWPG9S+tD6XLcJJwXn2N0pxCo
/kzXOvYuqoSUfZ42XelYnsieTUxpFea1/6G+SVfFNim6bpR35xlwyUhBgISpZKyZ
0arnD2U9+PLrPNxrStrpvcj3DxMfzgdzxDvH8jUvf5Mh2cATl9oK+3CfjxEqiUJU
CQEjCCa6PO4abuwcoJeA+Kdq8vx1IgTLNpMGY53ixCkDqRY3xjRoVGsafDjZPMM4
9yvSd48woUoN2Bz7hQd2TPJONfgGfa0n8YWwoCBbuNIHoJg7WkTCb3VY5gJZ5pCA
03Q3ny6maLwtHjRW3YunHbLwjqt1L9Y8pc3L3mFu0x6Gjn3meDEYJVGsWLhgSr4I
zt5shH9Q9SjdbP4x7AbRGkAWlveZSvXy8PQuD4crmibE6eICe+J0PPkaa7AyKJZI
v5Go5vcmE6jQnlW06f0/A9+IW92ekbN5ERcO+zmk+l9OxaPNev61aAHjd+v8jvwt
4Im3L+5K0lYozs7pnCF+
=cDTs
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
