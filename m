From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Thu, 27 Dec 2018 11:16:47 +0100
Message-ID: <20181227101647.GA32260@amd>
References: <20181217004450.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181217004450.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So the little elves have been slowly working to get voice calls
> working on droid 4 with the mainline kernel. And just in time for the
> upcoming holidays, it might be possible to call friends and
> relatives.

Thanks a lot for the Christmas present :-).

> 2. Test a voice call
>=20
> $ minicom -D /dev/motmdm1	# Then Ctrl-a-e to enable local echo
> AT				# Case sensitive AT commands..
> :OK				# Response uses : as separator..
> AT+CFUN=3D1			# Enable radio
> +CFUN:OK
> ~+RSSI=3D1,9,108,99,0,0,0
> ...
> ATD1234567890			# Dial some phone number
> D:OK
> ...
> ATH				# Hang up
> H:OK

Ok, I really need SMS messages, too.

Fortunately, they are on /dev/motmdm9, in PDU format. Quite
logical. And you probably need to acknowledge them, using PDU,
too... (because otherwise you'll just get the same SMS over and over
and over). Which is also logical, but hard to do from shell/python.

Proper solution involves special support for ofonod...


Fortunately ttyUSB4 still works, so I can still use my old code... and
I started logging motmdm1 and 9 to a file as a backup... that should
be better than my existing solution. (But I don't get power benefits
etc.)

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwkpo8ACgkQMOfwapXb+vIwRQCeKWaJOmwziTu0UuqdIxXS0zM4
TckAn1AG9W8Gd8OVMedZPaQqhF2wrxRb
=eDKP
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
