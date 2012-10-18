From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq
 and _od_resume_noirq
Date: Thu, 18 Oct 2012 20:50:27 +0300
Message-ID: <20121018175027.GA7917@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-2-git-send-email-balbi@ti.com>
 <871ugvivso.fsf@deeprootsystems.com>
 <20121018165525.GA6385@arwen.pp.htv.fi>
 <87ipa7d6cy.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49969 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125Ab2JRR4D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:56:03 -0400
Content-Disposition: inline
In-Reply-To: <87ipa7d6cy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 10:42:37AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > Hi,
> >
> > On Thu, Oct 18, 2012 at 09:34:15AM -0700, Kevin Hilman wrote:
> >> Felipe Balbi <balbi@ti.com> writes:
> >>=20
> >> > current implementation doesn't take care about
> >> > drivers which don't provide *_noirq methods=20
> >>=20
> >> The generic ops handle this.  See below.
> >>=20
> >> > and we could fall into a situation where we would suspend/resume
> >> > devices even though they haven't asked for it.
> >>=20
> >> The following explanation doesn't explain this, so I dont' follow
> >> the "even though they haven't asked for it" part.
> >>=20
> >> > One such case happened with the I2C driver which
> >> > was getting suspended during suspend_noirq() just
> >> > to be resume right after by any other device doing
> >> > an I2C transfer on its suspend method.
> >>=20
> >> In order to be I2C to be runtime resumed after its noirq method has be=
en
> >> called, that means the other device is doing an I2C xfer in its noirq
> >> method.  That is a bug.
> >>=20
> >> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> > ---
> >> >  arch/arm/plat-omap/omap_device.c | 8 ++++++++
> >> >  1 file changed, 8 insertions(+)
> >> >
> >> > diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/o=
map_device.c
> >> > index 7a7d1f2..935f416 100644
> >> > --- a/arch/arm/plat-omap/omap_device.c
> >> > +++ b/arch/arm/plat-omap/omap_device.c
> >> > @@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
> >> >  {
> >> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >> >  	struct omap_device *od =3D to_omap_device(pdev);
> >> > +	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NU=
LL;
> >> >  	int ret;
> >> > =20
> >> > +	if (!pm || !pm->suspend_noirq)
> >> > +		return 0;
> >> > +
> >>=20
> >> you just re implemented pm_generic_suspend_noirq() (c.f. drivers/base/=
power/generic_ops.c)
> >>=20
> >> >  	/* Don't attempt late suspend on a driver that is not bound */
> >> >  	if (od->_driver_status !=3D BUS_NOTIFY_BOUND_DRIVER)
> >> >  		return 0;
> >> > @@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
> >> >  {
> >> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >> >  	struct omap_device *od =3D to_omap_device(pdev);
> >> > +	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NU=
LL;
> >> > +
> >> > +	if (!pm || !pm->resume_noirq)
> >> > +		return 0;
> >>=20
> >> and this is basically pm_generic_resume_noirq()
> >
> > not true, there is a slight different. Note that you only call
> > pm_generic_resume_noirq() after calling pm_runtime_resume()ing the
> > device:
>=20
> >> static int _od_resume_noirq(struct device *dev)
> >> {
> >> 	struct platform_device *pdev =3D to_platform_device(dev);
> >> 	struct omap_device *od =3D to_omap_device(pdev);
> >>=20
> >> 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
> >> 	    !pm_runtime_status_suspended(dev)) {
> >> 		od->flags &=3D ~OMAP_DEVICE_SUSPENDED;
> >> 		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
> >> 			omap_device_enable(pdev);
> >> 		pm_generic_runtime_resume(dev);
> >
> > right here. IMHO this is a bug, if the define doesn't implement
> > resume_noirq, it's telling you that it has nothing to do at that time,
>=20
> This is where the misunderstanding is.  I suggest you have a look
> at commit c03f007a8bf0e092caeb6856a5c8a850df10b974 where this feature
> was added, but I'll try to summarize:
>=20
> The goal is simply this:
>=20
> If, by the time .suspend_noirq has run, the driver is not already
> runtime suspended, then forcefully runtime suspend it.
>=20
> That's it.

Yes, I got the intention, but to me it looks wrong.

> Again, this is required because system suspend disables runtime PM
> transitions at a certain point, if the device is used after that point,
> there is *no other way* for the driver to properly manage the idle
> transition (or, if there is, please explain it to me.)

Can you please let me know of any situation where e.g. I2C/SPI would be
needed after all its children are suspended ?

> > so you shouldn't forcefully resume the device.
>=20
> Note it's only forcefully resumed *if* it was forcefully suspended by
> suspend_noirq.

likewise, you shouldn't forcefully runtime suspend a device. The device
driver needs to be required to provide suspend/resume functions if it
cares.

> > If the device dies, then it means that it needs to implement
> > resume_noirq. What you have here, is a "workaround" for badly written
> > device drivers IMHO.=20
>=20
> That's one way of looking at it.  The other way of looking at it is that
> by handling this at the PM domain level, the drivers can be much simpler,
> and thus less likely to get wrong.

You're still bypassing what the PM framework wants us to do, no ? What
if Rafael decides to drastically change the way system and runtime PM is
done and it ends up breaking what we have on OMAP ? If we stick to the
standard, the it's less likely to brea.

> But even then, with your proposed changes, I don't think the device will
> be properly idled (including the omap_device_idle) in these important cas=
es:
>=20
> 1) I2C is used by some other device *after* its ->suspend method has
>    been called.

how can that happen ? I2C's ->suspend method will only be called after
all its children are suspended.

> 2) I2C runtime PM is disabled from userspace
>    (echo off > /sys/devices/.../power/control)

that should not make a difference if you omap_device_idle() is written
as it should. Maybe what you need is a refactor to provide
omap_device_idle() and omap_device_runtime_idle(), the latter taking
care of the case where runtime pm can be disabled from userspace while
the former idling whenever it's called.

> but I'll take this up in the I2C driver patch itself.

sure :-)

> > Note also, that you could runtime resume devices which don't implement
> > resume_noirq().
>=20
> Again, this is by design.

a very weird design IMHO. Either that or I'm really missing something
here.

> It doesn't matter if the driver has noirq methods.  If it is not yet
> runtime suspended, it is forceably runtime suspended.   The generic

if it's not yet runtime suspended, you need to call the driver's
->suspend_* method (depending on the suspend phase you are right now),
but "reusing" the runtime_suspend method sounds to me like another
"special OMAP requirement".

> noirq calls are just there in case the driver has noirq callbacks.

I get that, but why would you suspend a device which doesn't want to be
suspended in suspend_noirq(), but using its runtime_suspend method ?

If I2C dies on a suspend/resume transition, it's a bug in the I2C
driver, no ?

--=20
balbi

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgEFjAAoJEIaOsuA1yqREopMQAKrnUVmjtLQEN7sUavQQ9z/Q
COCH8KT9vN/jWoGSG0lKk4noi73gu5/AXV7FwGwXUiUqV8L9cT3kuFV+DLE6/Wbm
VCpkUEz2UpY55QeUHdncUwPj1pw3ajxf9efxaQ7hw93vZh9UT/FvjZzjHe+DUmPU
fpZ+YqDPEwUlu5heQAKxEAwrSG/HAIm20DH+efyLlYOep0UKg+h/HcebVbwTMbrH
+UCEUR1AI1kGkRlBz4eh/HhKxrXusO/Fp1SBrSgVKBDvbKhZGUE81GZi58RGgGVc
0PnIC21nU7FTQjkkUTjdoUfr+3yq7AJqkiVkjl1zVWqyzn8u25AFRp440MUytbXN
3UauVc3zBAGwBGyHJ4l7s/Jf9rKcIGbfDZTPmKdlZNiovS6lo8DdRtcqelmDTC46
/d/FKTU/8iBpNRsvZYcPC/N8tEBJvXksw2O0DC22y2wKp3tiv6n5CtqZN7CBYIfE
iGNiL7ASDocW5hvYAd2R0xwH6nu6Kp/A5j7Dif/dmGDZU2lhJnQIIDxFxN4G75RO
NSfzdFq4p/1qrYjM3+O+m7KLPYz0KV9IBQ6Tn24do2dTug1wPeGZR+2bQgqO2GHD
w1MryqeAJ6TNhBxChDcOidQte4LtOmlaoptBCrrjKLEGh41yD/yIlmZDOTe4j6pT
0LcZMdj6PWt3Z4AfunU/
=7WlZ
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
