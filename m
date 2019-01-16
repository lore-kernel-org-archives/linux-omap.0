From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Thu, 17 Jan 2019 00:06:02 +0100
Message-ID: <20190116230602.GA3131@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20190116135829.GA10426@amd>
 <20190116145904.GM5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116145904.GM5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yeah the scripts in droid4-sms-tools git repo work for me for sending
> and receiving. They do not work with cdma currently as the format is
> different.
>=20
> Maybe you've managed to change the mode of the modem to queue the
> messages with the at commands to the usb port?

I did not have ttyUSB open during that boot. I hope this kind of
settings does not survive across reboots.

> You are reading and writing to /dev/motmdm9 for incoming sms right?

Yes, I think so. Same one where hex-coded PDU comes.

> > > My logs show that Android uses two different commands for ack.
> > > Either AT+GCNMA=3D1 or AT+CNMA=3D0,0 gets used depending on something
> > > that I have no idea of.. Maybe the network connected?
>=20
> I think AT+GCNMA=3D1 works 3g and AT+CNMA=3D0,0 with cdma. Or it could be
> that one of them is just a delayed ack, I don't know.

Strange. It does not seem to be recognized at all.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/uNoACgkQMOfwapXb+vJkJgCgtVXOjauuirufh27+aE7wL1wK
srwAoKKn3ZrHosTe5XBvcVSlcKcXrF59
=UwGO
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
