From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] omap2430 musb: Make musb_otg_notification non-blocking
Date: Wed, 25 Jan 2012 11:59:54 +1100
Message-ID: <20120125115954.473de6e7@notabene.brown>
References: <20111230123628.76720567@notabene.brown>
	<20120124085610.GI27414@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/2vGKe/YQAQIZajcdkHggKgi"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59634 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab2AYBAJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 20:00:09 -0500
In-Reply-To: <20120124085610.GI27414@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

--Sig_/2vGKe/YQAQIZajcdkHggKgi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jan 2012 10:56:12 +0200 Felipe Balbi <balbi@ti.com> wrote:

> On Fri, Dec 30, 2011 at 12:36:28PM +1100, NeilBrown wrote:
> >=20
> >=20
> > This callback is on an 'atomic notificaitons' queue but is written
> > as a blocking notifier.
> >=20
> > Convert to use a work-queue to run from non-atomic context.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> doesn't apply.
>=20

It did 1 month ago when I sent it :-)

It seems that commit 712d8efafbbcbe617f9ad706f6ca1ffea4bbf2e8
fixed the same problem already.

The following patch adds a few little bits

Thanks,
NeilBrown



musb/omap2430 minor cleanups.

1/ remove incorrect comment (it is a non-blocking notifier)
2/ Use correct symbolic return value for notifier
3/ Make sure otg_notifier_work is cancelled before module exit.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c27bbbf..df719ea 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -222,7 +222,6 @@ static inline void omap2430_low_level_init(struct musb =
*musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
=20
-/* blocking notifier support */
 static int musb_otg_notifications(struct notifier_block *nb,
 		unsigned long event, void *unused)
 {
@@ -231,7 +230,7 @@ static int musb_otg_notifications(struct notifier_block=
 *nb,
 	musb->xceiv_event =3D event;
 	schedule_work(&musb->otg_notifier_work);
=20
-	return 0;
+	return NOTIFY_OK;
 }
=20
 static void musb_otg_notifier_work(struct work_struct *data_notifier_work)
@@ -386,6 +385,7 @@ static void omap2430_musb_disable(struct musb *musb)
 static int omap2430_musb_exit(struct musb *musb)
 {
 	del_timer_sync(&musb_idle_timer);
+	cancel_work_sync(&musb->otg_notifier_work);
=20
 	omap2430_low_level_exit(musb);
 	otg_put_transceiver(musb->xceiv);

--Sig_/2vGKe/YQAQIZajcdkHggKgi
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTx9UCjnsnt1WYoG5AQLEyg//crPyyW+bub8OBwMHHOWSalIp6MUSqE1K
5Dxp6zcIA5P8gqUgDp2TnndqrnauMYvbWGPs5+lwX7c5Fo39IiDdikZy9grJHYmX
UkzU93DtNg7lLOd2EIAOBACP72XMvl34aXJvEUcp4xtfB8fDr1E31kuxbTSIyclm
I2eGqRcq/jl638duFxAH0ko/h7tpSlj0UvlZ34vZC/sCh7z0wiaFI59a6bMTfttF
vZf6T9PAp1EkTlwHUNq3BDx/WVte8+/ycJJMM7WhGdRDVKHBZE2uTD9ba0toSb52
lbbuk10Xl5y8aJaVzG1GLzZVzSiq11yDF6sAV8cNkAX28oJN9BNoxMiHzagvm9g2
g/YcNsUkpOwekrTpj6uXxOBYdMCHJd/0iHwDn5Y4bjOJE3RM66vhN9tOH24An5A5
agnhmRPIiIvx5jfKV0RkNVre2ejbdgkeVvPT+y5pbY8cytKfw/yxcOiUCSqdj3/y
ECjPm/YR6vGMocynXNC1VNjnx87S+5lIMqLT7LLXPeSl9aX//Skb3/6saRrNRd83
e9Mb/nf3ZEw2fJEbsmrEv6CwziW3B4EDl+BexEFj7Cem1NoeQ7xijURcZUy6aChp
UgoN0lmLnx9fgpXkmriCSsz7RNja5Q3pH0uNdfKfT7O61lDI7hCbyZsM8N1OojSg
7gFp5tG4Dj4=
=eIyT
-----END PGP SIGNATURE-----

--Sig_/2vGKe/YQAQIZajcdkHggKgi--
