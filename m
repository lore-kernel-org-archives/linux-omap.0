From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH usb 2/2] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Wed, 18 Sep 2013 19:03:34 +0200
Message-ID: <201309181903.34696@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309181843.49850@pali> <20130918164816.GN21559@radagast>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8729124754310589977=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130918164816.GN21559@radagast>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, freemangordon@abv.bg, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============8729124754310589977==
Content-Type: multipart/signed;
  boundary="nextPart2242568.xTFfqbM3Qu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2242568.xTFfqbM3Qu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

More power supply drivers depends on vbus events and without it they not
working. Power supply drivers using usb_register_notifier, so to deliver
events it is needed to call atomic_notifier_call_chain.

So without atomic notifier power supply driver isp1704 not retrieving
vbus status and reporting bogus values to userspace and also to board
platform data functions. Without proper data charger drivers trying to
charge battery also when charger is disconnected or do not start charging
when wallcharger connects.

Atomic notifier in musb driver was used before v3.5 and was replaced with
omap mailbox. This patch adding atomic_notifier_call_chain call from
function omap_musb_set_mailbox.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index f44e8b5..5c40252 100644
=2D-- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -305,6 +305,9 @@ static void omap_musb_set_mailbox(struct omap2430_glue =
*glue)
 	default:
 		dev_dbg(dev, "ID float\n");
 	}
+
+	atomic_notifier_call_chain(&musb->xceiv->notifier,
+			musb->xceiv->last_event, NULL);
 }
=20

--nextPart2242568.xTFfqbM3Qu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI53OYACgkQi/DJPQPkQ1KpXQCfXn4HFtnSZFXIwAl+bEiXjLIt
yVUAn3O5cg2lvS6bW1JsKZeCOUSwgGH4
=7WR8
-----END PGP SIGNATURE-----

--nextPart2242568.xTFfqbM3Qu--


--===============8729124754310589977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8729124754310589977==--
