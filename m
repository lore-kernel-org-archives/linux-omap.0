From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/25] OMAPDSS: panel-dvi: add PD gpio handling
Date: Wed, 09 May 2012 20:32:40 +0300
Message-ID: <1336584760.3962.72.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <1336053481-25433-2-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XZSpBJ4_DD=uTkX1zD+Hj31MehCVATjNKo0Bo4aHUfnNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-iFYNKZ56wzxKqDZL4pwT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:40444 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027Ab2EIRcq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 13:32:46 -0400
Received: by lagw12 with SMTP id w12so410595lag.38
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 10:32:43 -0700 (PDT)
In-Reply-To: <CA+Bv8XZSpBJ4_DD=uTkX1zD+Hj31MehCVATjNKo0Bo4aHUfnNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-iFYNKZ56wzxKqDZL4pwT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 09:50 -0700, Russ Dill wrote:
> On Thu, May 3, 2012 at 6:57 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> > The driver for the TFP410 chip should handle the power-down signal of
> > the chip, instead of the current way of handling it in the board files.
> >
> > This patch adds power_down_gpio into the device's platform data, and
> > adds the necessary code in the driver to request and handle the GPIO.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/omap2/displays/panel-dvi.c |   31 ++++++++++++++++++++++=
++++++++
> >  include/video/omap-panel-dvi.h           |    2 ++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/o=
map2/displays/panel-dvi.c
> > index 03eb14a..876b798 100644
> > --- a/drivers/video/omap2/displays/panel-dvi.c
> > +++ b/drivers/video/omap2/displays/panel-dvi.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/slab.h>
> >  #include <video/omapdss.h>
> >  #include <linux/i2c.h>
> > +#include <linux/gpio.h>
> >  #include <drm/drm_edid.h>
> >
> >  #include <video/omap-panel-dvi.h>
> > @@ -44,6 +45,8 @@ struct panel_drv_data {
> >        struct omap_dss_device *dssdev;
> >
> >        struct mutex lock;
> > +
> > +       int pd_gpio;
> >  };
> >
> >  static inline struct panel_dvi_platform_data
> > @@ -54,6 +57,7 @@ static inline struct panel_dvi_platform_data
> >
> >  static int panel_dvi_power_on(struct omap_dss_device *dssdev)
> >  {
> > +       struct panel_drv_data *ddata =3D dev_get_drvdata(&dssdev->dev);
> >        struct panel_dvi_platform_data *pdata =3D get_pdata(dssdev);
> >        int r;
> >
> > @@ -70,6 +74,9 @@ static int panel_dvi_power_on(struct omap_dss_device =
*dssdev)
> >                        goto err1;
> >        }
> >
> > +       if (gpio_is_valid(ddata->pd_gpio))
> > +               gpio_set_value(ddata->pd_gpio, 1);
> > +
>=20
> On Beagleboard xM, this GPIO is connected though an I2C chip so it
> sleeps. Can you change these to gpio_set_value_cansleep?

This patch has already been applied, so we have to do follow up patches
for this. I can look at this tomorrow, but if you update your "ARM:
OMAP: Cleanup Beagleboard DVI reset gpio" patch, will you take a look at
this also?

The applied patches can be found from here, so the follow up patches
should be based on this: git://gitorious.org/linux-omap-dss2/linux.git
for-l-o-3.5

 Tomi


--=-iFYNKZ56wzxKqDZL4pwT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqqo4AAoJEPo9qoy8lh71iRYQAI577jKzK63318780Q8jiotW
UjYfJFWB6s7ZVXCVxvKWv2hzI+9ux7C4qjxvazxKfWPaK5Qw5TiuI1GpPnDCrUx8
8L7bqknpO+nqdYhaTtaje6c5EHUJ097lY07iBGcRpdqcPUlz3ECRs+psPHOvrWoN
ocQSh9w6+3jX0BOrkpXfggcn4hbSu9SWBeJds1gqKNeyhByaKnXg0dvyK6nU4pzH
oGe+VQL0ma3q/Eib3tQS2tuYYLkMMM99PhIMxk8P9WojRa/J2VbyglzKjjl1KBvq
b7cJWZp39N/bIfHQVp5Ls9JnbTmX7SaYYYdkd1MEgzTIALWLXxAeI2l3E58FKM4s
osG713iPQ2SzD+d/Mv8pvusCxqlWcL5bxA6ACylPgmvhdvcxZPCZ/p/sAp4gq7Ua
64u5qjnZcCNv1btktdUA94nVETMVYk2uNfyL4CO0wiHZeJ0FCpQXQM/kHXnrbXm5
7VGv95nR7LGWzdcVK62H9P4KXhlcgOBr/d8mZvVPiJS1saGGiEC0uyEJ48Q4H/uQ
GwkdtRTnb2a1m3PcJVH1DWFW4WcrUYPU5+Fr2SAbdtacfyTEykAFRAC+A0wJ7Qx4
ISGcp+8C5HSOxx70PfYaUBTd6Yb38v6DzRL01ams5fU4mQSRcC2khtjRiL4Be916
0nZ7HcohZwrIWBw4523f
=akHq
-----END PGP SIGNATURE-----

--=-iFYNKZ56wzxKqDZL4pwT--

