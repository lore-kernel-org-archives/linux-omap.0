From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO
Date: Tue, 24 Mar 2015 12:09:35 -0500
Message-ID: <20150324170935.GC24168@saruman.tx.rr.com>
References: <1427192359-19168-1-git-send-email-rogerq@ti.com>
 <20150324142647.GA9145@kahuna>
 <20150324164422.GG31024@saruman.tx.rr.com>
 <20150324165754.GA24734@kahuna>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51657 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbbCXRK1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 13:10:27 -0400
Content-Disposition: inline
In-Reply-To: <20150324165754.GA24734@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 11:57:54AM -0500, Nishanth Menon wrote:
> On 11:44-20150324, Felipe Balbi wrote:
> > On Tue, Mar 24, 2015 at 09:26:48AM -0500, Nishanth Menon wrote:
> > > On 12:19-20150324, Roger Quadros wrote:
> > > > We need to enable EXTCON_USB_GPIO_USB and not
> > > > EXTCON_GPIO_USB.
> > > >=20
> > > > Fixes: c08a54c0ebeb ("ARM: omap2plus_defconfig: Enable EXTCON_GPIO_=
USB")
> > > >=20
> > > > Reported-by: Nishant Menon <nm@ti.com>
> > > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > > ---
> > > >  arch/arm/configs/omap2plus_defconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/config=
s/omap2plus_defconfig
> > > > index 04b4c8e..daf9412 100644
> > > > --- a/arch/arm/configs/omap2plus_defconfig
> > > > +++ b/arch/arm/configs/omap2plus_defconfig
> > > > @@ -391,7 +391,7 @@ CONFIG_TI_EDMA=3Dy
> > > >  CONFIG_DMA_OMAP=3Dy
> > > >  # CONFIG_IOMMU_SUPPORT is not set
> > > >  CONFIG_EXTCON=3Dm
> > > > -CONFIG_EXTCON_GPIO=3Dm
> > > > +CONFIG_EXTCON_USB_GPIO=3Dm
> > > >  CONFIG_EXTCON_PALMAS=3Dm
> > > >  CONFIG_TI_EMIF=3Dm
> > > >  CONFIG_PWM=3Dy
> > > > --=20
> > > > 2.1.0
> > >=20
> > > Yep and it finally works! Yipiee!!
> > > http://pastebin.ubuntu.com/10669565/
> >=20
> > I don't see the peripheral side IRQ in /proc/interrupts. What's going
> > on? Can you load g_zero or g_mass_storage and verify peripheral side
> > also works ?
> my board is remote atm and does not have the usb peripheral cable hooked =
in.
> However, I did load g_zero and looks like 73 is registered.

thanks, that should be enough :-)

Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEZpOAAoJEIaOsuA1yqRETZkP+wd8O1FJRNWt8BaeNN4coY1n
2dKfpzML75r0BkJ8x51j4n1nqQvQwT+EN3H8EUzs2fVs6YyqEHHtMjXT9S7HNa9+
HCmAYASpALFGk1FgvcsYeubBtSpZsPw6Rzr1JmDAwlvW6n3SU/iubx1eJiYQP3CE
k96FBDif3Epc2D1TvnYpMMFryej72/AGGIwrpCnfFQfqHQ/lqAlXcwk+MRNkx5e5
BWha2LDxmamYMKn5ZKtNew2kUSFdD5ZfGfD/7rJjkeUvt0WSAshBPyRj+ouPEvtU
F2bvfJabnpvvRdUrlH9rbbR3Ie/ywm+HEPo2aFKLn4UqkDChqx+CYECkzh0CGZc3
vO9SVLuX77t0cCthIIGqNaNH5B+NC85zB7tjImGjlWrYDvgww0hnZ7KTzVM1aV6h
cY9ij/bTpxy3pkK9fEoixIf+0M4yl+n11jsZGODOzjeei2kUS2qRG7SjWCjk2VpW
idGJtTkgaHSSCOSSCAhpxXSrVMJZphOf0Bae7HFcHInjOlO6bhXgVBDcN0oOaXnB
ijTVIijODdJVcZ/9VTYwO1/IP7Yggs4XCxgYo3YJ2NnWHOULdb+DKrvngN26ckU4
Ti0a4bFe35kAQAxBkJ4KnYT7iCaqzJbDoY6nmGeU/lLp+PpMyaSMZ68SelYk75L7
nC6nvVbikTaktZRq0IR6
=ICcc
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
