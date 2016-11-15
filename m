From: Pavel Machek <pavel@ucw.cz>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 13:11:01 +0100
Message-ID: <20161115121100.GC7018@amd>
References: <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
 <20161115111154.GA5482@amd>
 <128aae59-b790-42f1-7d66-81391c9330c3@redhat.com>
 <20161115114859.GA7018@amd>
 <aeccbb02-6e33-390c-d72d-2a580dd67ed8@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aeccbb02-6e33-390c-d72d-2a580dd67ed8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-11-15 13:06:14, Hans de Goede wrote:
> Hi,
>=20
> On 15-11-16 12:48, Pavel Machek wrote:
> >Hi!
> >
> >>>>>The LED you are talking about _has_ a trigger, implemented in
> >>>>>hardware. That trigger can change LED brightness behind kernel's (and
> >>>>>userspace's) back. Don't pretend the trigger does not exist, it does.
> >>>>>
> >>>>>And when you do that, you'll have nice place to report changes to
> >>>>>userspace -- trigger can now export that information, and offer poll=
()
> >>>>>interface.
> >>>>
> >>>>Well, that sounds interesting. It is logically justifiable.
> >>>
> >>>Thanks.
> >>>
> >>>>I initially proposed exactly this solution, with recently
> >>>>added userspace LED being a trigger listener. It seems a bit
> >>>>awkward though. How would you listen to the trigger events?
> >>>
> >>>Trigger exposes a file in sysfs, with poll() working on that file
> >>
> >>Hmm, a new file would give the advantage of making it easy for
> >>userspace to see if the trigger is poll-able, this is likely
> >>better then my own proposal I just send.
> >
> >Good.
> >
> >>>(and
> >>>probably read exposing the current brightness).
> >>
> >>If we do this, can we please make it mirror brightness, iow
> >>also make it writable, that will make it easier for userspace
> >>to deal with it. We can simply re-use the existing show / store
> >>methods for brightness for this.
> >
> >Actually, echo 0 > brightness disables the trigger, IIRC. I'd avoid
> >that here, you want to be able to turn off the backlight but still
> >keep the trigger (and be notified of future changes).
>=20
> True, that is easy to do the store method will just need to call
> led_set_brightness_nosleep instead of led_set_brightness, this
> will skip the checks to stop blinking in led_set_brightness and
> otherwise is equivalent.
>=20
> >>I suggest we call it:
> >>
> >>trigger_brightness
> >>
> >>And only register it when a poll-able trigger is present.
> >
> >I'd call it 'current_brightness', but that's no big deal. Yes, only
> >registering it for poll-able triggers makes sense.
>=20
> current_brightness works for me. I will take a shot a patch-set
> implementing this.

Thanks!
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgq+1QACgkQMOfwapXb+vJrRwCgwC82RVJe93E7l5TGTrHH741K
yPoAn1I/Bq9lIPI5cEw5Fq0gRIWlwvfm
=A/33
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
