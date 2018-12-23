From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sun, 23 Dec 2018 11:33:15 +0100
Message-ID: <20181223103315.GA1936@amd>
References: <20181217004450.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181217004450.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

I suspected it does not work in non-modular case, so I tried with
modules:

root@devuan:/my/ko# insmod gnss.ko
root@devuan:/my/ko# insmod gnss-motmdm.ko
insmod: ERROR: could not insert module gnss-motmdm.ko: Unknown symbol
in module
root@devuan:/my/ko# insmod n_gsm.ko
root@devuan:/my/ko# insmod snd-soc-motmdm.ko
insmod: ERROR: could not insert module snd-soc-motmdm.ko: Unknown
symbol in module
root@devuan:/my/ko# insmod motorola-mdm.ko
root@devuan:/my/ko# insmod snd-soc-motmdm.ko
root@devuan:/my/ko# insmod gnss-motmdm.ko
root@devuan:/my/ko#

But...

root@devuan:/my/ko# ls -al /dev/motmdm*
ls: cannot access '/dev/motmdm*': No such file or directory
root@devuan:/my/ko# ls -al /dev/gnss*
ls: cannot access '/dev/gnss*': No such file or directory
root@devuan:/my/ko#
[  116.244445] gnss: GNSS driver registered with major 242
[  119.892547] gnss_motmdm: Unknown symbol motmdm_register_dlci (err
-2)
[  119.899444] gnss_motmdm: Unknown symbol motmdm_unregister_dlci (err
-2)
[  129.145935] snd_soc_motmdm: Unknown symbol motmdm_register_dlci
(err -2)
[  129.153106] snd_soc_motmdm: Unknown symbol motmdm_unregister_dlci
(err -2)
[  131.120361] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  161.190216] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  191.270263] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  221.360107] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  251.429962] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  281.509643] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  292.816436] g_ether gadget: packet filter 0e
[  292.825256] g_ether gadget: ecm req21.43 v000e i0000 l0

=2E..do I need to make devices manually or some udev rules?

user@devuan:~$ cat /proc/devices | grep motmdm
user@devuan:~$ cat /proc/devices | grep gnss
242 gnss
user@devuan:~$

Hmm, I suspect the driver just did not recognize the hw.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwfZGsACgkQMOfwapXb+vIcYQCfUy7kDvtxOzdHP+CPOOfZJVyt
nm8AoLH/8kE8tMO5XoUq6h6FQVN0c/Hz
=TwGv
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
