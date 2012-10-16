From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/3] usb: xhci: Add the suspend/resume functionality
Date: Tue, 16 Oct 2012 12:59:33 +0300
Message-ID: <20121016095932.GA17416@arwen.pp.htv.fi>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
 <1350380738-32473-3-git-send-email-vikas.sajjan@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42206 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab2JPKFF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 06:05:05 -0400
Content-Disposition: inline
In-Reply-To: <1350380738-32473-3-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 16, 2012 at 03:15:37PM +0530, Vikas Sajjan wrote:
> Adds power management support to XHCI platform driver.
> This patch facilitates the transition of xHCI host controller
> between S0 and S3/S4 power states, during suspend/resume cycles.
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/host/xhci-plat.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index df90fe5..eaf3a07 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -185,11 +185,39 @@ static int xhci_plat_remove(struct platform_device =
*dev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int xhci_plat_suspend(struct device *dev)
> +{
> +	struct usb_hcd	*hcd	=3D dev_get_drvdata(dev);
> +	struct xhci_hcd	*xhci	=3D hcd_to_xhci(hcd);
> +
> +	/* Make sure that the HCD Core has set state to HC_STATE_SUSPENDED */
> +	if (hcd->state !=3D HC_STATE_SUSPENDED ||
> +		xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
> +		return -EINVAL;
> +
> +	return xhci_suspend(xhci);

this is pretty much what xhci_pci_suspend() is doing. Sarah, would you
be ok with a patch such as:

usb: host: xhci: move HC_STATE_SUSPENDED check to xhci_suspend()

[ STILL NEED TO WRITE A PROPER COMMIT LOG ]

NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
---

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 8345d7c..aeb3973 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -218,15 +218,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
 static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 {
 	struct xhci_hcd	*xhci =3D hcd_to_xhci(hcd);
-	int	retval =3D 0;
=20
-	if (hcd->state !=3D HC_STATE_SUSPENDED ||
-			xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
-		return -EINVAL;
-
-	retval =3D xhci_suspend(xhci);
-
-	return retval;
+	return xhci_suspend(xhci);
 }
=20
 static int xhci_pci_resume(struct usb_hcd *hcd, bool hibernated)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8d7fcbb..b85029e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -879,6 +879,10 @@ int xhci_suspend(struct xhci_hcd *xhci)
 	struct usb_hcd		*hcd =3D xhci_to_hcd(xhci);
 	u32			command;
=20
+	if (hcd->state !=3D HC_STATE_SUSPENDED ||
+			xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
+		return -EINVAL;
+
 	spin_lock_irq(&xhci->lock);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);

do you think there is any reason to keep replicating the
HC_STATE_SUSPENDED test all over the place ?

--=20
balbi

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfTAEAAoJEIaOsuA1yqRE4uEQAIbAdNgb9bQf6/BgXkxn+LXS
9RNJ53AW1Cl1o6PD6zA6E6mQZExnCfFOfBNQ8cr9eUX6+f6iErZJZFA4FpKGE5DC
zo13ZALlwaa1ej1TXhsolT4Z+6RfSoil833OssRsFr69J8ORQkyOocCz6ohUlnXq
0QdLs3SuNiFsK10tvYjNJZJzpWDuG4aRefdjaBvl9ujUQPBiNgYAetvYO0QLUEIB
IYgEj6x1BjZit4LLspZA+yd7rDak510OpWanfnD0rWreYlmMIx8W2s5CBRqaB1G0
0Sq+RDjb4Ay10r+55EiJgcHFMWP1IFgXw6irS7XfCvW0AAdt6TzoWIHxmbpAceTP
52JpbDHQTFkyybSD9obXqOCc498/3yE+sLrOEq/6OYqiE5I3Lx4D/HkN+21lpiZN
y2nTUhCoa7Rdg0gPDJ1+OK/eC20/GZlBgJPKKvhKx5YTKfLBnSzcL0NI3PmQokBN
umNwjvIhwpsD5Uw0BBMwQTrSYMTOFYre+lyrUjW/M0cr33M+ETKBPQkgpP74sGmm
pR1s7RY1s5W61ZXn/CS/zulusyWBL/+LhxwL5zQiqZuo1gtDoEacf0nDP8q505im
mCCWZqpnLYZEsJkorFm3Nnio04usk0eLJekxyOqm01AnOD2ul+34ua7g37fPVGuu
zUzUSWVH0Uz95Bf0/la8
=IyxN
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
