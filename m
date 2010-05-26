From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] touchscreen: ads7846: please don't touch free'd memory
Date: Tue, 25 May 2010 17:09:13 -0700 (PDT)
Message-ID: <391357.24231.qm@web180309.mail.gq1.yahoo.com>
References: <8739xflkn5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8739xflkn5.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Michael Roth <mroth@nessie.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org



--- On Tue, 5/25/10, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> >> > This is a load of crap. If probe() fails that
> means that driver does not
> >> > manage the device

And thus, dev->driver shouldn't be assigned ...


That probe() looks very odd, lately, yes.  It seems
to have changed a lot over the past few years, and
grown a few fault paths that don't behave right (that
is, they don't clean up properly on failure, or don't
report their faults)...


> >> > and thus ads7846_suspend()
> and ads7846_resume() should
> >> > not be called _at all_.

Those being called is an indication that
the probe() succeeded so the driver is
bound to that device...


 If SPI core manages
> to call random methods from
> >> > the drivers that failed to bind to a device
> that should be fixed in SPI
> >> > core.

Not random methods.  The appropriate ones ... for
the case where probe() succeeded and the device has
been properly set up.


I suspect a bug was added when the driver binding got rewritten, whereb=
y dev->driver was wrongly assigned
on fault paths (where it should have been cleared).
Of course that goes through slightly convoluted bits
of driver model code... maybe there's no such bug,
and everything is explained by probe() misbehaving.


> >> Agreed, this is indeed a bug in the SPI driver
> core.

That's not at all clear to me.

> >> However, by fixing the SPI core to unregister the
> driver on failure
> >> (patch below),

=2E.. as you noted, not a good patch "below".
The issue seems to be on probe() paths, NOT
as part of driver registration.


> we prevent the suspend & resume
> methods from being
> >> called, but the driver's ->remove() method will
> still be called due to
> >> the driver_unregister().=A0 So at least the
> remove() method needs fixing
> >> to prevent accessing free'd memory.

That doesn't seem right; if the issue is probe()
misbehavior, fixing that makes that access issue
go away.  Don't change remove() etc.


 I see two issues.  One
is flakey ads7846 probe() behavior.  Another is
the response of the current SPI core code to that
flakiness ... the report here seems to indicate that
the driver is bound to the device even though it's not
been properly set up ... unclear whether probe() is
reporting a clean failure, I suspect not.  (If it
were reporting a clean failure, the device should
end up with no driver bound.)

It's very possible the probe() errors explain all
the problems.


> >> Unless there are objections, I'll post the below
> along with an updated
> >> version of ads7846 patch.
> >>=20
> >> Kevin
> >>=20
> >> diff --git a/drivers/spi/spi.c
> b/drivers/spi/spi.c
> >> index b3a1f92..42d4d26 100644
> >> --- a/drivers/spi/spi.c
> >> +++ b/drivers/spi/spi.c
> >> @@ -175,6 +175,8 @@ static void
> spi_drv_shutdown(struct device *dev)
> >>=A0=A0=A0*/
> >>=A0 int spi_register_driver(struct spi_driver
> *sdrv)
> >>=A0 {
> >> +=A0=A0=A0 int ret;
> >> +
> >>=A0 =A0=A0=A0 sdrv->driver.bus =3D
> &spi_bus_type;
> >>=A0 =A0=A0=A0 if (sdrv->probe)
> >>=A0 =A0=A0=A0 =A0=A0=A0
> sdrv->driver.probe =3D spi_drv_probe;
> >> @@ -182,7 +184,12 @@ int
> spi_register_driver(struct spi_driver *sdrv)
> >>=A0 =A0=A0=A0 =A0=A0=A0
> sdrv->driver.remove =3D spi_drv_remove;
> >>=A0 =A0=A0=A0 if (sdrv->shutdown)
> >>=A0 =A0=A0=A0 =A0=A0=A0
> sdrv->driver.shutdown =3D spi_drv_shutdown;
> >> -=A0=A0=A0 return
> driver_register(&sdrv->driver);
> >> +
> >> +=A0=A0=A0 ret =3D
> driver_register(&sdrv->driver);
> >> +=A0=A0=A0 if (!ret)
> >> +=A0=A0=A0 =A0=A0=A0
> driver_unregister(&sdrv->driver);
> >
> > This is still wrong. driver_register() should properly
> clean up after
> > itself and not require calls to driver_unregister()
> (and I believe it
> > does).

Right ... driver registration should always be safe.
The tricky bit would be a side effect:  probing any
devices which match that driver.  Don't unregister
drivers on error; just make sure they don't get wrongly
bound to devices if probe() misbehaves.


> >
> > Besides, I do not see how this patch changes anything
> with regard to
> > binding devices and drivers. Even if driver_register()
> succeeds, binding
> > may still fail and we should not be calling neither
> ->remove(), nor
> > ->suspend()/->resume() for the devices that
> failed to be bound.
>=20
> Hmm, good point.
>=20
> After digging into the driver core and realizing that it
> seemed to
> have sane error handling itself,

Sane but somewhat convoluted.  It can be tricky
to figure out.


> I took a closer look at
> ads7846_probe() and discovered it doesn't actually return
> an error
> code for certain failure cases!=A0 That was the root
> cause.

My conclusion too...

> The patch below fixes the problem.

Did you do much of an audit, or just work to fix
this specific problem?  I thought the code was
looking fairly goofy.  Regulator additions were
pretty recent, but it wasn't clear to me that it'd
be the *only* source of such problems...

>=20
> Thanks,
>=20
> Kevin=20
>=20
>=20
>=20
> From 3588494cf6e51754f7089bb8089b99abd765c493 Mon Sep 17
> 00:00:00 2001
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Tue, 25 May 2010 14:38:04 -0700
> Subject: [PATCH] input: touchscreen: ads7846: return error
> on probe failure
>=20
> In probe(), if regulator_get() failed, an error code was
> not being
> returned causing the driver to be successfully bound, even
> though
> probe failed.=A0 This in turn caused the suspend, resume
> and remove
> methods to be registered and accessed via the SPI
> core.

Or more simply:  this was a nasty violation of the
driver model, which lead to breakage.  (The SPI core
is just inheriting driver model/core behavior.)  A
driver that fails to properly bind to the device must
report a probe() failure, ensuring that the driver is
not recorded as being bound to the device...


> =A0 Since these
> functions all access private driver data using pointers
> that had been
> freed during the failed probe, this would lead to
> unpredictable
> behavior.
>=20
> This patch ensures that probe() returns an error code in
> this failure
> case so the driver is not bound.
>=20
> Found using lockdep and noticing the lock used in the
> suspend/resum
> path pointed to a bogus lock due to the freed memory.
>=20
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  drivers/input/touchscreen/ads7846.c |=A0 =A0 4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c
> index 532279c..634f6f6 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1163,8 +1163,8 @@ static int __devinit
> ads7846_probe(struct spi_device *spi)
> =20
>  =A0=A0=A0 ts->reg =3D
> regulator_get(&spi->dev, "vcc");
>  =A0=A0=A0 if (IS_ERR(ts->reg)) {
> -=A0=A0=A0 =A0=A0=A0
> dev_err(&spi->dev, "unable to get regulator: %ld\n",

Adding a requirement for a Vcc regulator seems
likely to have broken lots of boards, FWIW ...


> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0
> PTR_ERR(ts->reg));
> +=A0=A0=A0 =A0=A0=A0 err =3D
> PTR_ERR(ts->reg);

That error should be returned, yes.  (one line
not two; maybe the patch got wrapped somewhere.)

I didn't check to make sure that was sufficient
cleanup though.

- Dave



> +=A0=A0=A0 =A0=A0=A0
> dev_err(&spi->dev, "unable to get regulator: %ld\n",
> err);
>  =A0=A0=A0 =A0=A0=A0 goto err_free_gpio;
>  =A0=A0=A0 }
> =20
>=20
