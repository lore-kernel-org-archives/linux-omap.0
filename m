From: Pavel Machek <pavel@ucw.cz>
Subject: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 11:31:33 +0100
Message-ID: <20161115103133.GA22860@amd>
References: <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <4c31faef-144d-289c-0e32-83e76aff6178@gmail.com>
 <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Hmm, v4 still calls led_notify_brightness_change(led_cdev)
> >from both __led_set_brightness() and __led_set_brightness_blocking().
>=20
> Ugh, I see I accidentally send a v4 twice, instead of
> calling the version which dropped those called v5 as
> I should have, sorry.
>=20
> The v4 which I would like to see merged, the one with
> those calls dropped, is here:
>=20
> https://patchwork.kernel.org/patch/9423093/

Please, lets fix this properly.

The LED you are talking about _has_ a trigger, implemented in
hardware. That trigger can change LED brightness behind kernel's (and
userspace's) back. Don't pretend the trigger does not exist, it does.

And when you do that, you'll have nice place to report changes to
userspace -- trigger can now export that information, and offer poll()
interface.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgq5AUACgkQMOfwapXb+vKkpwCfcis/f6fII+BfuIb/yk30c1FS
eioAn258U0uF+uLGRk6Abj9JlR0Lcvzz
=hiq6
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
