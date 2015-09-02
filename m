From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/9] usb: dwc3: add dual-role support
Date: Wed, 2 Sep 2015 09:31:49 -0500
Message-ID: <20150902143149.GD8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-2-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 02, 2015 at 05:24:16PM +0300, Roger Quadros wrote:
> Register with the USB OTG core. Since we don't support
> OTG yet we just work as a dual-role device even
> if device tree says "otg".
>=20
> Use extcon framework to get VBUS/ID cable events and
> kick the OTG state machine.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.c          | 174 +++++++++++++++++++++++++++++++++=
+++++-
>  drivers/usb/dwc3/core.h          |   7 ++
>  drivers/usb/dwc3/platform_data.h |   1 +
>  3 files changed, 181 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 064123e..2e36a9b 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -704,6 +704,152 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  	return 0;
>  }
> =20
> +/* --------------------- Dual-Role management --------------------------=
----- */
> +
> +static void dwc3_drd_fsm_sync(struct dwc3 *dwc)
> +{
> +	int id, vbus;
> +
> +	/* get ID */
> +	id =3D extcon_get_cable_state(dwc->edev, "USB-HOST");
> +	/* Host means ID =3D=3D 0 */
> +	id =3D !id;
> +
> +	/* get VBUS */
> +	vbus =3D extcon_get_cable_state(dwc->edev, "USB");
> +	dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);

tracepoint please. We don't want this driver to use dev_(v)?db anymore.
Ditto to all others.

> +
> +	dwc->fsm->id =3D id;
> +	dwc->fsm->b_sess_vld =3D vbus;
> +	usb_otg_sync_inputs(dwc->fsm);
> +}
> +
> +static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
> +{
> +	struct device *dev =3D usb_otg_fsm_to_dev(fsm);
> +	struct dwc3 *dwc =3D dev_get_drvdata(dev);

how about adding a usb_otg_get_drvdata(fsm) ?

> +	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
> +	if (on) {
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +		/* start the HCD */
> +		usb_otg_start_host(fsm, true);
> +	} else {
> +		/* stop the HCD */
> +		usb_otg_start_host(fsm, false);
> +	}

This can be simplified.

	if (on)
		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);

	usb_otg_start_host(fsm, on);

> +
> +	return 0;
> +}
> +
> +static int dwc3_drd_start_gadget(struct otg_fsm *fsm, int on)
> +{
> +	struct device *dev =3D usb_otg_fsm_to_dev(fsm);
> +	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +
> +	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
> +	if (on) {
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +		dwc3_event_buffers_setup(dwc);
> +
> +		/* start the UDC */
> +		usb_otg_start_gadget(fsm, true);
> +	} else {
> +		/* stop the UDC */
> +		usb_otg_start_gadget(fsm, false);
> +	}

likewise:

	if (on) {
		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
		dwc3_event_buffers_setup(dwc);
	}

	usb_otg_start_gadget(fsm, on);

> +	return 0;
> +}
> +
> +static struct otg_fsm_ops dwc3_drd_ops =3D {
> +	.start_host =3D dwc3_drd_start_host,
> +	.start_gadget =3D dwc3_drd_start_gadget,
> +};
> +
> +static int dwc3_drd_notifier(struct notifier_block *nb,
> +			     unsigned long event, void *ptr)
> +{
> +	struct dwc3 *dwc =3D container_of(nb, struct dwc3, otg_nb);
> +
> +	dwc3_drd_fsm_sync(dwc);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int dwc3_drd_init(struct dwc3 *dwc)
> +{
> +	int ret, id, vbus;
> +	struct usb_otg_caps *otgcaps =3D &dwc->otg_config.otg_caps;
> +
> +	otgcaps->otg_rev =3D 0;
> +	otgcaps->hnp_support =3D false;
> +	otgcaps->srp_support =3D false;
> +	otgcaps->adp_support =3D false;
> +	dwc->otg_config.fsm_ops =3D &dwc3_drd_ops;
> +
> +	if (!dwc->edev) {
> +		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
> +		return -ENODEV;
> +	}
> +
> +	dwc->otg_nb.notifier_call =3D dwc3_drd_notifier;
> +	ret =3D extcon_register_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
> +	if (ret < 0) {
> +		dev_err(dwc->dev, "Couldn't register USB cable notifier\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
> +				       &dwc->otg_nb);
> +	if (ret < 0) {
> +		dev_err(dwc->dev, "Couldn't register USB-HOST cable notifier\n");
> +		ret =3D -ENODEV;
> +		goto extcon_fail;
> +	}
> +
> +	/* sanity check id & vbus states */
> +	id =3D extcon_get_cable_state(dwc->edev, "USB-HOST");
> +	vbus =3D extcon_get_cable_state(dwc->edev, "USB");
> +	if (id < 0 || vbus < 0) {
> +		dev_err(dwc->dev, "Invalid USB cable state. id %d, vbus %d\n",
> +			id, vbus);
> +		ret =3D -ENODEV;
> +		goto fail;
> +	}
> +
> +	/* register as DRD device with OTG core */
> +	dwc->fsm =3D usb_otg_register(dwc->dev, &dwc->otg_config);
> +	if (IS_ERR(dwc->fsm)) {
> +		ret =3D PTR_ERR(dwc->fsm);
> +		if (ret =3D=3D -ENOTSUPP)
> +			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
> +		else
> +			dev_err(dwc->dev, "Failed to register with OTG core\n");

do you need to cope with EPROBE_DEFER ?

> +
> +		goto fail;
> +	}
> +
> +	dwc3_drd_fsm_sync(dwc);
> +
> +	return 0;
> +fail:
> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST, &dwc->otg_nb);
> +extcon_fail:
> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
> +
> +	return ret;
> +}
> +
> +static void dwc3_drd_exit(struct dwc3 *dwc)
> +{
> +	usb_otg_unregister(dwc->dev);
> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST, &dwc->otg_nb);
> +	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
> +}
> +
> +/* ---------------------------------------------------------------------=
----- */
> +
>  static int dwc3_core_init_mode(struct dwc3 *dwc)
>  {
>  	struct device *dev =3D dwc->dev;
> @@ -727,13 +873,21 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +		ret =3D dwc3_drd_init(dwc);
> +		if (ret) {
> +			dev_err(dev, "limiting to peripheral only\n");
> +			dwc->dr_mode =3D USB_DR_MODE_PERIPHERAL;
> +			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +			goto gadget_init;
> +		}
> +
>  		ret =3D dwc3_host_init(dwc);
>  		if (ret) {
>  			dev_err(dev, "failed to initialize host\n");
>  			return ret;
>  		}
> =20
> +gadget_init:
>  		ret =3D dwc3_gadget_init(dwc);
>  		if (ret) {
>  			dev_err(dev, "failed to initialize gadget\n");
> @@ -760,6 +914,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_OTG:
>  		dwc3_host_exit(dwc);
>  		dwc3_gadget_exit(dwc);
> +		dwc3_drd_exit(dwc);
>  		break;
>  	default:
>  		/* do nothing */
> @@ -843,6 +998,16 @@ static int dwc3_probe(struct platform_device *pdev)
>  	hird_threshold =3D 12;
> =20
>  	if (node) {
> +		if (of_property_read_bool(node, "extcon"))
> +			dwc->edev =3D extcon_get_edev_by_phandle(dev, 0);
> +		else if (of_property_read_bool(dev->parent->of_node, "extcon"))
> +			dwc->edev =3D extcon_get_edev_by_phandle(dev->parent, 0);

why do you need to check the parent ? Why isn't that done on the glue
layer ?

> +
> +		if (IS_ERR(dwc->edev)) {
> +			dev_vdbg(dev, "couldn't get extcon device\n");

dev_err() ??

> +			return -EPROBE_DEFER;

this could make us reschedule probe forever.

> +		}
> +
>  		dwc->maximum_speed =3D of_usb_get_maximum_speed(node);
>  		dwc->has_lpm_erratum =3D of_property_read_bool(node,
>  				"snps,has-lpm-erratum");
> @@ -887,6 +1052,13 @@ static int dwc3_probe(struct platform_device *pdev)
>  		of_property_read_string(node, "snps,hsphy_interface",
>  					&dwc->hsphy_interface);
>  	} else if (pdata) {
> +		if (pdata->extcon) {
> +			dwc->edev =3D extcon_get_extcon_dev(pdata->extcon);
> +			if (!dwc->edev) {
> +				dev_vdbg(dev, "couldn't get extcon device\n");
> +				return -EPROBE_DEFER;

ditto

> +			}
> +		}
>  		dwc->maximum_speed =3D pdata->maximum_speed;
>  		dwc->has_lpm_erratum =3D pdata->has_lpm_erratum;
>  		if (pdata->lpm_nyet_threshold)
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 0447788..5ca2b25 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -31,8 +31,10 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
>  #include <linux/ulpi/interface.h>
> +#include <linux/usb/otg-fsm.h>
> =20
>  #include <linux/phy/phy.h>
> +#include <linux/extcon.h>
> =20
>  #define DWC3_MSG_MAX	500
> =20
> @@ -753,6 +755,11 @@ struct dwc3 {
> =20
>  	struct ulpi		*ulpi;
> =20
> +	struct extcon_dev	*edev;	/* USB cable events ID & VBUS */
> +	struct notifier_block	otg_nb;	/* notifier for USB cable events */
> +	struct otg_fsm		*fsm;
> +	struct usb_otg_config	otg_config;
> +
>  	void __iomem		*regs;
>  	size_t			regs_size;
> =20
> diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform=
_data.h
> index d3614ec..b3b245c 100644
> --- a/drivers/usb/dwc3/platform_data.h
> +++ b/drivers/usb/dwc3/platform_data.h
> @@ -47,4 +47,5 @@ struct dwc3_platform_data {
>  	unsigned tx_de_emphasis:2;
> =20
>  	const char *hsphy_interface;
> +	const char *extcon;	/* extcon name for USB cable events ID/VBUS */
>  };
> --=20
> 2.1.4
>=20

--=20
balbi

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5whVAAoJEIaOsuA1yqRE8iQP/0lZJCdWrKtfbO9yN1ivEF9B
Pqh/kRTdAIknA2yv/yqH0UQB4b9Q/AzFvVZlhE9h8RjyvLzF1O+5PptS2kThCMf1
JntRBYbF58m3E8n475FNB9UzDh1MyIC5+IJcWL9MiQXk38m7rNY8/nki7PKs224m
nFDC0vLJq1UPZAtVBi06RpNkuVeh4cfaCpWMYVTOcsfuIzmQAUavnMb4GpHT2Pzi
pbRzhyRTGptLoAWGDhUVVAncmLr0mbnne/YZStJxZOFcecy0548EgOyQPHU463vf
Zsbpoc3m/UVj2WGIdFv7dBHZL2SAKyft+vEKpBAe6MGYcI0y5qu7ARgxD35ehclY
IZPx9078q7++U65cYZ/1ldYg2T3N8shy6Bd+13koCCihejw2zGYG9EeHJhMSQpyb
l9u1utVEgpf0QSaSIwBHMVofLHSxHQsjkAldnQvKTkkthGzPW+kVl2Y3AWm4pArD
M/Cirb5dSDXfnWzrGw2mRCjzx0vYRROrt/qzXOc1KTKgAYW5/1wBTiTebddh1+Nt
p4BQ2naLxGDjY5q+rtVa2WgKytMfbypht3oIDqx8D2qob+7z2B++HQlBoC3wDlSQ
XUUjmbWzLJHCvDjAL6XS37Kl/s6o4iGBYe9QOHOqDP+LB91zEzIElezat8FLOln2
cLwrNIPeckdRL3ctBvez
=skAY
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
