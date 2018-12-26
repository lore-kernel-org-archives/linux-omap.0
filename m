From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Wed, 26 Dec 2018 22:16:32 +0100
Message-ID: <20181226211631.GA4946@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181223103315.GA1936@amd>
 <20181223111059.GB1936@amd>
 <20181223155147.GI6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181223155147.GI6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > root@devuan:/my/ko# ls -al /dev/ttyS0
> > crw-rw---- 1 root dialout 4, 64 Dec 23 11:52 /dev/ttyS0
> >=20
> > but not gsm multiplex:
> >=20
> > root@devuan:/my/ko# ls -al /dev/gsm*
> > ls: cannot access '/dev/gsm*': No such file or directory
>=20
> Hmm with serdev you should not get /dev/ttyS0, so maybe you're missing:
>=20
> CONFIG_SERIAL_DEV_BUS=3Dy
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy
>=20
> Probably the Kconfig dependency should be for SERIAL_DEV_CTRL_TTYPORT
> instead of SERIAL_DEV_BUS in these patches if that helps.
>=20
> Or else you're missing the serdev related dts changes?

Seems like I was missing the dts changes. I was using kexec (did not
want to replace a working kernel) and that seems to use the old dtb.

gnss0 now seems to work, and I do get some kind of replies from the AT
modem. Thanks!

I'll reply to the original email with bad news and more details...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwj768ACgkQMOfwapXb+vJ9CQCfYe4a1fhaF+W1nM3FIYaeAG29
Y4MAoIF+v1qMrBQr3jNJUGBrovViO21v
=7SMq
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
