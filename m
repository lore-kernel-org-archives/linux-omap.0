From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 35/58] move omap_wdt's probe function to .devinit.text
Date: Sun, 29 Mar 2009 20:15:28 +0200
Message-ID: <20090329181528.GA25077@pengutronix.de>
References: <20090327232153.GA16348@pengutronix.de> <1238196439-16535-35-git-send-email-u.kleine-koenig@pengutronix.de> <20090329180912.GA6979@infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34053 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbZC2SQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Mar 2009 14:16:27 -0400
Content-Disposition: inline
In-Reply-To: <20090329180912.GA6979@infomag.iguana.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Felipe Balbi <felipe.balbi@nokia.com>, "George G. Davis" <gdavis@mvista.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

Hi Wim,

On Sun, Mar 29, 2009 at 08:09:12PM +0200, Wim Van Sebroeck wrote:
> Hi Uwe,
>=20
> > A pointer to omap_wdt_probe is passed to the core via
> > platform_driver_register and so the function must not disappear whe=
n the
> > .init sections are discarded.  Otherwise (if also having HOTPLUG=3D=
y)
> > unbinding and binding a device to the driver via sysfs will result =
in an
> > oops as does a device being registered late.
> >=20
> > An alternative to this patch is using platform_driver_probe instead=
 of
> > platform_driver_register plus removing the pointer to the probe fun=
ction
> > from the struct platform_driver.
>=20
> Agree with the explanation, but ...
>=20
> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wd=
t.c
> > index 2f2ce74..c9c14dd 100644
> > --- a/drivers/watchdog/omap_wdt.c
> > +++ b/drivers/watchdog/omap_wdt.c
> > @@ -269,7 +269,7 @@ static const struct file_operations omap_wdt_fo=
ps =3D {
> >  	.release =3D omap_wdt_release,
> >  };
> > =20
> > -static int __init omap_wdt_probe(struct platform_device *pdev)
> > +static int __devinit omap_wdt_probe(struct platform_device *pdev)
> >  {
> >  	struct resource *res, *mem;
> >  	struct omap_wdt_dev *wdev;
>=20
> ...imho this would be the correct fix:
>=20
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.=
c
> index aa5ad6e..f271385 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -258,7 +258,7 @@ static const struct file_operations omap_wdt_fops=
 =3D {
>  	.release =3D omap_wdt_release,
>  };
> =20
> -static int __init omap_wdt_probe(struct platform_device *pdev)
> +static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  {
>  	struct resource *res, *mem;
>  	struct omap_wdt_dev *wdev;
> @@ -367,7 +367,7 @@ static void omap_wdt_shutdown(struct platform_dev=
ice *pdev)
>  		omap_wdt_disable(wdev);
>  }
> =20
> -static int omap_wdt_remove(struct platform_device *pdev)
> +static int __devexit omap_wdt_remove(struct platform_device *pdev)
>  {
>  	struct omap_wdt_dev *wdev =3D platform_get_drvdata(pdev);
>  	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM=
, 0);
> @@ -426,7 +426,7 @@ static int omap_wdt_resume(struct platform_device=
 *pdev)
> =20
>  static struct platform_driver omap_wdt_driver =3D {
>  	.probe		=3D omap_wdt_probe,
> -	.remove		=3D omap_wdt_remove,
> +	.remove		=3D __devexit_p(omap_wdt_remove),
>  	.shutdown	=3D omap_wdt_shutdown,
>  	.suspend	=3D omap_wdt_suspend,
>  	.resume		=3D omap_wdt_resume,
Your change is OK, but only "my" part is an important fix.  With
omap_wdt_probe being defined with __init your kernel can oops.
omap_wdt_remove only occupies memory for too long if defined without
__devexit.  That's why I only fixed the first part (with the remove
functions on my todo list though).

Gr=FC=DFle
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
