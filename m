From: Felipe Balbi <balbi@ti.com>
Subject: Re: Latest randconfig build errors
Date: Mon, 4 Mar 2013 20:51:42 +0200
Message-ID: <20130304185142.GB15203@arwen.pp.htv.fi>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
 <20130304184649.GO11806@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130304184649.GO11806@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 04, 2013 at 10:46:50AM -0800, Tony Lindgren wrote:
> > The last three are caused by incorrect use of 'select':
> >=20
> > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MWAVE) selects SERIAL_8=
250 which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIR=
QS)
> > warning: (USB_MUSB_HDRC) selects TWL4030_USB which has unmet direct dep=
endencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && REGULATOR_=
TWL4030 && USB_MUSB_OMAP2PLUS)
> > warning: (USB_MUSB_HDRC) selects TWL6030_USB which has unmet direct dep=
endencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && OMAP_USB2 =
&& USB_MUSB_OMAP2PLUS)
> > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_8250_CONSO=
LE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQ=
S && SERIAL_8250=3Dy)
> > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_CORE_CONSO=
LE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQ=
S)
> > warning: (VIDEO_DM6446_CCDC && VIDEO_DM355_CCDC && VIDEO_ISIF && VIDEO_=
DAVINCI_VPBE_DISPLAY) selects VIDEO_VPSS_SYSTEM which has unmet direct depe=
ndencies (MEDIA_SUPPORT && V4L_PLATFORM_DRIVERS && ARCH_DAVINCI)
> > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MWAVE) selects SERIAL_8=
250 which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIR=
QS)
> > warning: (USB_MUSB_HDRC) selects TWL4030_USB which has unmet direct dep=
endencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && OMAP_USB2 =
&& USB_MUSB_OMAP2PLUS)
> > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_8250_CONSO=
LE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQ=
S && SERIAL_8250=3Dy)
> > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_CORE_CONSO=
LE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQ=
S)
> > warning: (VIDEO_DM6446_CCDC && VIDEO_DM355_CCDC && VIDEO_ISIF && VIDEO_=
DAVINCI_VPBE_DISPLAY) selects VIDEO_VPSS_SYSTEM which has unmet direct depe=
ndencies (MEDIA_SUPPORT && V4L_PLATFORM_DRIVERS && ARCH_DAVINCI)
> >=20
> > This 'select' madness of driver symbols *HAS* *TO* *STOP*.
>=20
> Felipe, can you take a look at removing the MUSB selects from Kconfig?
> You might be able to just have MUSB depends on TWL if omap.

I don't think we even need depend or select at all for MUSB. I'll look
at it tomorrow.

--=20
balbi

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNO0+AAoJEIaOsuA1yqREjpgP/RgSlCK2EvfKfjN466WCLNim
ZzXDg6Pbj+kxF5uj8Y/yX42VAzZiajKyEpmuAdWpR+o7dDlWbibQaCribC96AM4b
syWeNV1HsV8s4CDYBopxjib5rWykexQgT2mfgkoqHU86DLzm7PPJoW0HwgznpCA9
xpO+xYakoR5eAexW3GTh3QpCOluHUNIyyesXA7+CY6biUB1NCLJubit7nIFhQ/if
vgq9SK1LGCdH13DG5dPmEU2XORi+CWmHz9oFeb4yrjVQ74unnniVQ2gRauDGTQHV
VW0OcA2jdiERYZHQ+jPUyX4Zlbx87amO6yZHiLyvEkj2qk3Moe13VzR/evTRK6gW
sZPeEcCjuI95vbMX12MuFZL+GF7YE2Dvhi2G+fVG64yaNb5uQfVgUjGZ0a96KfaW
cEmQVKHJB+mLIkVEb6sufqcEC0+BF+dBrY+yPYbPVEyEXf+2lxTvIM06Os8SINLW
PC6/3lWEgznP4jwhEK6xqc4p6FBAgN0Ne4QZ01VcMOHEOVggDNEBAx4p36+y1Sru
0wKeHG2JwBv4lisu99Kg2PqMiFXKO84o6bBbIBvXXbCIKUpsoOR92RcTVloOsjlJ
oQM6SJW+WQLJk6TRRW4Ab/5z2pI8rCvU2GcoyN9pD/r9sm6GeifRtHGqBDkbfZ/K
OldH42Z+0ZxZ5SBDf2WE
=+owa
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
