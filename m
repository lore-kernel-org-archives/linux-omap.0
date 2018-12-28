From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sat, 29 Dec 2018 00:25:36 +0100
Message-ID: <20181228232536.GA7355@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228222805.GC6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Pavel Machek <pavel@ucw.cz> [181228 20:46]:
> > I have ofone with direct AT access --
> > https://github.com/pavelmachek/unicsy_demo/blob/master/ofone/at.py .
>=20
> OK thanks, that shows some of the commands I was wondering about.

I had some luck just googling AT commands. They are somehow
standartized.

> > Now, ttyUSB4 provides quite a rich interface, and you can actually
> > select what if you want messages in text and PDU format, and if you
> > want modem to auto-acknowledge messages for you.
>=20
> So which AT command configures auto-ack of SMS? I don't need it,
> just wondering what all these commands do.

So this would be "text mode": AT+CMGF=3D1. And I'd actually expect
auto-ack to be the default on ttyUSB4, but in any case this is the
command that controls it is: AT+CNMI=3D1,2,2,1,0.

>=20
> > What kind of battery life do you get with all the optimalizations?
> > IIRC I was getting 7h with ttyUSB4 in use...
>=20
> With droid4-pending-mdm-v4.20 branch in the following state:
>=20
> - UARTs idled
> - LCD blanked (well no drivers yet droid4-sms-read.rb)
> - MUSB and EHCI USB modules unloaded
> - OHCI loaded with all the children in autosuspend via sysfs
> - WLAN connected
> - busybox acpid stopped (yup, it keeps polling something???)
> - MDM6600 online with AT+CFUN=3D1 on /dev/motmdm1
> - MDM6600 notifications disabled with AT+SCRN=3D0 on /motmdm1
> - droid4-sms-read.rb running
>=20
> I'm seeing droid 4 idle at 119mW according to my power supply.
> So I guess theoretical battery life would currently be
> (1785mWh * 3.8V) / 119mW =3D 57h. But in practise things are not
> completely idle and monitoring sysfs POWER_SUPPLY_POWER_AVG
> every 10 seconds I'm seeing something along these 10 samples:
>=20
> POWER_SUPPLY_POWER_AVG=3D138938
> POWER_SUPPLY_POWER_AVG=3D134571
> POWER_SUPPLY_POWER_AVG=3D505802
> POWER_SUPPLY_POWER_AVG=3D240412
> POWER_SUPPLY_POWER_AVG=3D134252
> POWER_SUPPLY_POWER_AVG=3D132694
> POWER_SUPPLY_POWER_AVG=3D571569
> POWER_SUPPLY_POWER_AVG=3D132694
> POWER_SUPPLY_POWER_AVG=3D190456
> POWER_SUPPLY_POWER_AVG=3D518288
>=20
> So the average based on that sampling is about 270mW and the idle
> time should be about 1785 * 3.8 / 270 =3D 25h, which is quite usable
> already :)

So... 57h would be very nice, and even 25h is cool. IIRC original
motorola firmware does something like 100hours, and cyanogenmod is
closer to 24h...

Note that there's something in the sysfs that allows "precise"
measurements. Aha, it is "charge_counter" on droid4.

(I even have some software to do the monitoring and display the
graphs. unicsy_demo/monitor/batmond).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwmsPAACgkQMOfwapXb+vK2WwCeKIea4YAGqvay75E9BHuB1r73
cgEAoIGlkRXIcPRq4N40FeroyIRbuCWV
=Gb00
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
