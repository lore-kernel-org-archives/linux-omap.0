From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Three different LED brightnesses (was Re: PM regression with LED
 changes in next-20161109)
Date: Sun, 13 Nov 2016 21:45:25 +0100
Message-ID: <20161113204525.GA15072@amd>
References: <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd>
 <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <20161111221224.GB10983@amd>
 <3ca04742-6376-5a88-8d10-5b88fcd8f5e5@redhat.com>
 <20161113091054.GA17790@amd>
 <3a3bb3f8-e54a-e7d0-da30-7f90b00c29b3@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a3bb3f8-e54a-e7d0-da30-7f90b00c29b3@redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >No, that's just adding more mess on the system.
> >
> >Here's better proposal:
> >
> >brightness (write): what we do today. (Mess, but too late to change it)
> >	   (read): -Esomething or what we do today (if someone
> >	   	   	       	       	  	   acutally uses it)
>=20
> As said Jacek has already nacked any changes to read behavior.
>=20
> >           (poll): -Esomething
>=20
> Making poll() on sysfs attributes return -Esomething is not possible,
> the internal sysfs API does not allow this.
>=20
> >current_brightness (write): -Esomething, or maybe change brightness
> >		   for triggers that can work with that
> >              (read, poll): if the current trigger can get current
> >	             state of led, do it, otherwise -Esomething...
> >		     or maybe file should be simply hidden from sysfs.
>=20
> So write is -EINVAL and read is the same as what brightness currently doe=
s,
> so I see no use in introducing this new file.

No, read is not same as current brightness file. Currently, reading
brightness file returns either current brightness or maximum
brightness, and userspace can't tell which is which.

> >trigger_max_brightness (read,write): change the maximum brightness for
> >		       a trigger.
> >	       (poll): -Esomething
>=20
> The write behavior here is the same as what brightness currently does
> and the read behavior is that of what I suggested for

No, it is not. "brightness" behaviour is currently broken, as it sets
either current brightness or maximum trigger brightness.

> We've 2 sorts of brightness really:
>=20
> 1) transient brightness, aka current brightness, when blinking or
> triggers are used this will switch many times a second
> between off and some on level.
>=20
> 2) non-transient brightness, for non blinking leds this is the
> actual brightness, for blinking leds this is the brightness
> level used when the led is on.

Yes, and we want reasonable interface where userspace sees those two
brightnesses.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgo0OUACgkQMOfwapXb+vKF8wCggW5FxPc9J+i9Dbc0N473Gfmp
TgYAoJVAyrjIij7H81udzI3QRS9Cyguk
=h1zT
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
