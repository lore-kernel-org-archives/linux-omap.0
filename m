From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/2] usb: musb: dsps, debugfs files
Date: Tue, 18 Feb 2014 11:03:35 -0600
Message-ID: <20140218170335.GC28506@saruman.home>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
 <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
 <20140218162054.GE9878@saruman.home>
 <20140218165911.GA17486@kroah.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38596 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbaBRRFZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Feb 2014 12:05:25 -0500
Content-Disposition: inline
In-Reply-To: <20140218165911.GA17486@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Bin Liu <binmlist@gmail.com>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kernel@pengutronix.de

--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 08:59:11AM -0800, Greg KH wrote:
> On Tue, Feb 18, 2014 at 10:20:54AM -0600, Felipe Balbi wrote:
> > On Fri, Jan 17, 2014 at 10:22:35AM +0100, Markus Pargmann wrote:
> > > debugfs files to show the contents of important dsps registers.
> > >=20
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > >  drivers/usb/musb/musb_dsps.c | 54 ++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 54 insertions(+)
> > >=20
> > > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsp=
s.c
> > > index 593d3c9..d0a97d6 100644
> > > --- a/drivers/usb/musb/musb_dsps.c
> > > +++ b/drivers/usb/musb/musb_dsps.c
> > > @@ -46,6 +46,8 @@
> > >  #include <linux/of_irq.h>
> > >  #include <linux/usb/of.h>
> > > =20
> > > +#include <linux/debugfs.h>
> > > +
> > >  #include "musb_core.h"
> > > =20
> > >  static const struct of_device_id musb_dsps_of_match[];
> > > @@ -137,6 +139,26 @@ struct dsps_glue {
> > >  	unsigned long last_timer;    /* last timer data for each instance */
> > > =20
> > >  	struct dsps_context context;
> > > +	struct debugfs_regset32 regset;
> > > +	struct dentry *dbgfs_root;
> > > +};
> > > +
> > > +static const struct debugfs_reg32 dsps_musb_regs[] =3D {
> > > +	{ "revision",		0x00 },
> > > +	{ "control",		0x14 },
> > > +	{ "status",		0x18 },
> > > +	{ "eoi",		0x24 },
> > > +	{ "intr0_stat",		0x30 },
> > > +	{ "intr1_stat",		0x34 },
> > > +	{ "intr0_set",		0x38 },
> > > +	{ "intr1_set",		0x3c },
> > > +	{ "txmode",		0x70 },
> > > +	{ "rxmode",		0x74 },
> > > +	{ "autoreq",		0xd0 },
> > > +	{ "srpfixtime",		0xd4 },
> > > +	{ "tdown",		0xd8 },
> > > +	{ "phy_utmi",		0xe0 },
> > > +	{ "mode",		0xe8 },
> > >  };
> > > =20
> > >  static void dsps_musb_try_idle(struct musb *musb, unsigned long time=
out)
> > > @@ -369,6 +391,30 @@ out:
> > >  	return ret;
> > >  }
> > > =20
> > > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *g=
lue)
> > > +{
> > > +	struct dentry *root;
> > > +	struct dentry *file;
> > > +	char buf[128];
> > > +
> > > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> > > +	root =3D debugfs_create_dir(buf, NULL);
> > > +	if (!root)
> >=20
> > wrong, you should be using IS_ERR()
>=20
> !root is fine, IS_ERR() will fail if CONFIG_DEBUGFS is not enabled.

in that case, files will be created on parent directory right ? If we
pass a ERR_PTR(-ENODEV), otoh, we will try to dereference it in
__create_file().

--=20
balbi

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTA5JnAAoJEIaOsuA1yqREj2MQAIW8L4tBAHRM8HvRBiU1m9wo
MibNyg1CkCqGq6R/QnbbaCo8faHb77//BmwLtvFKtb6Qy8ymC48WEFyxBeXrxSNw
LkJHAHbybTZlR01B/IDmrObpyMR9QMXz0WgHMCSiMAn8uztnS1Czk1AK9HmENZts
FX0v/0L+uy2pIupCAGPv36o/+8MolqzSCzD89FUnStqrL2h4nClXNLBVK5+uR+cl
GWA/U4mHGNtD8HuQ52RuxkXco9TVxGlgOThueCXy2XaL/gLlphfO93Am2PSvwwGl
8XCQogmKhXqK4rZ45Dup6iiUAOt435DnTQ3TkhgF4LZmDoqHQeu2ZcBpbawgMOyC
UQs6N+4s4rlJtZBl7Khq4N8M1PXIp3eCT0Yfbm/5IMQFGvC+qQewgz6aEXAAfTxr
U+YiBEtJP9JiD5VtuuuVCCyDWzaNy0+P8Piz8CwoaIT/Y5sYukroersoPVgdgB7A
MVSZqQ9YxDjQQYNbCQsGOb8IAjUSODN0zQDsSTrBg+LgMhLhbVF5rBRCxZ0v0TL+
QlFGwmu4c+2vr24OR10TuyBqFcFGEIEUtbFsW8lqCosLjcsst94cOEXtte/iFEmw
ep44TAMsnbrXRTE0zqpLeVtn4kBONVPucTZ3Fc/7VE4onZ3QnTgYzzLxXx5FFk2N
tBUXzT1qrXDav5n2OuV3
=TuQ3
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
