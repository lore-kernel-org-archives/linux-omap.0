From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 09/15] twl4030_charger: allow max_current to be managed
 via sysfs.
Date: Thu, 5 Mar 2015 17:26:00 +1100
Message-ID: <20150305172600.30951e70@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043351.4243.46323.stgit@notabene.brown>
	<20150302210525.GN13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/dJmV8vAu/EWIwUxCPB6XojS"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43825 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbbCEG0M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 01:26:12 -0500
In-Reply-To: <20150302210525.GN13270@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

--Sig_/dJmV8vAu/EWIwUxCPB6XojS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:05:26 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> > 'max_current' sysfs attributes are created which allow the
> > max to be set.
> > Whenever a current source changes, the default is restored.
> > This will be followed by a uevent, so user-space can decide to
> > update again.
>=20
> Does this need Documentation update?

Oh all right... I've created the relevant documentation in Documentation/AB=
I.

It seems persistence pays off :-)


>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/power/twl4030_charger.c |   76 +++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 76 insertions(+)
> >=20
> > diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
> > index bfc9b808301e..b0242786d047 100644
> > --- a/drivers/power/twl4030_charger.c
> > +++ b/drivers/power/twl4030_charger.c
> > @@ -527,6 +529,67 @@ static irqreturn_t twl4030_bci_interrupt(int irq, =
void *arg)
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > +/*
> > + * sysfs max_current store
> > + */
>=20
> That's not exactly useful comment.

Now:

 * Provide "max_current" attribute in sysfs.

>=20
> > +static ssize_t
> > +twl4030_bci_max_current_store(struct device *dev, struct device_attrib=
ute *attr,
> > +	const char *buf, size_t n)
> > +{
> > +	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
> > +	int cur =3D 0;
> > +	int status =3D 0;
> > +	status =3D kstrtoint(buf, 10, &cur);
> > +	if (status)
> > +		return status;
> > +	if (cur < 0)
> > +		return -EINVAL;
> > +	if (dev =3D=3D bci->ac.dev) {
> > +		if (bci->ac_cur =3D=3D cur)
> > +			return n;
> > +		bci->ac_cur =3D cur;
> > +	} else {
> > +		if (bci->usb_cur =3D=3D cur)
> > +			return n;
> > +		bci->usb_cur =3D cur;
> > +	}
> > +	twl4030_charger_update_current(bci);
> > +	return (status =3D=3D 0) ? n : status;
> > +}
>=20
> Uff. but we know that status =3D=3D 0 at this point, no?=20

Yes.  Fixed.

>                                                       Also... is
> optimalization of not calling update_current() when nothing changed
> worth it?

Probably not... and  code looks a lot nicer if I remove that.
So I have.


>=20
> > +/*
> > + * sysfs max_current show
> > + */
> > +static ssize_t twl4030_bci_max_current_show(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	int status =3D 0;
> > +	int cur =3D -1;
> > +	u8 bcictl1;
> > +	struct twl4030_bci *bci =3D dev_get_drvdata(dev->parent);
> > +
> > +	if (dev =3D=3D bci->ac.dev) {
> > +		if (!bci->ac_is_active)
> > +			cur =3D bci->ac_cur;
> > +	} else {
> > +		if (bci->ac_is_active)
> > +			cur =3D bci->usb_cur;
> > +	}
> > +	if (cur < 0) {
> > +		cur =3D twl4030bci_read_adc_val(TWL4030_BCIIREF1);
> > +		if (cur < 0)
> > +			return cur;
> > +		status =3D twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
> > +		if (status < 0)
> > +			return status;
> > +		cur =3D regval2ua(cur, bcictl1 & TWL4030_CGAIN);
> > +	}
> > +	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
> > +}
>=20
> Is this in uA or mA? uA. Ok.

uA, now described in Documentation/ABI/testing/sysfs-class-power-twl4030

+What: /sys/class/power_supply/twl4030_ac/max_current
+      /sys/class/power_supply/twl4030_usb/max_current
+Description:
+       Read/Write limit on current which which may
+       be drawn from the ac (Accessory Charger) or
+       USB port.
+
+       Value is in micro-Amps.
+
+       Value is set automatically to an appropriate
+       value when a cable is plugged on unplugged.
+
+       Value can the set by writing to the attribute.
+       The change will only persist until the next
+       plug event.  These event are reported via udev.


>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 									Pavel
>=20

Thanks,
NeilBrown

--Sig_/dJmV8vAu/EWIwUxCPB6XojS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPf2+Dnsnt1WYoG5AQL5uxAAtO4k3pWnGqr/wH8X/F/wnY+Kpq1HyatI
FebiiboxGOyIK1h/pXQYTNcSdhOfhxwIGihyb3alzcX9ldwMWA1Jv7mB0PU9Xg1n
pUazUG0WpJ5PlUzYlojaF9xgAvfJS0Xempvf+6P3hd9SCxdaoHryjDvdAzlwLpC1
gugMAgFFfWPCJnvvnhxIcZw0n4LXl8RZl/O7ZSurbOMhxVshKEIrx9L/dmSJU0GY
KlsB9vbg/hfBuHCRtcHPHDpWyIm8OYgDWcf9gE87dm5NPggAwCfpH8P70GyyMwVy
LSHUohsmGcXHedRFor5g8eqLZn7/h2g21ymtY7xjcq/LjhVN5g8lKibmwzrTzYrX
n09Dp/BuhvISAo47WbJLv4kPynM2l1tP3j4Xd+H04Ki4PLWrKCOEW+zhFQjiskBO
JTqVAhOSfn2Zn91H6q1EngCR2PbId+XF1amchmr34C0oXaoxXl5B72r6OiniEoNk
fClGa1loFEyJ2cN30u7iwMIoBHn6yjSrtrTAJzkPKr9PWbklUnE4h0oNVqWPGfRH
RjJR4DSSutEmUgnNtSJUmyHNbgeFVz6htR5aYHhemxI7gJLr+larW3pRsTJTToA1
A7X8z8q9bnhCyKLQTkqQerer7yV25v0vAqNRR6ckM0jd5ia6y65gzy3LsERFWm/e
tGUZUBrNILM=
=srgE
-----END PGP SIGNATURE-----

--Sig_/dJmV8vAu/EWIwUxCPB6XojS--
