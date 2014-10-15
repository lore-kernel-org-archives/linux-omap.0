From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
Date: Wed, 15 Oct 2014 09:41:40 -0500
Message-ID: <20141015144140.GD10888@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <543E64EE.4070104@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44987 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbaJOOmM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 10:42:12 -0400
Content-Disposition: inline
In-Reply-To: <543E64EE.4070104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 15, 2014 at 03:13:34PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 14/10/14 21:28, Felipe Balbi wrote:
> > if we leave __exit annotation, driver can't be unbound
> > through sysfs.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/v=
ideo/fbdev/omap2/omapfb/omapfb-main.c
> > index ec2d132..9cbf1ce 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > @@ -2619,7 +2619,7 @@ err0:
> >  	return r;
> >  }
> > =20
> > -static int __exit omapfb_remove(struct platform_device *pdev)
> > +static int omapfb_remove(struct platform_device *pdev)
> >  {
> >  	struct omapfb2_device *fbdev =3D platform_get_drvdata(pdev);
> > =20
> > @@ -2636,7 +2636,7 @@ static int __exit omapfb_remove(struct platform_d=
evice *pdev)
> > =20
> >  static struct platform_driver omapfb_driver =3D {
> >  	.probe		=3D omapfb_probe,
> > -	.remove         =3D __exit_p(omapfb_remove),
> > +	.remove         =3D omapfb_remove,
> >  	.driver         =3D {
> >  		.name   =3D "omapfb",
> >  		.owner  =3D THIS_MODULE,
>=20
> Interesting. I don't know if I'm doing something funny, but without this
> patch, I can unbind omapfb, kind of.
>=20
> "echo omapfb > unbind" goes ok, but remove is obviously not called.

remove isn't called because it won't exist if it's built-in. Look at the
definition of __exit_p()

> Somehow omapfb device is still unbound from the driver, as I can then
> bind it again, causing probe to be called. Which breaks everything.
>=20
> I would've thought that unbinding is not possible if remove is missing,
> but that doesn't seem to be the case. I guess it just means that remove
> is not called when the driver & device are unbound.

if no remove it provided on platform_driver structure, platform bus
assumes you have nothing to do on your ->remove(), so you end up leaking
all resources you allocated on ->probe() (unless you *really* don't need
to do anything on ->remove).

> We have 18 __exit_p()s in omapdss and related drivers. I guess they are
> all broken the same way.

yup, I should've grepped.

> Note that omapfb unbind & bind does not work even with this patch, but
> results in a crash as some old state is left into omapdss. The same
> happens also with unloading and loading omapfb module (but keeping
> omapdss module loaded).

It worked fine for me. I unbound and bound omapfb multiple times.

> So there seems to be more issues around this.

quite a few more, I'd say

--=20
balbi

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPoekAAoJEIaOsuA1yqREZpMP/0G3EgRfFWOZXhyspHIwIkvW
HQ1f6YeYCttLrCGdKa28STKo1HiJRkI5EVrewuKkimKytl7S88OM22HeaCF61lS+
B9cWEy8GzkBVP7qdwFjX4KFag3Q2tYuqaavd22AkjwuTZu4nNO2KRKzeWBWo3qb8
AKMlLm1La44tcQPjs0pAoTJNJ36hsiavY7RdmNGvthO3WD/o++pDT8JyRuhgPWgm
tHc+JF1VoqDz/gx6mi7F8+pUO60l1pbPmXErIUdtyC8vRHlWQiM+g+UAXK6VSCGa
idkhd/FQFow/sJgl4NiTo3s57obkJmYQXBrQTttWYjpSyiM+Kv+Uz+dj8s+7k3IU
4opCT7IGu/seup7FB/iH0t85apiJXzoxI3J+ZEWcIRkB1dN+NVh5Oo3p/Ovf1cq7
5vBMk+5KwFnDH0RxlWbK287S1A/PLLVkp5UlV5tol4kXxlVWPXarJ+GBKnGru8lN
Ufc/toDPftB0+1LZcvXEUYzU6Fbj5z6+/wq9Ihn9pdZAwEjvP5GdedDhzTfnKekU
uxmI4NM2UdAjaxXmlya1zo5utlG3WW0t2/EkjcVC/itrbOpN9E43bogvG0jHf3Al
Gb4pkqtLoiIvIszkS9INiv4iCQhg6/lBs0W1QS5O8xy3OiX+N6yfEhK57tXO0oH1
ehcL62ehVnidjJqV37WP
=f0Y2
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
