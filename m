From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 4/9] usb: dwc3: core: Adapt to named interrupts
Date: Wed, 2 Sep 2015 09:34:57 -0500
Message-ID: <20150902143457.GF8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-5-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-5-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 05:24:19PM +0300, Roger Quadros wrote:
> From: Felipe Balbi <balbi@ti.com>
>=20
> Add support to use interrupt names,
>=20
> Following are the interrupt names
>=20
> Peripheral Interrupt - peripheral
> HOST Interrupt - host
> OTG Interrupt - otg
>=20
> [Roger Q]
> - If any of these are missing we use the
> first available IRQ resource so that we don't
> break with older DTBs.

this is what original commit did:

commit ecd5f71cfd663bcd4efd2f29824acd8b2ba9715d
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Jan 3 13:49:38 2014 -0600

    usb: dwc3: cleanup IRQ resources
   =20
    In order to make it easier for the driver to
    figure out which modes of operation it has,
    and because some dwc3 integrations have rather
    fuzzy IRQ routing, we now require three different
    IRQ numbers (peripheral, host, otg).
   =20
    In order to do that and maintain backwards compatibility,
    we still maintain support for the old IRQ resource name,
    but if you *really* want to have proper peripheral/host/otg
    support, you should make sure your resources are correct.
   =20
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 60580a01cdd2..1f01031873b7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -556,10 +556,22 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev =3D dwc->dev;
+	struct platform_device *pdev =3D to_platform_device(dev);
 	int ret;
=20
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc3_peripheral");
+		if (dwc->gadget_irq < 0) {
+			dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc_usb3");
+			if (dwc->gadget_irq < 0) {
+				dev_err(dev, "missing IRQ\n");
+				return dwc->gadget_irq;
+			} else {
+				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
+			}
+		}
+
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret =3D dwc3_gadget_init(dwc);
 		if (ret) {
@@ -568,6 +580,22 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
+		dwc->xhci_irq =3D platform_get_irq_byname(pdev, "dwc3_host");
+		if (dwc->xhci_irq < 0) {
+			dwc->xhci_irq =3D platform_get_irq_byname(pdev, "dwc_usb3");
+			if (dwc->xhci_irq < 0) {
+				dev_err(dev, "missing Host IRQ\n");
+				return dwc->xhci_irq;
+			} else {
+				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
+			}
+
+			dwc->xhci_resources[1].start =3D dwc->xhci_irq;
+			dwc->xhci_resources[1].end =3D dwc->xhci_irq;
+			dwc->xhci_resources[1].flags =3D IORESOURCE_IRQ;
+			dwc->xhci_resources[1].name =3D "xhci";
+		}
+
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret =3D dwc3_host_init(dwc);
 		if (ret) {
@@ -576,6 +604,28 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
+		dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc3_peripheral");
+		if (dwc->gadget_irq < 0) {
+			dwc->gadget_irq =3D platform_get_irq_byname(pdev, "dwc_usb3");
+			if (dwc->gadget_irq < 0) {
+				dev_err(dev, "missing IRQ\n");
+				return dwc->gadget_irq;
+			} else {
+				dev_warn(dev, "dwc_usb3 resource is deprecated\n");
+			}
+
+			dwc->xhci_irq =3D dwc->gadget_irq;
+			dwc->otg_irq =3D dwc->gadget_irq;
+		} else {
+			dwc->xhci_irq =3D platform_get_irq_byname(pdev, "dwc3_host");
+			if (dwc->xhci_irq < 0) {
+				dev_err(dev, "missing Host IRQ\n");
+				return dwc->xhci_irq;
+			}
+
+			dwc->otg_irq =3D platform_get_irq_byname(pdev, "dwc3_otg");
+		}
+
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret =3D dwc3_otg_init(dwc);
 		if (ret) {
@@ -647,18 +697,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->mem =3D mem;
 	dwc->dev =3D dev;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "missing IRQ\n");
-		return -ENODEV;
-	}
-	dwc->xhci_resources[1].start =3D res->start;
-	dwc->xhci_resources[1].end =3D res->end;
-	dwc->xhci_resources[1].flags =3D res->flags;
-	dwc->xhci_resources[1].name =3D res->name;
-
-	dwc->otg_irq =3D platform_get_irq_byname(pdev, "dwc3_otg");
-
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory resource\n");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8e2e579b4b1e..0b02186fad6f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -671,6 +671,8 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @gadget_irq: IRQ number for Peripheral IRQs
+ * @xhci_irq: IRQ number for Host IRQs
  * @otg_irq: IRQ number for OTG IRQs
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
@@ -747,6 +749,8 @@ struct dwc3 {
=20
 	enum usb_dr_mode	dr_mode;
=20
+	int			gadget_irq;
+	int			xhci_irq;
 	int			otg_irq;
=20
 	/* used for suspend/resume */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a8cf87b3de01..2a6e5155fc89 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1567,15 +1567,13 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	struct dwc3_ep		*dep;
 	unsigned long		flags;
 	int			ret =3D 0;
-	int			irq;
 	u32			reg;
=20
-	irq =3D platform_get_irq(to_platform_device(dwc->dev), 0);
-	ret =3D request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
-			IRQF_SHARED, "dwc3", dwc);
+	ret =3D request_threaded_irq(dwc->gadget_irq, dwc3_interrupt,
+			dwc3_thread_interrupt, IRQF_SHARED, "dwc3", dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
-				irq, ret);
+				dwc->gadget_irq, ret);
 		goto err0;
 	}
=20
@@ -1668,7 +1666,7 @@ err2:
 err1:
 	spin_unlock_irqrestore(&dwc->lock, flags);
=20
-	free_irq(irq, dwc);
+	free_irq(dwc->gadget_irq, dwc);
=20
 err0:
 	return ret;
@@ -1679,7 +1677,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g,
 {
 	struct dwc3		*dwc =3D gadget_to_dwc(g);
 	unsigned long		flags;
-	int			irq;
=20
 	spin_lock_irqsave(&dwc->lock, flags);
=20
@@ -1691,8 +1688,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g,
=20
 	spin_unlock_irqrestore(&dwc->lock, flags);
=20
-	irq =3D platform_get_irq(to_platform_device(dwc->dev), 0);
-	free_irq(irq, dwc);
+	free_irq(dwc->gadget_irq, dwc);
=20
 	return 0;
 }

>=20
> - Use gadget_irq in gadget driver.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.c   | 12 ++++++++++++
>  drivers/usb/dwc3/core.h   |  7 +++++++
>  drivers/usb/dwc3/gadget.c |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2e36a9b..38b31df 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -958,6 +958,18 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc->xhci_resources[1].flags =3D res->flags;
>  	dwc->xhci_resources[1].name =3D res->name;
> =20
> +	dwc->otg_irq =3D platform_get_irq_byname(pdev, "otg");
> +	if (dwc->otg_irq < 0)
> +		dwc->otg_irq =3D res->start;
> +
> +	dwc->gadget_irq =3D platform_get_irq_byname(pdev, "peripheral");
> +	if (dwc->gadget_irq < 0)
> +		dwc->gadget_irq =3D res->start;
> +
> +	dwc->xhci_irq =3D platform_get_irq_byname(pdev, "host");
> +	if (dwc->xhci_irq < 0)
> +		dwc->xhci_irq =3D res->start;
> +
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(dev, "missing memory resource\n");
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 4b85330..bd32cb2 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -742,6 +742,9 @@ struct dwc3_scratchpad_array {
>   * @maximum_speed: maximum speed requested (mainly for testing purposes)
>   * @revision: revision register contents
>   * @dr_mode: requested mode of operation
> + * @xhci_irq: IRQ number for XHCI IRQs
> + * @gadget_irq: IRQ number for Peripheral IRQs
> + * @otg_irq: IRQ number for OTG IRQs
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
> @@ -847,6 +850,10 @@ struct dwc3 {
> =20
>  	enum usb_dr_mode	dr_mode;
> =20
> +	int			gadget_irq;
> +	int			xhci_irq;
> +	int			otg_irq;
> +
>  	/* used for suspend/resume */
>  	u32			dcfg;
>  	u32			gctl;
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 0c25704..1148ec8 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1533,7 +1533,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  	int			irq;
>  	u32			reg;
> =20
> -	irq =3D platform_get_irq(to_platform_device(dwc->dev), 0);
> +	irq =3D dwc->gadget_irq;
>  	ret =3D request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
>  			IRQF_SHARED, "dwc3", dwc);
>  	if (ret) {
> --=20
> 2.1.4
>=20

--=20
balbi

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5wkRAAoJEIaOsuA1yqREubMP/ijoY9MbgxWJijCE+Jx9S0h+
02zYwlgnswqKnPc+Sn5g+NQ+Y/yVaT3FgidvhCdJbXm0bX5qRSHXUNYSTIz3RSX3
dOhE6AhjZeCLb2S2rbSZsxhb8aFG6P17hqtttmrLFwlA6cOJlPfZeqViNYZgXys8
GIENmf52L3s2Grr67uSiJ9n8vctGNILNX3Bhl/VWyTE/iU3ijsfSMwr4+5hIOsjw
uWPE/XME+Hc2AM82RtovtPzNOVIYfgPgH6HmnoJwjGrgFkev1pCVzJc2UWxEizwU
OzkdviuOL6gTs5jj+tOMfFOThN4KfcUTXXtnq2fHVU9U8pF2oee8EMod5pbpbobA
actx3AgJ9rKveHKn6TcqJ4qGQhCS7ZhQAtxPY5LVW/ea0a4pjwKYliKdCTK1TNDl
BAo9ISBBQZQ3+t8xExeSa3Kd5MB/Jhjgo6BpWz9Wemrq9pvodmdVV1wAfyWuw318
plVwvpMJ4JfM10NMi3yZwwz+6SFMAoQ+vh3OrFxjS6h653uCPldQFOU3v/N6Ys0x
kzWdKIAqoeTS/d98olFH3LmTTM2Gpj7adsiT7qKep2kR8zk3Nv/tUytQ/ro/FGMo
dUDVxcPdOBuMjM4cwpaL9SHyY6hXheN4Svf0r7LfQsievnOHtKSudKSwqH3vbkv3
YaiQBbjgPLx39ZdupO4J
=5WBY
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
