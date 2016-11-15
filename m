From: Pavel Machek <pavel@ucw.cz>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 12:11:54 +0100
Message-ID: <20161115111154.GA5482@amd>
References: <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-11-15 11:58:06, Jacek Anaszewski wrote:
> On 11/15/2016 11:31 AM, Pavel Machek wrote:
> >Hi!
> >
> >>>Hmm, v4 still calls led_notify_brightness_change(led_cdev)
> >>>from both __led_set_brightness() and __led_set_brightness_blocking().
> >>
> >>Ugh, I see I accidentally send a v4 twice, instead of
> >>calling the version which dropped those called v5 as
> >>I should have, sorry.
> >>
> >>The v4 which I would like to see merged, the one with
> >>those calls dropped, is here:
> >>
> >>https://patchwork.kernel.org/patch/9423093/
> >
> >Please, lets fix this properly.
> >
> >The LED you are talking about _has_ a trigger, implemented in
> >hardware. That trigger can change LED brightness behind kernel's (and
> >userspace's) back. Don't pretend the trigger does not exist, it does.
> >
> >And when you do that, you'll have nice place to report changes to
> >userspace -- trigger can now export that information, and offer poll()
> >interface.
>=20
> Well, that sounds interesting. It is logically justifiable.

Thanks.

> I initially proposed exactly this solution, with recently
> added userspace LED being a trigger listener. It seems a bit
> awkward though. How would you listen to the trigger events?

Trigger exposes a file in sysfs, with poll() working on that file (and
probably read exposing the current brightness).

Key difference is that only triggers where this makes sense (keyboard
backlight) expose it and carry the overhead. CPU trigger would
definitely not do this.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgq7XkACgkQMOfwapXb+vKutQCfYxrl1Z8VQqpuTfJOpRAQSZEp
kvAAmQGKQf5bDFRcHyCi/wIP2QKPb99S
=dZ2q
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
