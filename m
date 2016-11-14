From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM regression with LED changes in next-20161109
Date: Mon, 14 Nov 2016 09:31:18 +0100
Message-ID: <20161114083118.GC18123@amd>
References: <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd>
 <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <4c31faef-144d-289c-0e32-83e76aff6178@gmail.com>
 <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Also, how would we read the
> >brightness set by the firmware? We'd have to read brightness
> >file, so still two files would have to be opened which is
> >a second drawback of this approach.
>=20
> No, look carefully at the definition of the read behavior
> I plan to put in the ABI doc:
>=20
> "Reading this file will return the actual led brightness
> when not blinking and no triggers are active; reading this
> file will return the brightness used when the led is on
> when blinking or triggers are active."

That's not sane semantics. Userspace would have to read three files
(racy) to find out about triggers etc.

It also prevents modelling
"hardware-changes-brightness-behind-kernel's-back" as a trigger.

> So for e.g. the backlit keyboard case reading this single
> file will return the actual brightness of the backlight,
> since this does not involve blinking or triggers.

Stop obsessing about "ingle file". FDs are pretty cheap. This is sysfs.

> >Having no difference in this area between the two approaches
> >I'm still in favour of the read-only file for notifying
> >brightness changes procured by hardware.
>=20
> That brings back the needing 2 fds problem; and does

Actually you have turned "2 fds" into "3 fds", as userspace now needs
to check for trigger _and_ blinking _and_ actuall brightness.

fds are cheap, but that is still not nice design.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgpdlYACgkQMOfwapXb+vIkYACgtVPOC9Kr1Efm9jsfmzK5tMcY
XaoAnjqyKsfaM75+aJJQlBtcf0yHjNRM
=QPq+
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
