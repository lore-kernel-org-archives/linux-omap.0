From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] CBUS Patches
Date: Tue, 14 Jun 2011 17:00:01 +0300
Message-ID: <20110614135959.GN2353@legolas.emea.dhcp.ti.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
 <20110614100643.GM3352@atomide.com>
 <20110614131139.GE23145@atomide.com>
 <20110614131415.GM2353@legolas.emea.dhcp.ti.com>
 <20110614134434.GF23145@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiSnftFthKPM0z4v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33283 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397Ab1FNOAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 10:00:09 -0400
Received: by eyh6 with SMTP id 6so2825796eyh.22
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 07:00:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110614134434.GF23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--YiSnftFthKPM0z4v
Content-Type: multipart/mixed; boundary="6JKsAUbrJhuSllgx"
Content-Disposition: inline


--6JKsAUbrJhuSllgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 14, 2011 at 06:44:35AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110614 06:12]:
> > On Tue, Jun 14, 2011 at 06:11:39AM -0700, Tony Lindgren wrote:
> > >=20
> > > Hmm the second patch "cbus: pass device as argument" breaks
> > > booting on n800. Anyways pushed out already so that will
> > > need to be fixed in a separate patch.
> >=20
> > any good dmesg output for me to take a look at ?
>=20
> Here's the trace with DEBUG_LL + EARLY_PRINTK + earlyprintk in the
> added to the CMDLINE in .config.

fix attached.

--=20
balbi

--6JKsAUbrJhuSllgx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-cbus-retu-initialize-dev-pointer.diff"
Content-Transfer-Encoding: quoted-printable

=46rom e0db8f98be32cd84914b90264abda6777ddffac7 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Jun 2011 16:56:32 +0300
Subject: [PATCH] cbus: retu: initialize dev pointer
Organization: Texas Instruments\n

without it we have a kernel oops when
booting n8x0.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 4b5af58..3f0578b 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -455,6 +455,7 @@ static int __init retu_probe(struct platform_device *pd=
ev)
 	retu->irq_base	=3D pdata->irq_base;
 	retu->irq_end	=3D pdata->irq_end;
 	retu->devid	=3D pdata->devid;
+	retu->dev	=3D &pdev->dev;
 	the_retu	=3D retu;
=20
 	mutex_init(&retu->mutex);
--=20
1.7.6.rc1


--6JKsAUbrJhuSllgx--

--YiSnftFthKPM0z4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN92lfAAoJEAv8Txj19kN173wH+wc+lIMfCKes+Auj0UVJjq21
RqMfodaOZxf7j2Qth98AjIsh6jQC20mI/Wog3aK9oQNgFbFFzi30PtIr10SZSLDG
8ZRefPhWwIp6PWUbET/Tdqzh/EyF3ebY9aIcQGqk3+R4IndNdtE015PGHd/f2dW1
iRzhdiWeZpTmeJKrtmL5bxNTEY2e3DWguUy7kXvoCDDYThpKUUMNHTReU/3FGPMa
Yp6RwNUZ4V8F9Hi5oRnp5dgeWhUsUIk77AXDnCLOMn/E91zaRioOgaNEQzSwyu9W
jzxQvDmhR+NAJZlruxPJBRYeX2Cn7WAQbwSdFuvAX72HYCfRYHq/J6UIxuEq3Ug=
=Y8n5
-----END PGP SIGNATURE-----

--YiSnftFthKPM0z4v--
