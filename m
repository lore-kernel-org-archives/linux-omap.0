From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: bq24190_charger: Check the interrupt status
 on resume
Date: Sun, 22 Jan 2017 02:51:34 +0100
Message-ID: <20170122015134.rhzckezpkxy5odla@earth>
References: <20170120220440.1971-1-tony@atomide.com>
 <20170120220440.1971-2-tony@atomide.com>
 <CAKvHMgRipKyVAF6Y6Wr3t=McPouqfC2B9KuAnM+RFUtE-LRtuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qpue4qonvppgxlzl"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgRipKyVAF6Y6Wr3t=McPouqfC2B9KuAnM+RFUtE-LRtuw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org


--qpue4qonvppgxlzl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 21, 2017 at 12:08:02AM -0800, Liam Breck wrote:
> > +static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> > +{
> > +       struct bq24190_dev_info *bdi =3D data;
> > +
> > +       bdi->irq_event =3D true;
> > +       pm_runtime_get_sync(bdi->dev);
>=20
> Do we need to call pm_runtime_irq_safe() prior to the above?

It's not needed here, since the irq handler does not run in
irq context (it's a threaded irq handler).

Btw. calling pm_runtime_irq_safe() basically means, that your
driver's power-management is broken:

http://lxr.free-electrons.com/source/drivers/base/power/runtime.c#L1288

(The relevant part is: =BBIt also causes the parent's usage counter to
be permanently incremented=AB)

> > +       bq24190_check_status(bdi);
> > +       pm_runtime_put_sync(bdi->dev);
> > +       bdi->irq_event =3D false;
> >
> >         return IRQ_HANDLED;
> >  }

-- Sebastian

--qpue4qonvppgxlzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliEECMACgkQ2O7X88g7
+pr7Kw/+LflTSO1F8dm3+63JTdNivzOJH0XZPIY7Mj8Tz0Y7FTPLpZKf5iYiiApu
5xENT1XQsPM3QKZQ45zJdpZJslkfX2n7Q+iQwLzpgwxIXPkyNhjsOZPqiW3BO7zU
5hbYNcC3MJqExs+ArzMviZYc2yNQNg+9qDba/vi7Xvqf74zfktsi6QDauie06Up1
EdwOOFyuOMqsvJgaO0/dlSCkVmylgYskZLh4C/xbCbOXW+UD/ai5LkTP3iMaJ06P
IH7ADQ2E7L/UtpakHkqYMQ7B8d2F4vjhklDwjQypb2myrTiyf+7MlME589eFZp90
E4ndOs63D0bwAOY8bqw4hfehYj0EqTxqb+typJIYeIgSG2cV/dNlPLLBnydKwq06
Dpy4eun1+MNHqArnPg/BxpBQE56UL4tFlIGEt9JO1iQH3f1n/NZUXH9RPCdgtR5P
epKGSwLaD6x5pJu9si/YfyIkSGmTyFOf/FPpy27Y3zndwCJVznYbbEPTn/lwYokp
uy5n+youYiqFiYhlnIlZalerXHuCej/Ek7g5RdqTG15PvexSxNi3xoPJuPXuMi0y
J7Bs6IwKlXpn3XZL5reFeflSRjcX8AKUs1u11eLfr+04FxlhWLHY5tQ26LkO7EaV
lhx+EYQh7Ykqf4F4b5ECUq25XnQE3Jy5bwxltPuOO5YQ66OnaX0=
=yRZa
-----END PGP SIGNATURE-----

--qpue4qonvppgxlzl--
