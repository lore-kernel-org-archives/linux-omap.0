From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sun, 23 Dec 2018 00:05:05 +0100
Message-ID: <20181222230505.GD15237@amd>
References: <20181217004450.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181217004450.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, little elves!

> So the little elves have been slowly working to get voice calls
> working on droid 4 with the mainline kernel. And just in time for the
> upcoming holidays, it might be possible to call friends and relatives.
>=20
> I've pushed out an experimental branch containing serdev ts 27.010
> UART multiplexing support. That contains a serdev core driver for the
> mdm6600 modem (that also now idles the modem for PM), support for Alsa
> ASoC voice codec and mixer, and a GNSS driver for the GPS.
>=20
> Where it does not make sense to do a kernel serdev driver, I've
> exposed the rest of the available 27.010 channels as ten /dev/motmdm*
> character devices. There's /dev/motmdm1 for AT commands to dial voice
> calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
> card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
> echo channel. The other channels are still a bit of a mystery.

I tried to get access at motmdm, but no:

root@devuan:/home/user# minicom -D /dev/motmdm1
minicom: cannot open /dev/motmdm1: No such file or directory
root@devuan:/home/user# ls -al /dev/motmdm1
ls: cannot access '/dev/motmdm1': No such file or directory
root@devuan:/home/user# dmesg | grep motmd
root@devuan:/home/user# zcat /proc/config.gz | grep MDM
CONFIG_MFD_MOTMDM=3Dy
CONFIG_SND_SOC_MOTMDM=3Dy
CONFIG_PHY_MAPPHONE_MDM6600=3Dy
root@devuan:/home/user# uname -a
Linux devuan 4.20.0-rc7-00304-gde109fe #19 SMP Sat Dec 22 20:16:19 CET
2018 armv7l GNU/Linux
root@devuan:/home/user#

Let me try to enable CONFIG_GNSS_MOTMDM. N_GSM also seems enabled.
=20
Is there anything else I need to enable in .config?

Scary Solstice!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwewyEACgkQMOfwapXb+vLs/wCffXaPd1U9e09MvHGaTdLG/HKQ
t6oAoLCrYIULHPSTQJqejo6Vw1A2FQs7
=Yu1V
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
