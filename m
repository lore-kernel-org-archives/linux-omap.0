From: NeilBrown <neilb@suse.de>
Subject: Re: debug needed: twl4030 RTC wakeups: repeated attempts fail on
 Beagle
Date: Sat, 11 Aug 2012 08:27:39 +1000
Message-ID: <20120811082739.6bb66bb0@notabene.brown>
References: <87d32yd1l4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/PV6SU/aj3WhGMhIxPZfG9/e"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42535 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758879Ab2HJW1w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 18:27:52 -0400
In-Reply-To: <87d32yd1l4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Russ Dill <russ.dill@gmail.com>

--Sig_/PV6SU/aj3WhGMhIxPZfG9/e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Aug 2012 11:49:27 -0700 Kevin Hilman <khilman@ti.com> wrote:

> Hello,
>=20
> In doing some automated testing of suspend/resume I noticed that
> repeated attempts to suspend and resume via RTC wakeup fail on
> 3530/Beagle and 3730/Beagle-xM, but work fine on 3430/n900, 3530/Overo,
> 3730/OveroSTORM and 4430/Panda.
>=20
> When RTC wakeup fails, a UART wakeup will work, and in the logs, you'll
> see this:
>=20
> [  316.036132] twl: i2c_read failed to transfer all messages
> [  316.036163] twl4030: I2C error -13 reading PIH ISR
>=20
> My guess about what might be happening is that very late in the suspend
> process (during the noirq hooks), a PMIC interrupt fires, but by this
> time the I2C driver is runtime suspended (and clock gated.)  Since
> runtime PM is disabled at this point, I2C reads fail, so the twl4030 IRQ
> driver cannot talk over I2C to the PMIC to determine the interrupt
> source.

This area seems to be rife with opportunity for bugs.  I wrote about some of
it here:  https://lwn.net/Articles/482345/

I don't know that I saw quite what you are seeing though.

If a PMIC interrupt fires during the noirq phase, the interrupt handler
shouldn't be run (it isn't marked NOSUSPEND).  However there is probably ro=
om
for a race between the 'suspend' phase and the 'noirq' phase.

When the suspend processing handles the I2C device, the last thing that
__device_suspend does is

		__pm_runtime_disable(dev, false);

which will freeze the current runtime_pm state of the I2C device.  If it is
off, it stays off.  If on, it stays on.

As the noirq phase hasn't been entered yet an interrupt from the PMIC could
still be handled.  If it is, you get exactly the error you see.

I'm not convinced that the __pm_runtime_disable call is correct.  It think =
we
need to stop async runtime_suspends, but we don't need to stop sync
runtime_resumes. So just a pm_runtime_get should be enough.  But there  is
possibly an important point I am missing.

However if my analysis is correct, then this can be 'fixed' by changing the
omap i2c suspend routine to do a pm_runtime_get, and the resume routine to =
do
a pm_runtime_put.  The I2C will still be put to sleep during suspend by the
noirq suspend handler, but we will be sure of it being awake during the
crucial suspend and resume transition.
See also https://lwn.net/Articles/505683/.  Particularly (towards the end)

    If the device might be needed to power down other devices, such as an I=
2C
    controller that might be needed to tell some regulator to turn off, the=
n the
    device should be activated for runtime PM purposes so that it will stil=
l be
    active when runtime PM is disabled.=20

(Rafael reviewed this article so it shouldn't be very far from the mark).


>=20
> The real mystery is why this happens on Beagle and Beagle-xM, but none
> of the other OMAP3 boards (at least the ones I have.)

Maybe didn't components of the PMIC are active and have the potential to
generate an interrupt at an awkward time.  USB and battery chargers seem go=
od
at that.

Or maybe due to the particular components active and the particular timing,
the pm_runtime_disable ends up freezing the runtime_pm state in 'on' rather
than 'off'.

>=20
> Reproducing is easy.  Simply run rtcwake in a loop:
>=20
>   # while true; do rtcwake -m mem -s 1; done
>=20
> In my tests, this happens using omap2plus_defconfig (+ initramfs) on
> v3.6-rc1, v3.5, v3.4, v3.3 but seems to work fine on v3.2.
>=20
> I'm going on vacation for a few weeks, so any help debugging this would
> be greatly appreciated.=20

Enjoy your vacation!   I don't suppose it ends up in San Diego in late Augu=
st
for one of the multitude of conferences there?

NeilBrown



--Sig_/PV6SU/aj3WhGMhIxPZfG9/e
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBUCWK2znsnt1WYoG5AQKfMw//enyfd2qU7aFml09k1mcEjeqHqqTKdH0s
fowiQ9MyCYvL1kzJ7non5An3lPKpZ/cN1Z7fErNR6COLZJ+Qj+ancTjdIUpZkQJ5
FLfCouznwZw+qUpn3jCbQXjr2BlonBYLHsJWkDK4fPxshH3f1GiIGUx5NSRdIJpp
g6TNnN6rt9iB/9DZOy2zaQVk7/oZg+N7EHdPAv7AcPjMQSQAVbbOjuni4xVEIzhh
RRusTrT3RuSmsS/YVPH4dOuVWtihGBqtGhChqVZ9ge/mXpvObg0yEsOuskB1DzV5
oyEz0J7qpZErgBzhfJ9Y4wAutafGmrkurs6TJVMJlUMKQNhPK/npEkh+6WE1j9wp
O4THFCGVOxdjmWJIEDDtJRRbkuiTOCqI/4rbzCjcOnLrlzPUt6BuQy6y5wBKaTdM
gobqcSkb0WJyLSxlOpX8Ogt+XiD6GC2WlcxdO66V++QxNoYiKFXEaQenj50Cxwp7
zCwj1TEr0C0QB3vTeuqegvsnLpgYy2DPHXNHlhVwDcxFxv3En2t9IQHP5qzqXUK3
I3H7WmRe3tz8URY16h/EOPFD3ICXXmoHwgbeDp+X1Zhc7/bIe8TPZqiyY3tTgr6h
xuX2Zfg+LG8LleTm6Ahi5VQJYoKtSWCHNn/IjvWx8XibR9O9xH7zwa5YpdUB0WLj
4gClv/lSEZA=
=SsZg
-----END PGP SIGNATURE-----

--Sig_/PV6SU/aj3WhGMhIxPZfG9/e--
