From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.18-rc2 on droid4: screen turns red
Date: Wed, 1 Aug 2018 20:58:29 +0200
Message-ID: <20180801185829.GD26087@amd>
References: <20180630131812.GA549@amd>
 <20180711102655.GA6864@amd>
 <20180717062608.GY99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717062608.GY99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > After longer inactivity, attempt to wake up the screen results in
> > > screen being completely red. Not too useful. I can still connect over
> > > ssh.
> >=20
> > Still there in -rc4 :-(. But happens only once in a few days for me...
> >=20
> > When X is shut down, text console works ok.
>=20
> FYI, I've been chasing an occasional hang with lapdock and it might
> be related to the usb phy switching between usb and uart mode
> spontaneously. And then the usb traffic can cause a sysrq trigger
> potentially when the glitch happens. Not sure yet why it happens, it
> might be related to lost cpcap interrupts still.
>=20
> Anyways, so far looks like doing the following may have prevented
> it. Well at least for about four days of uptime now:
>=20
> # echo 0 > /proc/sys/kernel/sysrq
>=20
> And no red screens here yet either. Care to check if this might
> somehow also prevent your red screen issue?

Looks like red screens are pretty seldom :-(. I did not see it since
that report. (But I stopped using Droid 4 as my primary phone after it
lost some SMS.)

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltiAtUACgkQMOfwapXb+vIZTQCghGff94B8JikA+58iqOLxTm5o
QrkAoLs1NDygSxNGMadSDUdsY4DRsEfs
=4APA
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
