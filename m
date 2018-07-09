From: Pavel Machek <pavel@ucw.cz>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Date: Mon, 9 Jul 2018 13:16:45 +0200
Message-ID: <20180709111644.GC11785@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
 <20180709103305.GF112168@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709103305.GF112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon 2018-07-09 03:33:05, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180708 19:40]:
> > Ok, so it seems to be:
> >=20
> > user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
> > (oops).
> >=20
> > The file seems to be world-readable.
> >=20
> > user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> > -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> >=20
> > But on PC, that file does not exist.
> >=20
> > Any ideas?
>=20
> I'm not seeing this as tested with omap2plus_defconfig and
> not seeing any unclocked module interrupts here.. Can you
> see if the script below produces something for you?
>=20
> I had to filter out some trace pipes as they seem to hang.

Hmm. Aha, I see what is going on.

Mainline does not have cm_per_dump(), that was some code to debug N900
power management.

Sorry about the noise.

[To my defense, mainline still can not turn on the video on droid4, so
is useless :-(. Could we get that fixed?]

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDRBwACgkQMOfwapXb+vI83gCfXDJ71VWLQoaYMmS9RvkrBSV/
EJMAnjN3FfTIBwswdhEA+hROgoWS9FaY
=JnR+
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
