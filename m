From: NeilBrown <neilb@suse.de>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Thu, 14 Jun 2012 10:15:41 +1000
Message-ID: <20120614101541.39f50aee@notabene.brown>
References: <874nrmtf47.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zOzPlWsYvE7v8jxd3/3WPUZ"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40680 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2FNAPz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 20:15:55 -0400
In-Reply-To: <874nrmtf47.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

--Sig_/zOzPlWsYvE7v8jxd3/3WPUZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrote:

> Hi Grant,
>=20
> Here's the final round of GPIO cleanups for v3.5.  This branch is based
> on my for_3.5/fixes/gpio branch you just pulled.
>=20
> Kevin

Hi.

 I'm not sure if it was this series or the following cleanups which broke
 things for me, but I've been trying 3.5-rc2 on my GTA04 and the serial
 console (ttyO2) dies as soon as the omap-gpio driver initialises.

 After some digging I came up with this patch to gpio-omap.c

@@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct platform_=
device *pdev)
=20
 	platform_set_drvdata(pdev, bank);
=20
+	if (bank->get_context_loss_count)
+		bank->context_loss_count =3D
+				bank->get_context_loss_count(bank->dev);
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);

which fixes it.

What was happening  was that when omap_gpio_probe calls pm_runtime_get_sync,
it calls=20
  _od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runtime_resu=
me
  -> omap_gpio_restore_context

and then the serial port stops.
I reasoned that the context probably hadn't been set up yet, so restoring
from it broke things.
Initialising bank->context_loss_count seems sensible and would ensure that
we didn't try to restore the context until it has actually been lost.

Thanks,
NeilBrown

--Sig_/zOzPlWsYvE7v8jxd3/3WPUZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT9ktLTnsnt1WYoG5AQJpBBAAp2F5n6ClMZb/mGeekSEGvbP0PUTttPcf
GOgQcdfmVtHAwVkbtyXzVovvw5mV65wjEwj5pt3oWqMA9UrALKrYOuzjSOMsGK0Z
rYPv/5m+l1XckA2mAcxentq38K58l4RpGNGbHz7Qy2CI9tmrOwj6xGFZLnRBqB5N
mqSPPamAsHELPixRh02/SGhJ7tDatnbTqL4kWgN86NlgnPE4irqOfFJI3o/EmT0r
9e9AqxFLVsBwlRqeBkudj5seA8DaI3n5q61Inq6eJyZdTL1jFrphlWTozMuV4w4f
FhEiBuEQDSv3FwW0ErngJmHf+ycMwn2t6gYNfWN8U9KKWGVOIetK0AM45gUmI0cB
/CWrmvM+iaEZ9QSvJd900F0EY0ifuepxaW5H3eJh7OW5D1EAyR/b1EGldrOidA5C
Mo4VsSZvGzwRUaASDnAhXH2Cu35BNxWqiaNoVL7uaB+7+pHM8JsJ0a+AnZLw43Yk
zZQ4Njt97u/m2cdnkaArazYaDfTxjaLRk7xHHp5ZYgDvDVByW4igMVNlnJMcRROP
QY1aP9LRPP/8NSDaPUFUNZW3dqPRiWGxrvWYNydsnFOeMkYhWqpFpLwbQdVIuL15
Us6WfmxK0RAEKUpt4sa/svU79NNU1GI1YiYYRKNm8+ecG5yQRjsqCg3hGF9e7aRp
yD+CSkAAKyU=
=S2gR
-----END PGP SIGNATURE-----

--Sig_/zOzPlWsYvE7v8jxd3/3WPUZ--
