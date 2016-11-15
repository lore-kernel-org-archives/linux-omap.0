From: Pavel Machek <pavel@ucw.cz>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 12:48:59 +0100
Message-ID: <20161115114859.GA7018@amd>
References: <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
 <20161115111154.GA5482@amd>
 <128aae59-b790-42f1-7d66-81391c9330c3@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <128aae59-b790-42f1-7d66-81391c9330c3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>The LED you are talking about _has_ a trigger, implemented in
> >>>hardware. That trigger can change LED brightness behind kernel's (and
> >>>userspace's) back. Don't pretend the trigger does not exist, it does.
> >>>
> >>>And when you do that, you'll have nice place to report changes to
> >>>userspace -- trigger can now export that information, and offer poll()
> >>>interface.
> >>
> >>Well, that sounds interesting. It is logically justifiable.
> >
> >Thanks.
> >
> >>I initially proposed exactly this solution, with recently
> >>added userspace LED being a trigger listener. It seems a bit
> >>awkward though. How would you listen to the trigger events?
> >
> >Trigger exposes a file in sysfs, with poll() working on that file
>=20
> Hmm, a new file would give the advantage of making it easy for
> userspace to see if the trigger is poll-able, this is likely
> better then my own proposal I just send.

Good.

> >(and
> >probably read exposing the current brightness).
>=20
> If we do this, can we please make it mirror brightness, iow
> also make it writable, that will make it easier for userspace
> to deal with it. We can simply re-use the existing show / store
> methods for brightness for this.

Actually, echo 0 > brightness disables the trigger, IIRC. I'd avoid
that here, you want to be able to turn off the backlight but still
keep the trigger (and be notified of future changes).

> I suggest we call it:
>=20
> trigger_brightness
>=20
> And only register it when a poll-able trigger is present.

I'd call it 'current_brightness', but that's no big deal. Yes, only
registering it for poll-able triggers makes sense.

> >Key difference is that only triggers where this makes sense (keyboard
> >backlight) expose it and carry the overhead. CPU trigger would
> >definitely not do this.
>=20
> Ack only having some triggers pollable is important.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgq9isACgkQMOfwapXb+vKtuQCgvHtij1gDnqI8i/n0eNiNPOJE
sZwAoIX4eSJQo64CKe7AaQp/DsxTRsnx
=Ur/X
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
