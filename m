From: Felipe Balbi <balbi@ti.com>
Subject: Re: Latest randconfig build errors
Date: Tue, 5 Mar 2013 13:36:54 +0200
Message-ID: <20130305113654.GC19290@arwen.pp.htv.fi>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
 <20130304184649.GO11806@atomide.com>
 <20130304185142.GB15203@arwen.pp.htv.fi>
 <20130304185424.GR11806@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130304185424.GR11806@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 10:54:24AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130304 10:56]:
> > Hi,
> >=20
> > On Mon, Mar 04, 2013 at 10:46:50AM -0800, Tony Lindgren wrote:
> > > > The last three are caused by incorrect use of 'select':
> > > >=20
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MWAVE) selects SERI=
AL_8250 which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HA=
RDIRQS)
> > > > warning: (USB_MUSB_HDRC) selects TWL4030_USB which has unmet direct=
 dependencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && REGULA=
TOR_TWL4030 && USB_MUSB_OMAP2PLUS)
> > > > warning: (USB_MUSB_HDRC) selects TWL6030_USB which has unmet direct=
 dependencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && OMAP_U=
SB2 && USB_MUSB_OMAP2PLUS)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_8250_C=
ONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HAR=
DIRQS && SERIAL_8250=3Dy)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_CORE_C=
ONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HAR=
DIRQS)
> > > > warning: (VIDEO_DM6446_CCDC && VIDEO_DM355_CCDC && VIDEO_ISIF && VI=
DEO_DAVINCI_VPBE_DISPLAY) selects VIDEO_VPSS_SYSTEM which has unmet direct =
dependencies (MEDIA_SUPPORT && V4L_PLATFORM_DRIVERS && ARCH_DAVINCI)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MWAVE) selects SERI=
AL_8250 which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HA=
RDIRQS)
> > > > warning: (USB_MUSB_HDRC) selects TWL4030_USB which has unmet direct=
 dependencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && OMAP_U=
SB2 && USB_MUSB_OMAP2PLUS)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_8250_C=
ONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HAR=
DIRQS && SERIAL_8250=3Dy)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_CORE_C=
ONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HAR=
DIRQS)
> > > > warning: (VIDEO_DM6446_CCDC && VIDEO_DM355_CCDC && VIDEO_ISIF && VI=
DEO_DAVINCI_VPBE_DISPLAY) selects VIDEO_VPSS_SYSTEM which has unmet direct =
dependencies (MEDIA_SUPPORT && V4L_PLATFORM_DRIVERS && ARCH_DAVINCI)
> > > >=20
> > > > This 'select' madness of driver symbols *HAS* *TO* *STOP*.
> > >=20
> > > Felipe, can you take a look at removing the MUSB selects from Kconfig?
> > > You might be able to just have MUSB depends on TWL if omap.
> >=20
> > I don't think we even need depend or select at all for MUSB. I'll look
> > at it tomorrow.
>=20
> OK thanks!

http://marc.info/?l=3Dlinux-usb&m=3D136248269928419&w=3D2

--=20
balbi

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNdjWAAoJEIaOsuA1yqREVK0QAIyf3j0exoY3nXjfPr88XCdU
e400GQgp3nEwgi66loEA1zElE18Chx6UE+8cyQ4kXsXIWrwulCNuPA6KpcX8PpXi
h0WLpWzHkpP3eKhgFhSFLP9aJMxpV3zS1rXJgpG/ddFG2r9Aio09gw+9c+FzvYya
/71qsE2+UcGdssXegRHgIYk7jJo51l2ZTpBhBHkF4tqDwYpKSnAwj60GLY/J8YrR
4ck0B1dYuNmeJLJMUbE+SfNU2gymXjRhWY+8wsOKmi97hVQykiIc3VbLFr8hPj2H
Sbtj6BN46BmIv1TRLyeJPgSQ83IMX4yRDWybh5iRJ+kj1PrwI/C5qM2kq+PXi5qI
kpS3zRLkzpDqVTmHeclAPsI1KpdwxQ+GNl0ZRLBBVzSfY86wqLe4cK01R+L3c3v+
q6/Fm+x/c5osYXQkGqGL6netmNa9nIWimS1wzhwYiY2KL11LHt+fm7dLLjBOw38a
K04SkVKTIuFtEyRYTcaUOVXXt/uZkUU9EnkcOnPj3SXya0lEjQXF4tETII5tVdFH
Rdv1WhPPegcIB3dFw+RyMwJeKYxsQArq4FBc5bvooGrDbavbtbeadbzMdY0UKRjP
KP3GQP9c/ge0yfD2P3GDz1hcYDWjyRo1h0JY06UmZWs3An6JK3isBwIq2jw8KKcw
if056Iv1DI3wUm+EpQWs
=sMBn
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
