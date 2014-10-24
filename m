From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 3/3] rtc: omap: Support regulator supply for RTC
Date: Fri, 24 Oct 2014 10:40:17 -0500
Message-ID: <20141024154017.GJ26941@saruman>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
 <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
 <20141024075312.GD28808@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaJXPl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2014 11:41:29 -0400
Content-Disposition: inline
In-Reply-To: <20141024075312.GD28808@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 24, 2014 at 09:53:12AM +0200, Johan Hovold wrote:
> On Fri, Oct 24, 2014 at 10:23:45AM +0530, Lokesh Vutla wrote:
> > On some Soc's RTC is powered by an external power regulator.
> > e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
> > power regulator.
> >=20
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  3 +++
> >  drivers/rtc/rtc-omap.c                             | 24 ++++++++++++++=
++++++++
> >  2 files changed, 27 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Docum=
entation/devicetree/bindings/rtc/rtc-omap.txt
> > index 750efd4..e7ad12b 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> > @@ -15,6 +15,8 @@ Required properties:
> >  Optional properties:
> >  - ti,system-power-controller: whether the rtc is controlling the syste=
m power
> >    through pmic_power_en
> > +Optional Properties:
>=20
> No need to repeat the "Optional Properties" header.
>=20
> > +- vrtc-supply: phandle to the regulator device tree node if needed
> > =20
> >  Example:
> > =20
> > @@ -25,4 +27,5 @@ rtc@1c23000 {
> >  		      19>;
> >  	interrupt-parent =3D <&intc>;
> >  	ti,system-power-controller;
> > +	vrtc-supply =3D <&ldo9_reg>;
> >  };
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index d9bb5e7..61fe630 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/io.h>
> > +#include <linux/regulator/consumer.h>
> > =20
> >  /*
> >   * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
> > @@ -134,6 +135,7 @@ struct omap_rtc {
> >  	u8 interrupts_reg;
> >  	bool is_pmic_controller;
> >  	const struct omap_rtc_device_type *type;
> > +	struct regulator *supply;
> >  };
> > =20
> >  static inline u8 rtc_read(struct omap_rtc *rtc, unsigned int reg)
> > @@ -516,6 +518,22 @@ static int omap_rtc_probe(struct platform_device *=
pdev)
> > =20
> >  	platform_set_drvdata(pdev, rtc);
>=20
> Also could you move the regulator allocation before this
> platform_set_drvdata when resending? It's not required, but that call
> sort of separates the allocations from the device initialisation
> currently.
>=20
> > +	rtc->supply =3D devm_regulator_get_optional(&pdev->dev, "vrtc");
> > +	if (IS_ERR(rtc->supply)) {
> > +		if (PTR_ERR(rtc->supply) =3D=3D -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		rtc->supply =3D NULL;
> > +	}
> > +
> > +	if (rtc->supply) {
> > +		ret =3D regulator_enable(rtc->supply);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "regulator enable failed\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	/* Enable the clock/module so that we can access the registers */
> >  	pm_runtime_enable(&pdev->dev);
> >  	pm_runtime_get_sync(&pdev->dev);
> > @@ -624,6 +642,9 @@ err:
> >  	pm_runtime_put_sync(&pdev->dev);
> >  	pm_runtime_disable(&pdev->dev);
> > =20
> > +	if (rtc->supply)
> > +		regulator_disable(rtc->supply);
> > +
> >  	return ret;
> >  }
> > =20
> > @@ -649,6 +670,9 @@ static int __exit omap_rtc_remove(struct platform_d=
evice *pdev)
> >  	pm_runtime_put_sync(&pdev->dev);
> >  	pm_runtime_disable(&pdev->dev);
> > =20
> > +	if (rtc->supply)
> > +		regulator_disable(rtc->supply);
> > +
> >  	return 0;
> >  }
>=20
> Looks good otherwise. Feel free to add
>=20
> Reviewed-by: Johan Hovold <johan@kernel.org>

Conditional on Johan's comments:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSnLhAAoJEIaOsuA1yqREcQsP+gPhsrpzftpEvCg3qxbnULjJ
nSIzGv4J4jH7h7RjyXcB8hpSisVTlB8Mv3KofFoxRUG9L6d7OfxeQxALpA3idbAF
cng8kKd9fs612kQjW4jQIRxvRgQyEDhAu5Nz2BSNkcOYyfZckM5kmB0jgFuESF0p
Zm5ZYiIyXF9MfyhBmhQPMzgZt94l571/kFTzTM9tto9Z4a8g7fPRJldAKNKTieSv
klAU187ZRIZgrSg66LTaGYmtk0/4hLWbtLVKNI899xJBg9KKyI/c1eBzjRksJOE1
DhseW3VsaXbvgkBcn6dtMwjcxhi3S81RmIElqrNHDZoFBidts/Ao2FQj1Gkkxr/U
Iai/Pxnpla8uzYvVjSZfuSur1O0dai+DpKTWQoXYkWxSIURU2EZtpuSjJ6RTszHe
3DJLhmSt7VPICWyK4eMtmruh7BLJWeQBajAsLynO8mvgQCoFGWJa20v0i356ahSe
TwETHwgl0cd9DDOOw3VlvLcb5rjj4iypunK8Bwd2ICtb/qjjRVfk4C4JRD8q/jIU
qzZv7OlXoCjRyYZAwELJrZCx+Jw+UHCaJ3IXbWH/p4AIDPObY+xPhlV85LE7HJzQ
L5EqaaqAtL0rwwpDWIXldODfNPZ1KfSKK6tdjAlekULMIcvu3hEaUH76mY3Fk6oL
X9uXEwrM4USnKPuJ18MJ
=fNO4
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--
