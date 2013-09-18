From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH usb 1/2] usb: musb: Add missing ATOMIC_INIT_NOTIFIER_HEAD
Date: Wed, 18 Sep 2013 19:03:33 +0200
Message-ID: <201309181903.33243@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <201309181843.49850@pali> <20130918164816.GN21559@radagast>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4760060.bcDtOaWoxX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130918164816.GN21559@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, freemangordon@abv.bg, Aaro Koskinen <aaro.koskinen@iki.fi>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart4760060.bcDtOaWoxX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

&twl->phy.notifier is not initalized

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl403=
0-usb.c
index 8f78d2d..efe6155 100644
=2D-- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct platform_device *pd=
ev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
=20
+	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
+
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
 	 *

--nextPart4760060.bcDtOaWoxX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI53OUACgkQi/DJPQPkQ1KFmQCgi/3vMmkDbDiB9qqmHP2+QuCe
xNYAoIPUJF9y0IMoObc0rvYuOqYLfOeD
=4r1s
-----END PGP SIGNATURE-----

--nextPart4760060.bcDtOaWoxX--
