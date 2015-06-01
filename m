From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 5/6] phy: twl4030-usb: add support for reading resistor
 on ID pin.
Date: Tue, 2 Jun 2015 07:37:31 +1000
Message-ID: <20150602073731.26edbd3b@notabene.brown>
References: <20150416075945.23307.24424.stgit@notabene.brown>
	<20150416080304.23307.41913.stgit@notabene.brown>
	<556C5FF4.3050603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/c5FbS..w+1RzbuxIwx8jZb0"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53307 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbbFAVhn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 17:37:43 -0400
In-Reply-To: <556C5FF4.3050603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org

--Sig_/c5FbS..w+1RzbuxIwx8jZb0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jun 2015 19:06:52 +0530 Kishon Vijay Abraham I <kishon@ti.com>
wrote:

> Hi,
>=20
> On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
> > From: NeilBrown <neilb@suse.de>
> >
> > The twl4030 phy can measure, with low precision, the
> > resistance-to-ground of the ID pin.
> >
> > Add a function to read the value, and export the result
> > via sysfs.
>=20
> Little sceptical about adding new sysfs entries. Do you have a good reaso=
n to=20
> add this?

The hardware can report the value, so why not present it to user-space?

I originally used this with a udev rule which would configure the maximum
current based on the resistance measure - to work with the particular charg=
er
hardware I have.

More recent patches try to do all of the max-current configuration in the
kernel, so I could live without exporting the value via sysfs if that is a
show-stopper.

I can't see where the scepticism comes from though.  It is a well defined
and cleary documented feature of the hardware.  Why not expose it?

Thanks,
NeilBrown


>=20
> Thanks
> Kishon
> >
> > If the read fails, which it does sometimes, try again in 50msec.
> >
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >   .../ABI/testing/sysfs-platform-twl4030-usb         |   22 +++++++
> >   drivers/phy/phy-twl4030-usb.c                      |   63 +++++++++++=
+++++++++
> >   2 files changed, 85 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-twl4030-usb b/Doc=
umentation/ABI/testing/sysfs-platform-twl4030-usb
> > index 512c51be64ae..425d23676f8a 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-twl4030-usb
> > +++ b/Documentation/ABI/testing/sysfs-platform-twl4030-usb
> > @@ -6,3 +6,25 @@ Description:
> >   	Possible values: "on", "off".
> >
> >   	Changes are notified via select/poll.
> > +
> > +What: /sys/bus/platform/devices/*twl4030-usb/id
> > +Description:
> > +	Read-only report on measurement of USB-OTG ID pin.
> > +
> > +	The ID pin may be floating, grounded, or pulled to
> > +	ground by a resistor.
> > +
> > +	A very course grained reading of the resistance is
> > +	available.  The numbers given in kilo-ohms are roughly
> > +	the center-point of the detected range.
> > +
> > +	Possible values are:
> > +		ground
> > +		102k
> > +		200k
> > +		440k
> > +		floating
> > +		unknown
> > +
> > +	"unknown" indicates a problem with trying to detect
> > +	the resistance.
> > diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-us=
b.c
> > index 3a707dd14238..1d6f3e70193e 100644
> > --- a/drivers/phy/phy-twl4030-usb.c
> > +++ b/drivers/phy/phy-twl4030-usb.c
> > @@ -379,6 +379,56 @@ static void twl4030_i2c_access(struct twl4030_usb =
*twl, int on)
> >   	}
> >   }
> >
> > +enum twl4030_id_status {
> > +	TWL4030_GROUND,
> > +	TWL4030_102K,
> > +	TWL4030_200K,
> > +	TWL4030_440K,
> > +	TWL4030_FLOATING,
> > +	TWL4030_ID_UNKNOWN,
> > +};
> > +static char *twl4030_id_names[] =3D {
> > +	"ground",
> > +	"102k",
> > +	"200k",
> > +	"440k",
> > +	"floating",
> > +	"unknown"
> > +};
> > +
> > +enum twl4030_id_status twl4030_get_id(struct twl4030_usb *twl)
> > +{
> > +	int ret;
> > +
> > +	pm_runtime_get_sync(twl->dev);
> > +	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
> > +		twl4030_i2c_access(twl, 1);
> > +	ret =3D twl4030_usb_read(twl, ULPI_OTG_CTRL);
> > +	if (ret < 0 || !(ret & ULPI_OTG_ID_PULLUP)) {
> > +		/* Need pull-up to read ID */
> > +		twl4030_usb_set_bits(twl, ULPI_OTG_CTRL,
> > +				     ULPI_OTG_ID_PULLUP);
> > +		mdelay(50);
> > +	}
> > +	ret =3D twl4030_usb_read(twl, ID_STATUS);
> > +	if (ret < 0 || (ret & 0x1f) =3D=3D 0) {
> > +		mdelay(50);
> > +		ret =3D twl4030_usb_read(twl, ID_STATUS);
> > +	}
> > +
> > +	if (twl->usb_mode =3D=3D T2_USB_MODE_ULPI)
> > +		twl4030_i2c_access(twl, 0);
> > +	pm_runtime_put_autosuspend(twl->dev);
> > +
> > +	if (ret < 0)
> > +		return TWL4030_ID_UNKNOWN;
> > +	ret =3D ffs(ret) - 1;
> > +	if (ret < TWL4030_GROUND || ret > TWL4030_FLOATING)
> > +		return TWL4030_ID_UNKNOWN;
> > +
> > +	return ret;
> > +}
> > +
> >   static void __twl4030_phy_power(struct twl4030_usb *twl, int on)
> >   {
> >   	u8 pwr =3D twl4030_usb_read(twl, PHY_PWR_CTRL);
> > @@ -532,6 +582,16 @@ static ssize_t twl4030_usb_vbus_show(struct device=
 *dev,
> >   }
> >   static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
> >
> > +static ssize_t twl4030_usb_id_show(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   char *buf)
> > +{
> > +	struct twl4030_usb *twl =3D dev_get_drvdata(dev);
> > +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +			 twl4030_id_names[twl4030_get_id(twl)]);
> > +}
> > +static DEVICE_ATTR(id, 0444, twl4030_usb_id_show, NULL);
> > +
> >   static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
> >   {
> >   	struct twl4030_usb *twl =3D _twl;
> > @@ -709,6 +769,8 @@ static int twl4030_usb_probe(struct platform_device=
 *pdev)
> >   	platform_set_drvdata(pdev, twl);
> >   	if (device_create_file(&pdev->dev, &dev_attr_vbus))
> >   		dev_warn(&pdev->dev, "could not create sysfs file\n");
> > +	if (device_create_file(&pdev->dev, &dev_attr_id))
> > +		dev_warn(&pdev->dev, "could not create sysfs file\n");
> >
> >   	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> >
> > @@ -753,6 +815,7 @@ static int twl4030_usb_remove(struct platform_devic=
e *pdev)
> >   	pm_runtime_get_sync(twl->dev);
> >   	cancel_delayed_work(&twl->id_workaround_work);
> >   	device_remove_file(twl->dev, &dev_attr_vbus);
> > +	device_remove_file(twl->dev, &dev_attr_id);
> >
> >   	/* set transceiver mode to power on defaults */
> >   	twl4030_usb_set_mode(twl, -1);
> >
> >


--Sig_/c5FbS..w+1RzbuxIwx8jZb0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVWzQmznsnt1WYoG5AQJvFxAArDgCT9yg3XjnYUqgnstFg7DiFcHZ/ye2
nxecgd7eRE0uBtcieLIy+EjiP7aj2GMrjocx0gcTXwNcmLhP63nvSm/L2yF+6WGi
OsFrkTzVnDJtrWvudDRhcHHt54Og0C72jlR/ToObbERP2QOr8hHb0a3TiUezjG0U
LlgKjH5HLFy0nws1s88ITRMMyeVyd/ZrfS7vZKZu4n1XU9gvu1JtIzBzuj0GLjjL
u9bCa0MBIOOIYmgs4wDeExRx64zardsn+i88yUKK1tOFyg7B6x4gfS+1IHlNv6Kr
v41IiWZ7TGIMzW5gCdJgSVP0pdJM5k+/Pr2GgmyQ4UF9yJ7QfcPryFzlfWg53NB7
t5Zr2i2EQtdOpCEk1EBVQLgLoA5//PQ5HHk6L5pFRDm9Pu2hZQSV9B13Kk77Faii
knQhhC0eobCtQJZImKjhuO1JG9z0TNeipyIAKKEXqpc6amyaP+RB63J++6hg7ZKJ
LM37oghZZqrg9B5lHGanBxWo41H267sDYEr+DpfCVzaTfsr/HyDUgwLgesnEs/mB
3UnaOG0u4THK4nyX/zjvcpdVyGhI1ZHcsIKEeWA7Ui5W7AcVE5xWQdUwIZItZdSJ
X8nD6EYlMHUC5lxJMRcVmSzIpjvNPEJy8XoEwbdglInWyAM+uyu3N9r/KesKoYV0
KBqiXsHsp50=
=0TYz
-----END PGP SIGNATURE-----

--Sig_/c5FbS..w+1RzbuxIwx8jZb0--
