From: Pavel Machek <pavel@ucw.cz>
Subject: cpcap-charger: generate events for userspace
Date: Thu, 27 Dec 2018 20:52:21 +0100
Message-ID: <20181227195221.GA11920@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

   =20
The driver doesn't generate uevents on charger connect/disconnect.
This leads to UPower not detecting when AC is on or off... and that is
bad.
   =20
Reported by Arthur D. on github (
https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
Merlijn Wajer for suggesting a fix.
   =20
Cc: stable@kernel.org
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cp=
cap-charger.c
index 9e8ff5c..7d8b4d5 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -576,6 +576,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 			goto out_err;
 	}
=20
+	power_supply_changed(ddata->usb);
 	return;
=20
 out_err:

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwlLXUACgkQMOfwapXb+vLYPgCdGSb1Xix0v8c/98jQt4q0SjNl
aaYAnjX5359IdWTVGczs4aF+UtxlGfeH
=VwT6
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
