From: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Tue, 18 Dec 2018 13:46:16 +0100
Message-ID: <20181218124616.GA10758@amd>
References: <20181217004450.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181217004450.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org


--opJtzjQTFsWo+cga
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

Thanks for doing the work.

I'm quite busy these days, but...

# commit	 64cf2bf6b7614da35028a11974acb5a445dcc535 (patch)
# n_gsm: Use const unsigned char * and size_t
# We can use const unsigned char * and size_t. This makes things
# a bit easier for adding serdev support.
#=20
# Note that gsm_control_modem() gsm_control_rls() read the data
# for tty control characters and then call gsm_control_reply()
# that allocates a new reply and copies the data.
#=20
# REVISIT: Check size_t usage vs int
#=20
# Signed-off-by: Tony Lindgren <tony@atomide.com>

Dunno, I see that you might want const there, but u8 -> unsigned char
seems like a step in wrong direction.

# commit	   cd16272060d8100ef0388349cf88f42a1dc667fc (patch)
# tty: n_gsm: Add support for serdev

Is it worth putting those in separate file? n_gsm_serdev.c?

# commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
# mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like droid4

Oh, that is a lot of fun. Especially state machine for parsing modem
responses. I wonder how well it is going to work when modem is
accessed over USB...=20

motmdm_read_state(... size_t len)

I applied it over my tree (I still need patches for display,
right?). I'm getting

/data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: initializer
element is not constant
/data/fast/l/k/drivers/mfd/motorola-mdm.c:1132:3: error: (near
initialization for 'motmdm_driver.driver.name')
/data/fast/l/k/scripts/Makefile.build:291: recipe for target
'drivers/mfd/motorola-mdm.o' failed

Oh and that mdelay(3000) is going to hurt... especially because
console is initialized very late or d4.

I did a quick test in my config... and it did not break my old setup
-- voice calls still work when set up over USB and with manual mixer
setup. That was good surprise.

Thanks,
									Pavel

diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
index eea754d..2b7c324 100644
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -1129,7 +1129,7 @@ static void motmdm_remove(struct serdev_device *serde=
v)
=20
 static struct serdev_device_driver motmdm_driver =3D {
 	.driver =3D {
-		.name =3D motmdm_driver_name,
+		.name =3D "motmdm",
 		.of_match_table =3D of_match_ptr(motmdm_id_table),
 		.pm =3D &motmdm_pm_ops,
 	},


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwY7BgACgkQMOfwapXb+vIAIACdFimDv6I3DKxlcmcAmyroAyn2
H9MAoIfC7hqnXVixy+non3E5WJZXClwH
=CINq
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
