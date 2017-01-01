From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900 sound driver and ECI GPIOs
Date: Sun, 1 Jan 2017 20:54:54 +0100
Message-ID: <201701012054.54505@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3167152.aDz6BsNo8o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3167152.aDz6BsNo8o
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I'm looking at original Maemo N900 2.6.28 sound driver and GPIOs which
controls A/V jack detection.

=46or reference source code of that driver can be found e.g. at alsa-devel
ML [1] [2] or in my linux-n900 git tree, branch v2.6.28-nokia [3].

In that sound/soc/omap/rx51.c code is function rx51_set_eci_switches()
which configures 2 gpios: RX51_ECI_SWITCH_1_GPIO =3D gpio 178 and
RX51_ECI_SWITCH_2_GPIO =3D gpio 182 based on "eci mode" input parameter.

But in mainline kernel code [4] [5] there is no information about gpio 178
(as RX51_ECI_SWITCH_1_GPIO) and gpio 182 is called as just "eci-switch".
More interesting part is that "eci-switch" gpio is not used in whole
mainline code. It is just referenced in Nokia N900 DTS [4]. Looks like
sound driver in mainline kernel is incomplete.

Jarkko, you are listed as original author of that driver. Do you (or
anybody else) remember what that rx51_set_eci_switches() function is
doing? And what gpio 178 controls? I was even not able to find gpio 178
in RX-51 Schematics [6].

And do you know something about Nokia ECI headsets supports for Nokia
N900. Looks like there is already some kernel code but support for ECI
bus or multibuttons headset is missing.

[1] - http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022=
033.html

[2] - http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022=
039.html

[3] - https://github.com/pali/linux-n900/blob/v2.6.28-nokia/sound/soc/omap/=
rx51.c

[4] - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
arch/arm/boot/dts/omap3-n900.dts#n128

[5] - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
sound/soc/omap/rx51.c

[6] - https://wiki.maemo.org/N900_Hardware_Schematic

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3167152.aDz6BsNo8o
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhpXo4ACgkQi/DJPQPkQ1IOBQCfdbKwfC+C1/Rhuyt18DkV8Kd8
hCgAni56UooiDX6JCEiWva10eS8aNtLK
=739L
-----END PGP SIGNATURE-----

--nextPart3167152.aDz6BsNo8o--
