From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sun, 23 Dec 2018 20:59:37 +0100
Message-ID: <20181223195937.GE15237@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181223103315.GA1936@amd>
 <20181223111059.GB1936@amd>
 <20181223155147.GI6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181223155147.GI6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-23 07:51:47, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181223 11:11]:
> > I added some printks to motmdm_probe, and they don't appear to be
> > called. I wonder if I'm missing something else in the config? I do
> > have serial
> >=20
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

I had those enabled.

I also have

CONFIG_SERIAL_OMAP=3Dy
CONFIG_SERIAL_OMAP_CONSOLE=3Dy

> Probably the Kconfig dependency should be for SERIAL_DEV_CTRL_TTYPORT
> instead of SERIAL_DEV_BUS in these patches if that helps.
>=20
> Or else you're missing the serdev related dts changes?

Thanks for the hints, but dts looks ok, too.

We still have
uart1: serial@0 {
   compatible =3D "ti,omap4-uart";

in omap4-l4.dtsi, right? ...

I see that CONFIG_SERIAL_OMAP=3Dy and 8250_omap handles same
hardware. Let me try disabling CONFIG_SERIAL_OMAP=3Dy.

Best regards,
								Pavel

Oh and you may want to apply this:

diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
index 2b7c324..2cdc9e8 100644
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -1141,5 +1152,5 @@ module_serdev_device_driver(motmdm_driver);
=20
 MODULE_ALIAS("platform:motorola-mdm");
 MODULE_DESCRIPTION("Motorola Modem TS 27.010 serdev driver");
-MODULE_AUTHOR("Tony Lindgren <tony@atomide.com");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_LICENSE("GPL v2");


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwf6SkACgkQMOfwapXb+vLc+QCfdzhtFpsJJdQyVDvOhFUBkjXB
UN0An3P/at06sNp/7TZ5GaTB+bYfIYyK
=ZCa/
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
