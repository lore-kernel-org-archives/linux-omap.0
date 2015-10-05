From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default status for 32k counter
Date: Mon, 5 Oct 2015 14:41:07 -0500
Message-ID: <87io6lf6i4.fsf@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <4815825.NCBBBMgLGf@wuerfel> <20150930141209.GB31865@saruman.tx.rr.com> <22213826.1MtkNIZ6W3@wuerfel> <20151005175230.GG18784@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151005175230.GG18784@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <balbi@ti.com> writes:

> On Wed, Sep 30, 2015 at 11:58:16PM +0200, Arnd Bergmann wrote:
>> On Wednesday 30 September 2015 09:12:09 Felipe Balbi wrote:
>> > On Wed, Sep 30, 2015 at 10:15:25AM +0200, Arnd Bergmann wrote:
>> > > On Tuesday 29 September 2015 15:44:06 Felipe Balbi wrote:
>> > > > All devices should have a default status. Ignoring
>> > > > the arguments if it should be 'okay' or 'disabled'
>> > > > by default, let's set them all the 'disabled' and
>> > > > have boards enable 32k counter.
>> > > >=20
>> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > > >=20
>> > >=20
>> > > The patch looks good, but the description is slightly incorrect:
>> > > There is no reason to list "status=3D'okay'" other than overriding
>> > > the 'disabled' status.
>> > >=20
>> > > I'd phrase it something like:
>> > >=20
>> > > "We want the use of the 32k counter to be a per-board setting,
>> > > so let's disable it by default in each dtsi file and override the
>> > > setting in the boards. Any board that does not wire up the counter
>> > > should leave it disabled".
>> > >=20
>> > > However, if you really want all boards to provide the counter all
>> > > the time, I'd argue that we're better off dropping this patch. We
>> > > use the status=3D"disabled" trick for anything that may or may not
>> > > be working based on the board design, but things that are present
>> > > everywhere don't need this.
>> >=20
>> > okay, so here's the thing. While fiddling with the 32k counter, I noti=
ced
>> > that even though there was no status listed, the thing still initializ=
es
>> > fine. However, when moving 32k to drivers/clocksource and using
>> > CLOCKSOURCE_OF_DECLARE(), 32k would *NOT* probe unless I had an explic=
it
>> > status =3D "okay" in DT.
>>=20
>> Very strange, that sounds like a bug in the clocksource probe code.
>> Can you check how this happens?
>
> seems like something overwrites counter's status field, here's a snippet =
of boot
> log:
>
> [    0.000000] =3D=3D=3D> counter is available ??
> [    0.000000] =3D=3D=3D> no status -> TRUE!!
> [    0.000000] =3D=3D=3D> searching for timer
> [    0.000000] =3D=3D=3D> timer is available ??
> [    0.000000] =3D=3D=3D> no status -> TRUE!!
> [    0.000005] sched_clock: 64 bits at 1000MHz, resolution 1ns, wraps eve=
ry 4398046511103ns
> [    0.000014] clocksource: arm_global_timer: mask: 0xffffffffffffffff ma=
x_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.000047] =3D=3D=3D> searching for timer
> [    0.000051] =3D=3D=3D> timer is available ??
> [    0.000054] =3D=3D=3D> no status -> TRUE!!
> [    0.000307] =3D=3D=3D> searching for counter
> [    0.000311] =3D=3D=3D> counter is available ??
> [    0.000315] =3D=3D=3D> counter status disabled
> [    0.000318] =3D=3D=3D=3D> counter NOT available
>
> note that first time around counter had no status and later it got a stat=
us
> disabled from somewhere.

found it. arch/arm/mach-omap2/timer.c is the culprit:

/**
 * omap_get_timer_dt - get a timer using device-tree
 * @match	- device-tree match structure for matching a device type
 * @property	- optional timer property to match
 *
 * Helper function to get a timer during early boot using device-tree for u=
se
 * as kernel system timer. Optionally, the property argument can be used to
 * select a timer with a specific property. Once a timer is found then mark
 * the timer node in device-tree as disabled, to prevent the kernel from
 * registering this timer as a platform device and so no one else can use i=
t.
 */
static struct device_node * __init omap_get_timer_dt(const struct of_device=
_id *match,
						     const char *property)
{
	struct device_node *np;

	for_each_matching_node(np, match) {
		if (!of_device_is_available(np))
			continue;

		if (property && !of_get_property(np, property, NULL))
			continue;

		if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
				  of_get_property(np, "ti,timer-dsp", NULL) ||
				  of_get_property(np, "ti,timer-pwm", NULL) ||
				  of_get_property(np, "ti,timer-secure", NULL)))
			continue;

		of_add_property(np, &device_disabled);
		return np;
	}

	return NULL;
}

I'll patch this up and drop $subject

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEtJUAAoJEIaOsuA1yqREst0P/j4iFxhOkXXpJ1mxeBqKv76a
4i52T9OljTSPV76Kp2ko7WZ9eP8wYBfkES7ZQANOw0kCQHfWmWNOEWT4wmhsgyb8
si6Al3u/FjP4wKpVYTfhlXfOZ/cvEei4gcz5sA664DkO4dBcfxWGVMiMSfYOWO89
ErdHdTAJcgEF+UOarXDVAQw2zDkUOrcvIEj5O0sWrdUYyRxzhQOPf4+H7PdMlkYD
tj7cKNYWdmgdv1AkviQayMU118WOkRIBv5ja0jg1MLrJdGuFN2ZKg+bW5NuVj2jR
l0Z4DmzTqVoVEuXuyrYBzIM3wuM5/b2y7332m8h2w73o1J07xWER2gk6iy/d7J3y
d2MuAESk+8TGeIm5h1CgKxV8BLv7I/ybUhg2/qN8KMEMxySnLeFfjEy5CB35dAOs
odwWBJHpVXPPpDuWNZGHjEl8nFCM3vIGsbQ5O4ATXGJMhiNjKfFDTre9S34gyEs2
i4f68D2n+E4ekHz5C4V7jj5wThB59PmICXTkG2hWZbkD5qgC/yG8geU7/1xf/Nee
t2wFOgLjvDNciGBSFnMURvOv9syrFRhDLmV5wgfvrB1yNuIJ7ES+tx09ZKQYrbEt
gxOk9nTg3Axr+UcftXv8jI3pEUR4qPznDyc0MzRjpu5r8UYhHBkxKtJ7qE0KFAj7
bppd2X8fAK5fj6abATVq
=er7O
-----END PGP SIGNATURE-----
--=-=-=--
