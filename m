From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Tue, 9 Jul 2013 14:34:14 +0300
Message-ID: <20130709113414.GK5552@arwen.pp.htv.fi>
References: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
 <1371575221-360-5-git-send-email-aaro.koskinen@iki.fi>
 <20130708072109.GA16635@arwen.pp.htv.fi>
 <20130708194402.GA8516@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33183 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3GILfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 07:35:01 -0400
Content-Disposition: inline
In-Reply-To: <20130708194402.GA8516@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 08, 2013 at 10:44:02PM +0300, Aaro Koskinen wrote:
> > > +static void tahvo_usb_become_host(struct tahvo_usb *tu)
> > > +{
> > > +	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
> > > +
> > > +	extcon_set_cable_state(&tu->extcon, "USB-HOST", true);
> > > +
> > > +	/* Power up the transceiver in USB host mode */
> > > +	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
> > > +		   USBR_MASTER_SW2 | USBR_MASTER_SW1);
> > > +	tu->phy.state =3D OTG_STATE_A_IDLE;
> > > +
> > > +	check_vbus_state(tu);
> > > +}
> > > +
> > > +static void tahvo_usb_stop_host(struct tahvo_usb *tu)
> > > +{
> > > +	tu->phy.state =3D OTG_STATE_A_IDLE;
> >=20
> > shouldn't you undo tahvo_usb_become_host() here ? I mean, set the
> > transceiver to SLAVE ?
>=20
> tahvo_usb_become_peripheral() (or power_off) is always called after this
> function. Actually, these stop functions can be eliminated altogether
> as they are only called from a single place...

alright, I guess GCC is already inlining them anyway, your choice.

> > > +static int tahvo_usb_set_host(struct usb_otg *otg, struct usb_bus *h=
ost)
> > > +{
> > > +	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, p=
hy);
> > > +
> > > +	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, host);
> > > +
> > > +	if (otg =3D=3D NULL)
> > > +		return -ENODEV;
> > > +
> > > +	mutex_lock(&tu->serialize);
> > > +
> > > +	if (host =3D=3D NULL) {
> > > +		if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST)
> > > +			tahvo_usb_power_off(tu);
> > > +		otg->host =3D NULL;
> > > +		mutex_unlock(&tu->serialize);
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST) {
> > > +		otg->host =3D NULL;
> > > +		tahvo_usb_become_host(tu);
> > > +	}
> > > +
> > > +	otg->host =3D host;
> > > +
> > > +	mutex_unlock(&tu->serialize);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tahvo_usb_set_peripheral(struct usb_otg *otg,
> > > +				    struct usb_gadget *gadget)
> >=20
> > I want to get rid of the extra 'gadget' and 'host' parameters on
> > ->set_host() and ->set_peripheral(). Nobody really uses them other than:
> >=20
> > my_phy->phy.otg->{gadget,host} =3D {gadget,host};
> >=20
> > For that, I need all other PHYs to stop relying on those parameters and
> > I'll cook patches for that for v3.12 merge window.
>=20
> How will the PHY know if there is a host/gadget driver present? I guess
> I will need to wait for those patches...

It won't. We're assuming that if the link asks to become a host, it
should already know that there is a host side available :-)

> > > +static int tahvo_usb_probe(struct platform_device *pdev)
> > > +{
> > > +	struct retu_dev *rdev =3D dev_get_drvdata(pdev->dev.parent);
> > > +	struct tahvo_usb *tu;
> > > +	int ret;
> > > +
> > > +	tu =3D devm_kzalloc(&pdev->dev, sizeof(*tu), GFP_KERNEL);
> > > +	if (!tu)
> > > +		return -ENOMEM;
> > > +
> > > +	tu->phy.otg =3D devm_kzalloc(&pdev->dev, sizeof(*tu->phy.otg),
> > > +				   GFP_KERNEL);
> > > +	if (!tu->phy.otg)
> > > +		return -ENOMEM;
> > > +
> > > +	tu->pt_dev =3D pdev;
> > > +
> > > +	/* Default mode */
> > > +#ifdef CONFIG_TAHVO_USB_HOST_BY_DEFAULT
> > > +	tu->tahvo_mode =3D TAHVO_MODE_HOST;
> > > +#else
> > > +	tu->tahvo_mode =3D TAHVO_MODE_PERIPHERAL;
> > > +#endif
> >=20
> > should you call become_host()/become_peripheral() here ?
>=20
> Not needed. Once the PHY is registered, the framework will call set_host /
> set_peripheral and the HW gets set to correct state.

ok good, thanks

> > /Could also use devm_request_threaded_irq()
>=20
> Does not really help much, since the IRQ has to be freed manually anyway
> (to ensure it's disabled before usb_remove_phy(); also looks like it's
> currently enabled too early...).

you miss a free() in the error path. Switching to
devm_request_threaded_irq() would save you the trouble of having to call
that explicitly.

--=20
balbi

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2/U2AAoJEIaOsuA1yqRE26YP/2aR/G+JJxSSu6YaE0fpDT02
VUO0d9PKBkTELzcbS2349eev8fD6BbOQuTTNdpcvrPNDSPGiGzD4f6t4fO99IhVb
WDa4z/3n+rlshSbe2FAyMjd/zDPU3QSOJAbzYqz+YItzew6QkfglQOWqzuCw62RM
nlFo0ARAqCk+ALHPlnC0gWL2rvUiSYmLF6zjYtIOlVXRmQQC/VgS/2qDQGQxljCY
Xb2xqUEMB0FJzBuJthAu1XOMzhnlkpqSErpQ2HouckUimJm0YgqTg8KiH+Y1JFxH
Wh46g7Mw+bI3NwLmAjebrc4tiU9minTo9AdUY+I5DzGSNwdAYuziqcHYMvE1iKhM
YagsZi5vCTWpjHJnaZuZ1SR5QTX7aV4defrPyMobwridzIdaqRmZ9HvbT4R8BGs5
o7tN7E6OwuDIa0s5n/XT14AIw3AYFj61zBgDfefJEMdwf6xcENC0jlMdnuYU/XPe
bYqmtQc8jeg2qhFV1rfRfWJ7/3rjsgyOlxKvHI5zKfNp8sHXjyEask2U08pJVAUn
qIwFnTZxMUV2NOHSa4Y3WB5LQWwKxizCZOjrZcubf8IzqHtHsDaTo6LpFy3xJbdh
z/7tWIKbaaC22w6k1rb/x7NSVrcOY6jFIJbbnKBIDmI9igB28dG5K4oiD5WQXHOQ
WBfCsyG0ZZc+LrtGjOKa
=M77/
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
