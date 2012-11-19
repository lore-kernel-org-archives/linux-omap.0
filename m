From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 119/493] usb: remove use of __devexit_p
Date: Mon, 19 Nov 2012 22:14:54 +0200
Message-ID: <20121119201454.GA24309@arwen.pp.htv.fi>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353349642-3677-119-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 01:21:08PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>=20
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>=20
> Cc: Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>=20
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>=20
> Cc: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>=20
> Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>=20
> Cc: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>=20
> Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>=20
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org=20
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org=20
> Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> ---
>  drivers/usb/c67x00/c67x00-drv.c      | 2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c   | 2 +-
>  drivers/usb/chipidea/ci13xxx_msm.c   | 2 +-
>  drivers/usb/chipidea/ci13xxx_pci.c   | 2 +-
>  drivers/usb/chipidea/core.c          | 2 +-
>  drivers/usb/chipidea/usbmisc_imx6q.c | 2 +-
>  drivers/usb/dwc3/core.c              | 2 +-
>  drivers/usb/dwc3/dwc3-exynos.c       | 2 +-
>  drivers/usb/dwc3/dwc3-omap.c         | 2 +-
>  drivers/usb/dwc3/dwc3-pci.c          | 2 +-
>  drivers/usb/gadget/bcm63xx_udc.c     | 2 +-
>  drivers/usb/gadget/fsl_qe_udc.c      | 2 +-
>  drivers/usb/gadget/hid.c             | 2 +-
>  drivers/usb/gadget/lpc32xx_udc.c     | 2 +-
>  drivers/usb/gadget/net2272.c         | 4 ++--
>  drivers/usb/gadget/omap_udc.c        | 2 +-
>  drivers/usb/gadget/s3c-hsotg.c       | 2 +-
>  drivers/usb/host/bcma-hcd.c          | 2 +-
>  drivers/usb/host/ehci-atmel.c        | 2 +-
>  drivers/usb/host/ehci-msm.c          | 2 +-
>  drivers/usb/host/ehci-platform.c     | 2 +-
>  drivers/usb/host/ehci-s5p.c          | 2 +-
>  drivers/usb/host/ehci-w90x900.c      | 2 +-
>  drivers/usb/host/fhci-hcd.c          | 2 +-
>  drivers/usb/host/fsl-mph-dr-of.c     | 2 +-
>  drivers/usb/host/isp1362-hcd.c       | 2 +-
>  drivers/usb/host/isp1760-if.c        | 2 +-
>  drivers/usb/host/ohci-at91.c         | 2 +-
>  drivers/usb/host/ohci-exynos.c       | 2 +-
>  drivers/usb/host/ohci-jz4740.c       | 2 +-
>  drivers/usb/host/ohci-omap3.c        | 2 +-
>  drivers/usb/host/ohci-platform.c     | 2 +-
>  drivers/usb/host/ohci-s3c2410.c      | 2 +-
>  drivers/usb/host/ohci-tmio.c         | 2 +-
>  drivers/usb/host/r8a66597-hcd.c      | 2 +-
>  drivers/usb/host/sl811-hcd.c         | 2 +-
>  drivers/usb/host/ssb-hcd.c           | 2 +-
>  drivers/usb/host/u132-hcd.c          | 2 +-
>  drivers/usb/musb/am35x.c             | 2 +-
>  drivers/usb/musb/da8xx.c             | 2 +-
>  drivers/usb/musb/davinci.c           | 2 +-
>  drivers/usb/musb/musb_core.c         | 2 +-
>  drivers/usb/musb/musb_dsps.c         | 2 +-
>  drivers/usb/musb/omap2430.c          | 2 +-
>  drivers/usb/musb/tusb6010.c          | 2 +-
>  drivers/usb/musb/ux500.c             | 2 +-
>  drivers/usb/otg/ab8500-usb.c         | 2 +-
>  drivers/usb/otg/fsl_otg.c            | 2 +-
>  drivers/usb/otg/msm_otg.c            | 2 +-
>  drivers/usb/otg/mxs-phy.c            | 2 +-
>  drivers/usb/otg/nop-usb-xceiv.c      | 2 +-
>  drivers/usb/phy/mv_u3d_phy.c         | 2 +-
>  drivers/usb/phy/omap-usb2.c          | 2 +-
>  drivers/usb/phy/rcar-phy.c           | 2 +-
>  drivers/usb/renesas_usbhs/common.c   | 2 +-
>  55 files changed, 56 insertions(+), 56 deletions(-)

For drivers/usb/gadget, drivers/usb/dwc3/, drivers/usb/musb/,
drivers/usb/otg/, drivers/usb/phy, and drivers/usb/renesas_usbhs:

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqpM9AAoJEIaOsuA1yqREWjQQAIXXAJx5+kSOe2m3cZ9ihY9h
kNSeWwzGQzkWj5ZjJ0+PbI6ivH32XT83gnojK5ZiI4ZY+z12Qg2GdKonjKD2p2Ay
m/HKSWBbuM21YmDbEKMnnTrBjoPpDisBpV+0wfkJWn8czmkWsFIYmvovZcg7bWF3
75B3lI8lrqxeM/cFKm+3iq800BHQ6j0oakvNFOM/I3e/hitJ/SOZbSiVrIJk2Y70
49rTGAKeyiXRHTOmIdPfl7/AJGwUkXkpdNygHwuRfCFjgERkRJfyQpIu3Fyc13/F
caVJqrImlJHT6GJUZcPICybxYfbG8FKxl62PvTEW1Q+3pgtM2P2RSWq8LGrwLiX+
QzFIIddhhPAxhyxQeRLNdpdQQojKT65vlRWUgnVqmVnR3XCrbJVoUqVHxYWYZjK3
D0OJ79gd4kmj8MtkjEzyGYywCxkPswDZuxB7Nj+ycZ9AkQpnqMnayJoybDAGMTuO
L1VD4ExGzOwMC8NEK6yC1sEKXe46eEmRuJGFw8ppDyGs2qGu85bfC1+KJIpsYtYs
tLGvMSZ2za7/aLOuyI5UdA0ZzXPjtVgPSJezObuG+oZMgs3DoB1naMxC/dFfA/u6
vS4PTB3MWW+BKMV6WHJYmAzGQFJGpMz8UjaYTTCo0wvd7stJ0Nz2KH+uMasV5/Os
C7YHTUcUEg5VWWj0gCTG
=JUhY
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
