From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] pwm-omap: handle timers not ready in probe
Date: Mon, 16 Jul 2018 09:13:24 +0200
Message-ID: <20180716071323.GB23110@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711142526.dto6iost57zx5t5l@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


When all the drivers are built-in, timers are not ready and probing
fails. Fix that with -EPROBE_DEFFER.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c..debeb70 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_devic=
e *pdev)
 	timer_pdata =3D dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
 		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret =3D -EINVAL;
+		ret =3D -EPROBE_DEFER;
 		goto put;
 	}
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltMRZMACgkQMOfwapXb+vLVigCgpkB4yB+wW9vZ7ybuxDps3BaY
e2AAnRcH9zoGjpmF1x2W20l6djXnwWn4
=8bmD
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
