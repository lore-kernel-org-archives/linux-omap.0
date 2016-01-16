From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: annoying yellow LED while battery is charging (and some progress with free userspace)
Date: Sun, 17 Jan 2016 00:27:38 +0100
Message-ID: <201601170027.38572@pali>
References: <20160116232222.GB10962@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1692262.9gHQnK86oD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160116232222.GB10962@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

--nextPart1692262.9gHQnK86oD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 17 January 2016 00:22:22 Pavel Machek wrote:
> Hi!
>=20
> While battery is charging, 3 color LED produces yellow light.. at
> quite high intensity, which makes screen unpleasant to look at (with
> 4.4 kernel).
>=20
> I'm pretty sure original Maemo did not try to blind me.
>=20
> It looks like CHRG_IND signal goes from charger to LEDs, and
> BOOT_MODE pin may be involved.
>=20
> Any idea how to get rid of the light?

echo 0 > /sys/class/power_supply/bq24150a-0/stat_pin_enable

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1692262.9gHQnK86oD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaa0eoACgkQi/DJPQPkQ1LdhQCfUh4qLJVJBhWk43Bd99cDgr7Q
EWcAoLXIsQLoPLsttE2WpV1Fo7pJFHDg
=Zba4
-----END PGP SIGNATURE-----

--nextPart1692262.9gHQnK86oD--
