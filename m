From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
Date: Thu, 20 Jun 2013 15:11:51 +0300
Message-ID: <20130620121151.GD9817@arwen.pp.htv.fi>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-5-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371650753-11452-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, ruslan.bilovol-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2013 at 05:05:51PM +0300, Roger Quadros wrote:
> Runtime suspend the controller during bus suspend and resume it
> during bus resume. This will ensure that the USB Host power domain
> enters lower power state and does not prevent the SoC from
> endering deeper sleep states.
>=20
> Remote wakeup will come up as an interrupt while the controller
> is suspended, so tackle it carefully using a workqueue.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/host/ehci-omap.c |   82 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 82 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 16d7150..91f14f1 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -44,6 +44,8 @@
>  #include <linux/usb/hcd.h>
>  #include <linux/of.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/workqueue.h>
> +#include <linux/spinlock.h>
> =20
>  #include "ehci.h"
> =20
> @@ -69,6 +71,7 @@ static const char hcd_name[] =3D "ehci-omap";
>  struct omap_hcd {
>  	struct usb_phy *phy[OMAP3_HS_USB_PORTS]; /* one PHY for each port */
>  	int nports;
> +	struct work_struct work;
>  };
> =20
>  static inline void ehci_write(void __iomem *base, u32 reg, u32 val)
> @@ -81,6 +84,76 @@ static inline u32 ehci_read(void __iomem *base, u32 re=
g)
>  	return __raw_readl(base + reg);
>  }
> =20
> +static void omap_ehci_work(struct work_struct *work)
> +{
> +	struct omap_hcd *omap =3D container_of(work, struct omap_hcd, work);
> +	struct ehci_hcd *ehci =3D container_of((void *) omap,
> +						struct ehci_hcd, priv);
> +	struct usb_hcd *hcd =3D ehci_to_hcd(ehci);
> +	struct device *dev =3D hcd->self.controller;
> +
> +	pm_runtime_get_sync(dev);
> +	enable_irq(hcd->irq);
> +	/*
> +	 * enable_irq() should preempt us with a pending IRQ
> +	 * so we can be sure that IRQ handler completes before
> +	 * we call pm_runtime_put_sync()
> +	 */
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static irqreturn_t omap_ehci_irq(struct usb_hcd *hcd)
> +{
> +	struct omap_hcd *omap =3D (struct omap_hcd *)hcd_to_ehci(hcd)->priv;
> +	struct device *dev =3D hcd->self.controller;
> +	irqreturn_t ret;
> +
> +	if (pm_runtime_suspended(dev)) {
> +		schedule_work(&omap->work);
> +		disable_irq_nosync(hcd->irq);
> +		ret =3D IRQ_HANDLED;

looks like this could be done as:

if (pm_runtime_suspended(dev)) {
	pm_runtime_get(dev);
	omap->flags |=3D OMAP_EHCI_IRQ_PENDING;
	disable_irq_nosync(hcd->irq);
	ret =3D IRQ_HANDLED;
}

then on your ->runtime_resume():

runtime_resume(dev)
{
	...

	if (omap->flags & OMAP_EHCI_IRQ_PENDING) {
		process_pending_irqs(omap);
		omap->flags &=3D ~OMAP_EHCI_IRQ_PENDING;
	}

	return 0;
}

or something similar

--=20
balbi

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwvGHAAoJEIaOsuA1yqREE0AQAI7N/kNpLUqEjKRAkHq/1NO9
kw9dU/x+mDSldaCyUqyns6GTes+mg529QW9IyplBnSPWp19fh5EjMGbIPx8209OC
SPxeUne7mUVrNtj38yn0bnaM/E92Qj/DZWxx/bOYDIqs9p/QK4QtWkrH31853rrz
qPOfiGpc5IpufPCCukwMTn/bxPILs7vzDrkTkkVYPQ5yn9qKxYsMdk10kq8cAuQf
Ng/flXwZAbaOBBDWgisVlhOuhIJ+4TztLTkfw/emwRpAUlV6HWHF1ZxBFZ2oqto1
TwviZ/6utE9UPuu1u90s8E5eFGivl2BmTSsuSSLYHtDvzxqL8bccVzQ5/UTgg9Q/
Mqo31xDqr2dDNJ5V9I8u/xK7z2vYE5oHNiW0dLz3K7D1Mjaz+C5Z911vDvK3cSqx
bk91qPb5n3/wm8vyAWit3AZq1VgeIoM+THI7l9Ga4VxtWzNpXuWK0/Huetbx6RRO
Wg/FuZW/aFDVw5Atw3GneNJ1CBqwPs9fv2fgGzsPyYeKltD8ethWEUL6gjxi2Xdi
j//r+njnGRCF2MwgsV1+o/R0Jz1b6LfUCoE9tVPEZuArUkvz8OPPieTbEv6d+Iz8
IWADWhfTPnXqcTKj4N21EK8OMkKll+oV1UScYiMM1oTPW+EQd1WaRgTqsXo/sNDi
1IlynUe3KSULNiNJGiV8
=oiR5
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
