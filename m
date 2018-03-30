From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 22:46:44 +0200
Message-ID: <20180330204644.GA1804@amd>
References: <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com>
 <20180330103744.GA17404@amd>
 <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
 <20180330175050.GA26571@amd>
 <20180330180151.GA27494@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330180151.GA27494@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Would you mind sharing those hacks - I would like to play around with
> > > ofonod as well. Maybe I can help with a way forward.
> >=20
> > Okay. Here's less hacky version of the hack, but still using AT
> > commands. You still need to set up udev, as described in the other
> > mail.
> >=20
> > And... it seems I can have a qmi connection, too, but that's topic for
> > other email.
>=20
> This, applied on top of previous patch, gives me some kind of qmi
> connection, AFAICT. I can enable/online a modem, but nothing else
> works.
>=20
> LocationReporting is advertised but does not work. dial-number does
> not work either. But from list-modems, it looks like some kind of
> communication works...

Ok, strange.

So there's ofonod in the maemo-leste already.

user@devuan:~$ /usr/sbin/ofonod -v
1.22

=2E..and it seems to somehow work with the droid 4, in default
configuration, thinking it is "Gobi" modem.=20

user@devuan:/my/ofono$ sudo python2 test/list-modems
[ /gobi_0 ]
    Features =3D sms net rat ussd sim gps
        Emergency =3D 0
	    Powered =3D 1
	        Lockdown =3D 0
		    Interfaces =3D org.ofono.SmartMessaging
		    org.ofono.PushNotification
		    org.ofono.MessageManager
		    org.ofono.NetworkRegistration
		    org.ofono.RadioSettings
		    org.ofono.SupplementaryServices
		    org.ofono.NetworkMonitor org.ofono.MessageWaiting
		    org.ofono.AllowedAccessPoints org.ofono.SimManager
		    org.ofono.LocationReporting
		    org.ofono.VoiceCallManager
		        Online =3D 1
			    Model =3D 196
			        Revision =3D M6600A-SCAUHSZ-3.1.3310T  1
				[Jun 09 2011 17:00:00]
				    Type =3D hardware
=2E..

=2E.. and it seems to kind-of work. Even incoming SMSes work, which I
could not get to work in AT mode. Otoh, voice calls do not, so...

Confused,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+ojQACgkQMOfwapXb+vKtTQCdHy9xyOIrDEAF8CvzuUqzmHei
wuwAoLQnAXPZn3vJuz54lusymybIVXmI
=uQ/Y
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
