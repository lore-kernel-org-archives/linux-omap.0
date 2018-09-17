From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Date: Mon, 17 Sep 2018 20:56:34 +0200
Message-ID: <20180917205634.6a320cad@aktux>
References: <20180917052254.12336-1-andreas@kemnade.info>
        <20180917175131.GA104770@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_BaF6VuUb2T=xBhucJeMtCQ"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917175131.GA104770@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/_BaF6VuUb2T=xBhucJeMtCQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, 17 Sep 2018 10:51:31 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Andreas,
>=20
> On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:
> > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > the counter will be incremented but the resume callback not called,
> > so enumeration and charging will not start properly.
> > To avoid that happen, wait and try again later.
> >=20
> > Practically this happens when the device is woken up from suspend by
> > plugging in usb.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4=
030-usb.c
> > index a44680d64f9b..1f3cf4e48383 100644
> > --- a/drivers/phy/ti/phy-twl4030-usb.c
> > +++ b/drivers/phy/ti/phy-twl4030-usb.c
> > @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *=
_twl)
> > =20
> >  	status =3D twl4030_usb_linkstat(twl);
> > =20
> > +	/* we might get here too early when runtime is not ready yet
> > +	 * and we will get an EACCESS later, so try again later
> > +	 */ =20
>=20
> How exactly can this happen? What disables (and later re-enables)
> runtime PM?=20
If the whole resume process is started by plugging in usb, the
interrupt will be triggered still in the resume process so that=20
runtime resume is not yet possible, pm_runtime_get_sync() returns
EACCESS

> How can we guarantee that the interrupt will be
> re-triggered?
>=20
The interrupt will not be re-triggered but the handler will be
called at some other places...

> > +	if (!pm_runtime_enabled(twl->dev)) {
> > +		cancel_delayed_work(&twl->id_workaround_work);
> > +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> > +		return IRQ_HANDLED;
> > +	}
> > +
... for example by this delayed work which is already there.

Regards,
Andreas

--Sig_/_BaF6VuUb2T=xBhucJeMtCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluf+OIACgkQfb1qx03i
kyRQxRAAp2oiba12dAqVJ0koPsr4bVmUmFxie9a7uIHvqLPGYyWKqcjqhQ26BX/d
+SjniI1RzTuybPRP4+lp/cvl96BHVRJmSj4yMku+oE42BC4JcIX1+v3uTif9oNZ7
io2vF/U/q1cVMLL0NCYLBBIL8K3d51SIBAeHdzD2jGWCcbTlly1zyUR/f15NdKlp
5DJDLcfbLFWpl5zZPac3aKz51ZR6fmqCeKqDdY6vrH1TRXOJpGLiZbtCsO0oGzGj
44wfo0g0FMOiaQ676HLlc49VFJzvArmWI0Q3EPdiyYA9fLbLq7mQwHtGF7FPNf3F
LjShqq0VKYR4QCzTt7qF2Lw8OiVwz7PtRn8j4etwd4czdQS6MKztFZxsilN2qzi3
GekY8iqQYqYqVPXSA25zhkSirEnWIbY6xwMkRJwQu7axfff3Y851rR3jl3M/Ef+y
GEnkCXJIUKenOtZl5T9bqep22FBcq2YO6mHdBIjuK6tW+bYJt5yVmfyBp5lPHMd4
HmwekF2e+XkJhcw8SJ4ELjGQbI+PQ4W4qo8Aqc2wjxXnL55tELpGSlcB53y3JLog
MTNcoB6D837mjjd5NO4lZRTZSp8BfQcDh8jM4DEb9/cpnHon0h+zW/4DRyjjeyE5
rdaMm1RkBPhwIAR0vvGtUYlxCot6QNycF+Lx8xIzIYJFEv4gXi4=
=l+nW
-----END PGP SIGNATURE-----

--Sig_/_BaF6VuUb2T=xBhucJeMtCQ--
