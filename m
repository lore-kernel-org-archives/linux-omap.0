From: NeilBrown <neilb@suse.de>
Subject: [PATCH] OMAP: DSS: DPI: disable vt-switch on suspend/resume.
Date: Wed, 25 Feb 2015 20:37:08 +1100
Message-ID: <20150225203708.0eb2fa96@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/gBHHyJuWbq6.K2o/BMsTJV/"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/gBHHyJuWbq6.K2o/BMsTJV/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


These devices do not need to return to non-graphic console
for suspend, so disable that option.
This means there is less work to do in the suspend/resume cycle,
making it smoother and cheaper.


Signed-off-by: NeilBrown <neil@brown.name>

--
Hi Tomi,
 I wonder if you would consider this patch too.  It works for me and
removes pointless vt switching.  I assume no-one would need or want that
switching on suspend/resume but I guess I cannot be certain.

Maybe a module-parameter could be used if there was any uncertainty.

thanks,
NeilBrown


diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap=
2/dss/dpi.c
index f83e7b030249..4a29bab4ade3 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/suspend.h>
=20
 #include <video/omapdss.h>
=20
@@ -798,6 +799,8 @@ static int omap_dpi_probe(struct platform_device *pdev)
 	mutex_init(&dpi->lock);
=20
 	dpi_init_output(pdev);
+	/* No need to vt_switch in suspend/resume */
+	pm_set_vt_switch(0);
=20
 	return 0;
 }

--Sig_/gBHHyJuWbq6.K2o/BMsTJV/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVO2XxDnsnt1WYoG5AQJnSA/9FuVfxMQ0MInknzRd07Ws4pVaOsy4OwLC
33XAOFeVRbchprt8Kpl0H1O9U4HTwKANoWPMiWXk5RJ2vDtara5T3UDZgNhXKUoH
hAnXleBFm39G8U6aolnm3zWBVQmVTBVBM9HMad0zjgXzaF+DC1o5PTQZhW85IqS6
OBhtsmMolZwqPEREc4vforYyqlchbPXGQCEcTL6seAk9anP/64qtwHiBYio0ejg8
x3u0WT8kHocehC0zwYERfSslCv+TkhMeySXL5etQtz5735c2VYqxnQRwOQXZhhFB
D31EmTridLdoyWNJz2e68UUxYsz7AgBxZ9yGAF7XAGK7rxsnhWjxzMNlirridBJA
kICc4FaH88gW9j0GSzIptvCEo2k9+7TZ0IiG6Z8QAN/j1Ro1ah/IKaYNkkZJ48rh
8IME811N4gjdaqIJCjdPt7RmBAPrXKZ8MxD3TcW6Lj7E5kFGpJd+JBA11OttEkYP
QIVeVBmz4J2aPbp53+/LaUZI23LIswMYQWzL8GBmvjmByQf2cysT8dgRv26++kW2
u4dOC53fFt1xWgL05bjiMWzYV1VzhuTz2wJxkiZLkTTqgjaMEVmcAnxeDYpLG5Rp
Q1cIN+KIlxBLhxiEi3AFF1u7hcMSG3x01gKcxvm/IUkzJR30CG/+zXs3VLM0afvb
pSl0V2wod2o=
=+SqM
-----END PGP SIGNATURE-----

--Sig_/gBHHyJuWbq6.K2o/BMsTJV/--
