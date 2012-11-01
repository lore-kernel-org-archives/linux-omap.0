From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND PATCH 05/11] ARM: OMAP: USB: Host: usb host Device tree
 node Adaptation
Date: Thu, 1 Nov 2012 12:21:04 +0200
Message-ID: <20121101102104.GB410@arwen.pp.htv.fi>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
 <1351693612-23314-6-git-send-email-keshava_mgowda@ti.com>
 <20121031182903.GN12739@atomide.com>
 <A5063B091B3D3440AC5162AF1265EB00F724DD@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A5063B091B3D3440AC5162AF1265EB00F724DD@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2012 at 09:19:48AM +0100, Munegowda, Keshava wrote:
>=20
> ________________________________________
> From: Tony Lindgren [tony@atomide.com]
> Sent: Wednesday, October 31, 2012 11:59 PM
> To: Munegowda, Keshava
> Cc: linux-omap@vger.kernel.org; devicetree-discuss@lists.ozlabs.org; linu=
x-doc@vger.kernel.org; linux-usb@vger.kernel.org; Balbi, Felipe; sameo@linu=
x.intel.com; Cousson, Benoit
> Subject: Re: [RESEND PATCH 05/11] ARM: OMAP: USB: Host: usb host Device t=
ree node Adaptation
>=20
> * Keshava Munegowda <keshava_mgowda@ti.com> [121031 07:29]:
> > The USB2 Host device node is extracted and used in the probe
> > of the driver to initialize the usb ports and controller. The
> > platform specific initialization is also performed.
> >
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> > ---
> >  arch/arm/mach-omap2/usb-host.c         |    2 -
> >  drivers/mfd/omap-usb-host.c            |  163 +++++++++++++++++++++++-=
--------
> >  include/linux/platform_data/usb-omap.h |   19 +++-
> >  3 files changed, 133 insertions(+), 51 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-h=
ost.c
> > index d1dbe12..239c175 100644
> > --- a/arch/arm/mach-omap2/usb-host.c
> > +++ b/arch/arm/mach-omap2/usb-host.c
> > @@ -502,8 +502,6 @@ void __init usbhs_init(const struct usbhs_omap_boar=
d_data *pdata)
> >       }
> >       ehci_data.phy_reset =3D pdata->phy_reset;
> >       ohci_data.es2_compatibility =3D pdata->es2_compatibility;
> > -     usbhs_data.ehci_data =3D &ehci_data;
> > -     usbhs_data.ohci_data =3D &ohci_data;
> >
> >       if (cpu_is_omap34xx()) {
> >               setup_ehci_io_mux(pdata->port_mode);
>=20
> Just checking.. Have you tested that these patches also
> still work without device tree?
>=20
> Regards,
>=20
> Tony
>=20
>=20
> No ! with out device tree enabled , these patches does not work.
> do I need to make a code such way that it works with and without
> device tree..?

yes. OMAP3/4 still have lots of legacy platform_data-only board support
;-)

--=20
balbi

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkk0QAAoJEIaOsuA1yqRE270QAIvA3qpyNwsLTdhrD/TLERE4
iGEwNIzYWuoC/3UO3IoyATe8CbfINLFcI0LGFSweHMRd5HEYW59gtGmmddl15oIz
VcR2I1dYU8m6jCxnAt688L0MoBUjI9RJcip4Y0j03YCvSZfGFSX5uDzZcnvTAn3t
znRXMfv9XoYBys8xv4N1zajc1wiC6liu531BZ5Yj9bvhVZNdAEvWm4cBhe9aiCdh
Lp3k1JKUxi8ah0OwmYZ8/p0YBLA7PzukH2a0cBHgB123Y6i4iIXw7Yf/+B0qI21O
zhVpGTy3NdjXUzhtiaNIO0hPKmLgwKoazElnJWm12yuPlJPNKJ8TFMddfes8jdg8
G3mw3WxsFbjieZMGG64KgNYYag34FYnNN05SYceeEjeKAEceYDLi4NptAbsKmOf/
uMwY+YzM+kME9/SJNF8zJiCFF4UjC7WlRxfL5E0L/YXNK1jfKqN4409YNJrPsojF
QCUQkgAv7ffg9SsuCAnylPcH0QORXGLzLBVqh22+lOUl0fpket/HYS70ul3/6UAJ
6r3j+LVN6ARp+8ki8nHx9Ctyd9cVafg2/EBNmFWQNz/rFghWu+AQqiLltm5MymSD
iVu+R0eCtBhkeLABFAy5RZGxQenJDLDasFYCh3XTKfMzKumA0Rbv33I6JoO4l4/5
9HZtC9tfwliwHwHkxl1I
=wZ/b
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
