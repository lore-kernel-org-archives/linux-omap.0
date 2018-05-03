From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Thu, 3 May 2018 11:06:11 +0200
Message-ID: <20180503090611.GA14451@amd>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502144158.GJ98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Anyway, >5.5hours of standby with screen off, GSM on is already
> > usable.
>=20
> Just to rub that in, you do mean GSM usable for voice calls and
> SMS with your unicsy_demo with mainline kernel plus the pending
> LCD related patches, right? :)
>=20
> > This is the core of code I'm using.
> >=20
> > https://github.com/pavelmachek/unicsy_demo
> >=20
> > Battery graphs are attached. I'm not sure if the battery was really
> > close to empty at that point -- voltage curve should have different
> > shape if that was the case.=20
>=20
> Cool. BTW, the value for POWER_SUPPLY_POWER_AVG should be quite
> accurate for the whole device power consumption.
>=20
> It comes from the shunt resistor measured by the PMIC. Sorry I don't
> remember how often it needs to be polled but I'm guessing polling it
> once a minute or so should be plenty.

I'd like current_avg more, but if I cat it manually, it changes on
order of seconds, and quite significantly... which suggest shorter
polling interval would be needed.

user@devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:05 CEST 2018
-71000
-218408
user@devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:06 CEST 2018
-61000
-200238
user@devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:06 CEST 2018
-51000
-209879
user@devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:07 CEST 2018
-56000
-72308
user@devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:08 CEST 2018
-37000
-211362

> Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> by your libbattery and it's low value and high value should be saved
> to a file. Low should be saved when we get the battery low interrupt
> and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
>=20
> Then when you know the high value and low value, you can calculate
> the remaining capacity based on the current value and
> POWER_SUPPLY_POWER_AVG.

I'll look into that... but probably will do experiments with python,
first.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq0QMACgkQMOfwapXb+vLVQwCfQUh3rhVufZcX3VSHSWpuh9U5
IiUAnjdWoOgeIP4u/ynto3KLxU+ywDj8
=Cru+
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
