From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sun, 23 Dec 2018 12:10:59 +0100
Message-ID: <20181223111059.GB1936@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181223103315.GA1936@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181223103315.GA1936@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So the little elves have been slowly working to get voice calls
> > working on droid 4 with the mainline kernel. And just in time for the
> > upcoming holidays, it might be possible to call friends and relatives.
> >=20
> > I've pushed out an experimental branch containing serdev ts 27.010
> > UART multiplexing support. That contains a serdev core driver for the
> > mdm6600 modem (that also now idles the modem for PM), support for Alsa
> > ASoC voice codec and mixer, and a GNSS driver for the GPS.
> >=20
> > Where it does not make sense to do a kernel serdev driver, I've
> > exposed the rest of the available 27.010 channels as ten /dev/motmdm*
> > character devices. There's /dev/motmdm1 for AT commands to dial voice
> > calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
> > card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
> > echo channel. The other channels are still a bit of a mystery.
>=20
> I suspected it does not work in non-modular case, so I tried with
> modules:
>=20
> root@devuan:/my/ko# insmod gnss.ko
> root@devuan:/my/ko# insmod gnss-motmdm.ko
> insmod: ERROR: could not insert module gnss-motmdm.ko: Unknown symbol
> in module
> root@devuan:/my/ko# insmod n_gsm.ko
> root@devuan:/my/ko# insmod snd-soc-motmdm.ko
> insmod: ERROR: could not insert module snd-soc-motmdm.ko: Unknown
> symbol in module
> root@devuan:/my/ko# insmod motorola-mdm.ko
> root@devuan:/my/ko# insmod snd-soc-motmdm.ko
> root@devuan:/my/ko# insmod gnss-motmdm.ko
> root@devuan:/my/ko#
=2E..
> ...do I need to make devices manually or some udev rules?
>=20
> user@devuan:~$ cat /proc/devices | grep motmdm
> user@devuan:~$ cat /proc/devices | grep gnss
> 242 gnss
> user@devuan:~$
>=20
> Hmm, I suspect the driver just did not recognize the hw.

I added some printks to motmdm_probe, and they don't appear to be
called. I wonder if I'm missing something else in the config? I do
have serial

root@devuan:/my/ko# ls -al /dev/ttyS0
crw-rw---- 1 root dialout 4, 64 Dec 23 11:52 /dev/ttyS0

but not gsm multiplex:

root@devuan:/my/ko# ls -al /dev/gsm*
ls: cannot access '/dev/gsm*': No such file or directory

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwfbUMACgkQMOfwapXb+vKZHQCeNefJ1BfW14OTPUPbUGyrEQLp
TiIAoMG6H8Rs+z5a5HC0j0/fkLwIp3Zc
=g5Nn
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
