From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Mon, 8 Jul 2013 10:21:09 +0300
Message-ID: <20130708072109.GA16635@arwen.pp.htv.fi>
References: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
 <1371575221-360-5-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371575221-360-5-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2013 at 08:07:01PM +0300, Aaro Koskinen wrote:
> +static ssize_t vbus_state_show(struct device *device,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct tahvo_usb *tu =3D dev_get_drvdata(device);
> +	return sprintf(buf, "%d\n", tu->vbus_state);
> +}
> +static DEVICE_ATTR(vbus_state, 0444, vbus_state_show, NULL);

VBUS status sounds generic enough, also, you should be printing on/off
here instead of tahvo-specific values. Some users might not have access
to the docs, or even the kernel sources, to understand what that integer
means.

> +static void tahvo_usb_become_host(struct tahvo_usb *tu)
> +{
> +	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
> +
> +	extcon_set_cable_state(&tu->extcon, "USB-HOST", true);
> +
> +	/* Power up the transceiver in USB host mode */
> +	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
> +		   USBR_MASTER_SW2 | USBR_MASTER_SW1);
> +	tu->phy.state =3D OTG_STATE_A_IDLE;
> +
> +	check_vbus_state(tu);
> +}
> +
> +static void tahvo_usb_stop_host(struct tahvo_usb *tu)
> +{
> +	tu->phy.state =3D OTG_STATE_A_IDLE;

shouldn't you undo tahvo_usb_become_host() here ? I mean, set the
transceiver to SLAVE ?

> +static int tahvo_usb_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, phy);
> +
> +	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, host);
> +
> +	if (otg =3D=3D NULL)
> +		return -ENODEV;
> +
> +	mutex_lock(&tu->serialize);
> +
> +	if (host =3D=3D NULL) {
> +		if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST)
> +			tahvo_usb_power_off(tu);
> +		otg->host =3D NULL;
> +		mutex_unlock(&tu->serialize);
> +		return 0;
> +	}
> +
> +	if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST) {
> +		otg->host =3D NULL;
> +		tahvo_usb_become_host(tu);
> +	}
> +
> +	otg->host =3D host;
> +
> +	mutex_unlock(&tu->serialize);
> +
> +	return 0;
> +}
> +
> +static int tahvo_usb_set_peripheral(struct usb_otg *otg,
> +				    struct usb_gadget *gadget)

I want to get rid of the extra 'gadget' and 'host' parameters on
->set_host() and ->set_peripheral(). Nobody really uses them other than:

my_phy->phy.otg->{gadget,host} =3D {gadget,host};

For that, I need all other PHYs to stop relying on those parameters and
I'll cook patches for that for v3.12 merge window.

> +static ssize_t otg_mode_store(struct device *device,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct tahvo_usb *tu =3D dev_get_drvdata(device);
> +	int r;
> +
> +	mutex_lock(&tu->serialize);
> +	if (count >=3D 4 && strncmp(buf, "host", 4) =3D=3D 0) {
> +		if (tu->tahvo_mode =3D=3D TAHVO_MODE_PERIPHERAL)
> +			tahvo_usb_stop_peripheral(tu);
> +		tu->tahvo_mode =3D TAHVO_MODE_HOST;
> +		if (tu->phy.otg->host) {
> +			dev_info(device, "HOST mode: host controller present\n");
> +			tahvo_usb_become_host(tu);
> +		} else {
> +			dev_info(device, "HOST mode: no host controller, powering off\n");
> +			tahvo_usb_power_off(tu);
> +		}
> +		r =3D strlen(buf);
> +	} else if (count >=3D 10 && strncmp(buf, "peripheral", 10) =3D=3D 0) {
> +		if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST)
> +			tahvo_usb_stop_host(tu);
> +		tu->tahvo_mode =3D TAHVO_MODE_PERIPHERAL;
> +		if (tu->phy.otg->gadget) {
> +			dev_info(device, "PERIPHERAL mode: gadget driver present\n");
> +			tahvo_usb_become_peripheral(tu);
> +		} else {
> +			dev_info(device, "PERIPHERAL mode: no gadget driver, powering off\n");
> +			tahvo_usb_power_off(tu);
> +		}
> +		r =3D strlen(buf);
> +	} else {
> +		r =3D -EINVAL;
> +	}
> +	mutex_unlock(&tu->serialize);
> +
> +	return r;
> +}
> +
> +static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);

this looks like something which would be very nice if implemented
generically. Since you, anyway miss the documentation in
Documentation/ABI/ and need to respin the patch, how about making this
generic ?

> +static int tahvo_usb_probe(struct platform_device *pdev)
> +{
> +	struct retu_dev *rdev =3D dev_get_drvdata(pdev->dev.parent);
> +	struct tahvo_usb *tu;
> +	int ret;
> +
> +	tu =3D devm_kzalloc(&pdev->dev, sizeof(*tu), GFP_KERNEL);
> +	if (!tu)
> +		return -ENOMEM;
> +
> +	tu->phy.otg =3D devm_kzalloc(&pdev->dev, sizeof(*tu->phy.otg),
> +				   GFP_KERNEL);
> +	if (!tu->phy.otg)
> +		return -ENOMEM;
> +
> +	tu->pt_dev =3D pdev;
> +
> +	/* Default mode */
> +#ifdef CONFIG_TAHVO_USB_HOST_BY_DEFAULT
> +	tu->tahvo_mode =3D TAHVO_MODE_HOST;
> +#else
> +	tu->tahvo_mode =3D TAHVO_MODE_PERIPHERAL;
> +#endif

should you call become_host()/become_peripheral() here ?

> +	mutex_init(&tu->serialize);
> +
> +	tu->ick =3D devm_clk_get(&pdev->dev, "usb_l4_ick");
> +	if (!IS_ERR(tu->ick))
> +		clk_enable(tu->ick);
> +
> +	/*
> +	 * Set initial state, so that we generate kevents only on state changes.
> +	 */
> +	tu->vbus_state =3D retu_read(rdev, TAHVO_REG_IDSR) & TAHVO_STAT_VBUS;
> +
> +	tu->extcon.name =3D DRIVER_NAME;
> +	tu->extcon.supported_cable =3D tahvo_cable;
> +	ret =3D extcon_dev_register(&tu->extcon, &pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not register extcon device: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Set the initial cable state. */
> +	extcon_set_cable_state(&tu->extcon, "USB-HOST",
> +			       tu->tahvo_mode =3D=3D TAHVO_MODE_HOST);
> +	extcon_set_cable_state(&tu->extcon, "USB", tu->vbus_state);
> +
> +	tu->irq =3D platform_get_irq(pdev, 0);
> +	ret =3D request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt, 0,
> +				   "tahvo-vbus", tu);

since your hardirq handler is NULL, you *must* pass IRQF_ONESHOT. /Could
also use devm_request_threaded_irq()

> +	if (ret) {
> +		dev_err(&pdev->dev, "could not register tahvo-vbus irq: %d\n",
> +			ret);
> +		goto err_disable_clk;
> +	}
> +
> +	/* Attributes */
> +	ret =3D device_create_file(&pdev->dev, &dev_attr_vbus_state);
> +	ret |=3D device_create_file(&pdev->dev, &dev_attr_otg_mode);

heh, Greg wrote a very interesting article recently (look at his blog)
discussing kernel/userland races wrt creation of sysfs files.

> +	/* Create OTG interface */
> +	tahvo_usb_power_off(tu);
> +	tu->phy.dev =3D &pdev->dev;
> +	tu->phy.state =3D OTG_STATE_UNDEFINED;
> +	tu->phy.label =3D DRIVER_NAME;
> +	tu->phy.set_suspend =3D tahvo_usb_set_suspend;
> +
> +	tu->phy.otg->phy =3D &tu->phy;
> +	tu->phy.otg->set_host =3D tahvo_usb_set_host;
> +	tu->phy.otg->set_peripheral =3D tahvo_usb_set_peripheral;
> +
> +	ret =3D usb_add_phy(&tu->phy, USB_PHY_TYPE_USB2);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "cannot register USB transceiver: %d\n",
> +			ret);
> +		goto err_free_irq;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, tu);

what if someone accesses the sysfs file you've already created before
you call dev_set_drvdata? (not sure  if it's possible).

--=20
balbi

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2mhlAAoJEIaOsuA1yqREq+oP/ivIOU5WwYfkG+yTjDp+PznC
9Y40d8jcekkEtwEDnQdYmeImfSp2s92csmStu8u+AB3jJozgdQsTXAxhlti7Xg+U
CS5QNdw2GWcDV83i/CtQy4tfDRzJDT34709Ujk6NUnGJa3oMkl8FUqajD/XuI40z
UywlNBD6Mw2pK/vdsU3B6u5n62PbqBu7HBZI0I5V8GKRT3ivNSAREiATXdS/FJBN
wUuEaBR0AQ28Zmgib2aww+vie6JsJUIEKzO0xhIf5ShucoYi5ALJTfD+5Ptn0UDT
oZyBujmuh0h+Dj2zVpjOHKbbyMClQ8HT94Mv2eysu+B5e1ov7cyIIUca/FGSZJuD
IMHD0z37/ChrkNnGXHloqUwps/lOo9HqaesR98DV9YCMrcxutF8FoVTSI/eo6fxt
Q+KQwz/bIjUOddQzT/SIujp8jpK+zfJOEgcCb2WQZNSofmlMo49U+mqV43jMxil5
mIq3FGFn8EhwSSaj2TYpGTlob7XzbgNB0+RL3EdFMrqXA9fCECqbjhwGLJXr7/cB
UcnBBjCyi35aEjGiy9WyjQRSR/RfZ0gcH8GuAnGOaVMfjP7dN/y6LTZdtzORH3ac
uVrLxMqkF2gmV7ybDq0eq7s737OzhX4LQ+oroWVmrcC5vViAeY+uiwNkuqQwirZB
rubuf20lueiPNClIE4ag
=84YU
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
