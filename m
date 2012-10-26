From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 14:42:50 +0300
Message-ID: <20121026114250.GA26342@arwen.pp.htv.fi>
References: <1351238130-7158-1-git-send-email-tim.niemeyer@corscience.de>
 <20121026080342.GA23501@arwen.pp.htv.fi>
 <1351248155.2182.26.camel@herbert.er.corscience.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403Ab2JZLsi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 07:48:38 -0400
Content-Disposition: inline
In-Reply-To: <1351248155.2182.26.camel@herbert.er.corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Niemeyer <tim.niemeyer@corscience.de>
Cc: balbi@ti.com, Linux OMAP List <linux-omap@vger.kernel.org>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2012 at 12:42:35PM +0200, Tim Niemeyer wrote:
> Am Freitag, den 26.10.2012, 11:03 +0300 schrieb Felipe Balbi:
> > Hi,
> >=20
> > On Fri, Oct 26, 2012 at 09:55:30AM +0200, Tim Niemeyer wrote:
> > > Adds support for configuring the omap-gpio driver use autosuspend for
> > > runtime power management. This can reduce the latency in using it by
> > > not suspending the device immediately on idle. If another access takes
> > > place before the autosuspend timeout (2 secs), the call to resume the
> > > device can return immediately saving some save/ restore cycles.
> > >=20
> > > I use a gpio to monitor a spi transfer which occurs every 250=B5s. The
> > > suspend overhead is to high, so almost every second transfer is lost.
> > > This patch fixes that.
> > >=20
> > > Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> > > ---
> > >  drivers/gpio/gpio-omap.c |   23 ++++++++++++++++++-----
> > >  1 files changed, 18 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > > index 94cbc84..92f48cb 100644
> > > --- a/drivers/gpio/gpio-omap.c
> > > +++ b/drivers/gpio/gpio-omap.c
> > > @@ -31,6 +31,7 @@
> > >  #include <asm/mach/irq.h>
> > > =20
> > >  #define OFF_MODE	1
> > > +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
> > > =20
> > >  static LIST_HEAD(omap_gpio_list);
> > > =20
> > > @@ -628,8 +629,10 @@ static void omap_gpio_free(struct gpio_chip *chi=
p, unsigned offset)
> > >  	 * If this is the last gpio to be freed in the bank,
> > >  	 * disable the bank module.
> > >  	 */
> > > -	if (!bank->mod_usage)
> > > -		pm_runtime_put(bank->dev);
> > > +	if (!bank->mod_usage) {
> >=20
> > while at that I would drop this bank->mod_usage nonsense and let
> > power core handle reference counting.
> I looked at it, but i'm unsure about the GPIO_MOD_CTRL_BIT. The
> bank->mod_usage counter prevents omap_gpio_free() to disable the hole
> bank while another gpio is still in use.

pm core's usage count will do the same thing. If you request 6 gpios,
you will have 6 pm_runtime_get(). If you free 5 of those, you will have
5 pm_runtime_put_autosuspend() which will only decrement the counter and
do nothing else.

--=20
balbi

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQinc6AAoJEIaOsuA1yqREwpcP/0gDEccc7VQKvzmMTROkQxnq
4L0lA7oHq4fHwEEbMT86gw9s0Lc8s5pt4IHNEtOlJimAxOBNo9JMqeqv+Z+lwmE8
5XyuD1pvVL8okw3kGQErG/4U9Dl7xzmtAfB7pMn1uxL3KgH7zvz/hz4zRmVC3s+9
PfDOg1/FpMsYhZkBMSLt3FKGUu3I+iHfjC+TQkTkUv2lnjlv09LgGtsnaXdane47
SQZgojC+mwVIRiiwKphd1uWaYzWL5SEkGIn3caqyqIAnlpkpPuJBxvukT0CoaojH
xXUqdPQIVTyJzf06QoV1IRIY/7fVyRY4Twwdx/HpczG4rPXmMxFWgkwZlZnmkqey
CDBbizVYHN+ZRQ+PZhbSyYpzVytplLmoBPeKWkALz7md2xvtsnRMvd8eKb9eObxK
Z5olia5uNe+sAsfR77EAC1Jq/mfcLM+3lBsnZ+1ue971iJv/U5Ve3csZXxI9z5dQ
hfeDqNGhijgOlbEHDjXtgX3IQFBbd5iopQK9V6isaMMd7U4dGj7U0smB03PPQOYA
JZMQ4vrKroOpC+qWcnp4N8LeouvIeaZC6mPt9NLN9c64d+NuaELPscI/Ncts4Y/T
/NY7wlK0YiaXPfZPT/b/23eQQN+09Diqj9D+FowXt8+57J6typ3nNhC0S7cbXN3o
6oPTStzpfYxqNdZV9y/8
=66QR
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
