From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 1/3] drivers:power:twl4030-charger: remove nonstandard
 max_current sysfs attribute
Date: Wed, 7 Jun 2017 22:23:14 +0200
Message-ID: <20170607202313.qko7tgzocfhwbdwv@earth>
References: <cover.1495363097.git.hns@goldelico.com>
 <2cfdb1799219d883cde31779e97d570dc003f8cf.1495363097.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eijpqohsafa43cdd"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cfdb1799219d883cde31779e97d570dc003f8cf.1495363097.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--eijpqohsafa43cdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 21, 2017 at 12:38:16PM +0200, H. Nikolaus Schaller wrote:
> Since we now support the standard 'input_current_limit' property by
>=20
> commit 3fb319c2cdcd ("power: supply: twl4030-charger: add writable INPUT_=
CURRENT_LIMIT property")
>=20
> we can now remove the nonstandard 'max_current' sysfs attribute.
>=20
> See Documentation/power/power_supply_class.txt line 125
>=20
> Both are functionally equivalent. From ABI point of view it is just a ren=
ame
> of the property.
>=20
> This also removes the entry in Documentation/ABI/testing/sysfs-class-powe=
r-twl4030
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks, queued.

-- Sebastian

> ---
>  .../ABI/testing/sysfs-class-power-twl4030          | 17 ------
>  drivers/power/supply/twl4030_charger.c             | 63 ----------------=
------
>  2 files changed, 80 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-twl4030 b/Docume=
ntation/ABI/testing/sysfs-class-power-twl4030
> index be26af0f1895..b4fd32d210c5 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-twl4030
> +++ b/Documentation/ABI/testing/sysfs-class-power-twl4030
> @@ -1,20 +1,3 @@
> -What: /sys/class/power_supply/twl4030_ac/max_current
> -      /sys/class/power_supply/twl4030_usb/max_current
> -Description:
> -	Read/Write limit on current which may
> -	be drawn from the ac (Accessory Charger) or
> -	USB port.
> -
> -	Value is in micro-Amps.
> -
> -	Value is set automatically to an appropriate
> -	value when a cable is plugged or unplugged.
> -
> -	Value can the set by writing to the attribute.
> -	The change will only persist until the next
> -	plug event.  These event are reported via udev.
> -
> -
>  What: /sys/class/power_supply/twl4030_usb/mode
>  Description:
>  	Changing mode for USB port.
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 2f82d0e9ec1b..785a07bc4f39 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -624,63 +624,6 @@ static irqreturn_t twl4030_bci_interrupt(int irq, vo=
id *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> -/*
> - * Provide "max_current" attribute in sysfs.
> - */
> -static ssize_t
> -twl4030_bci_max_current_store(struct device *dev, struct device_attribut=
e *attr,
> -	const char *buf, size_t n)
> -{
> -	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
> -	int cur =3D 0;
> -	int status =3D 0;
> -	status =3D kstrtoint(buf, 10, &cur);
> -	if (status)
> -		return status;
> -	if (cur < 0)
> -		return -EINVAL;
> -	if (dev =3D=3D &bci->ac->dev)
> -		bci->ac_cur =3D cur;
> -	else
> -		bci->usb_cur_target =3D cur;
> -
> -	twl4030_charger_update_current(bci);
> -	return n;
> -}
> -
> -/*
> - * sysfs max_current show
> - */
> -static ssize_t twl4030_bci_max_current_show(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	int status =3D 0;
> -	int cur =3D -1;
> -	u8 bcictl1;
> -	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
> -
> -	if (dev =3D=3D &bci->ac->dev) {
> -		if (!bci->ac_is_active)
> -			cur =3D bci->ac_cur;
> -	} else {
> -		if (bci->ac_is_active)
> -			cur =3D bci->usb_cur_target;
> -	}
> -	if (cur < 0) {
> -		cur =3D twl4030bci_read_adc_val(TWL4030_BCIIREF1);
> -		if (cur < 0)
> -			return cur;
> -		status =3D twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
> -		if (status < 0)
> -			return status;
> -		cur =3D regval2ua(cur, bcictl1 & TWL4030_CGAIN);
> -	}
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
> -}
> -
> -static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
> -			twl4030_bci_max_current_store);
> -
>  static void twl4030_bci_usb_work(struct work_struct *data)
>  {
>  	struct twl4030_bci *bci =3D container_of(data, struct twl4030_bci, work=
);
> @@ -1111,14 +1054,10 @@ static int twl4030_bci_probe(struct platform_devi=
ce *pdev)
>  		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
> =20
>  	twl4030_charger_update_current(bci);
> -	if (device_create_file(&bci->usb->dev, &dev_attr_max_current))
> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  	if (device_create_file(&bci->usb->dev, &dev_attr_mode))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
>  	if (device_create_file(&bci->ac->dev, &dev_attr_mode))
>  		dev_warn(&pdev->dev, "could not create sysfs file\n");
> -	if (device_create_file(&bci->ac->dev, &dev_attr_max_current))
> -		dev_warn(&pdev->dev, "could not create sysfs file\n");
> =20
>  	twl4030_charger_enable_ac(bci, true);
>  	if (!IS_ERR_OR_NULL(bci->transceiver))
> @@ -1150,9 +1089,7 @@ static int twl4030_bci_remove(struct platform_devic=
e *pdev)
> =20
>  	iio_channel_release(bci->channel_vac);
> =20
> -	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
>  	device_remove_file(&bci->usb->dev, &dev_attr_mode);
> -	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
>  	device_remove_file(&bci->ac->dev, &dev_attr_mode);
>  	/* mask interrupts */
>  	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
> --=20
> 2.12.2
>=20

--eijpqohsafa43cdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4YLEACgkQ2O7X88g7
+po70Q//X9SFuDZ0T8FVR7k5JTqTVoyz5OXAEBX8qjzWXa2kwebxzgb/ipD6DF2P
nS9nxU7815skIRp7IFldPN35jO//jLqEovdc7PCfkIUgjn/RoTeBfMRpZAqocCYV
QCAXeuLz6CAQEjDPwaAdn4kxq2bPkshL/+FW506ApUengeso/B6B3v9+TSwmnVyl
40OYgEBbIL4x3kErgnEXl8FetDAPKzWV/b85sq2q2R731k0JQmXuwzo+a1Kw2aVa
7E8BQeRKkJd9pgc/4BNw6lGLxccYw6rHM6jvgnnXdXd0KWXoeZbxMR0UNijhhU1g
V305tmrc4L54hIh/BApjTxtIx/Dr/cUTowO319nk6crNMfwJbE+YEhJyau4qbD2s
DblX2qS81LCFTajkMO0EX8Hidu6Oi0+PrSfqQwvcCIcTfuRIZuVfNHmHLtRb5p/m
29FJ7mfrB/7IjYQXl6hOAithbiCn2Xv3JW7EA8kwAmiB7T0NBebcgWTeZRAgFG5V
xS4OsSI67YevsRMYNu2eyCfh+5kXOMEchNrURoU73thzgLhhgqmRTMOZHNJ/b1fY
uHWlTuwSPDN1COR4SHi7mqCB6f5xjPwRAJ4/V6jb6oCSQ0qGxwYEBZw7wlo2k1JV
XTaj2IM0ffTSqoVdmN/+U1+jY1pffkGppbFV+cJFLEXYnpD3UmA=
=vuXA
-----END PGP SIGNATURE-----

--eijpqohsafa43cdd--
