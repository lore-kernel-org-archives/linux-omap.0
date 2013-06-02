From: NeilBrown <neilb@suse.de>
Subject: Strange OMAP3 LCD display regression - bisected.
Date: Sun, 2 Jun 2013 16:50:19 +1000
Message-ID: <20130602165019.655da2eb@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/t2wgnXUOCFKwphTty56jHXb"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43238 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab3FBGud (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 2 Jun 2013 02:50:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: Mike Turquette <mturquette@ti.com>, Paul Walmsley <paul@pwsan.com>

--Sig_/t2wgnXUOCFKwphTty56jHXb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Hi Tomi, Rajendra and other,
 I have run into a rather strange regression with the LCD panel display on =
my
 GTA04 (OMAP3630 based phone) that you might be able to help me with.

 I bisected down to two patches, neither of which cause the problem by
 themselves, but both together do.

 They are:

commit bd0f5cc3641cb76ae8fa2cc4924c29da157f8b2d
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Thu Dec 13 14:21:30 2012 +0200

    OMAPDSS: fix TV-out issue with DSI PLL

and=20

commit f7f73aab3d5bd19ba0f72ff00fb6b3be28e1a4d3
Author: Rajendra Nayak <rnayak@ti.com>
Date:   Fri Apr 27 16:27:51 2012 +0530

    ARM: OMAP: clock: Switch to COMMON clk


Yes - rather odd.

The details:
 I'm currently trying to move from a 3.7 kernel on my GTA04 to a 3.10-rc
 kernel (hopefully to have 3.10 fully working by the time it comes out..).

 Once I got it compiling and booting I found that while the display worked
 perfectly at boot, after it has been turned off (ioctl(FBIOBLANK)) and back
 on again, it is all white - no discernible image at all.
 A suspend/resume cycle at this point might bring it back, but it is often
 shimmery (low vsync?) and once it had inverse colours.

 I had noticed that the panel which normally gets a 22153 kHz pixel clock w=
as
 only getting a 21600 kHz clock.  This turned out to be due to the fact
 that dpi_calc_dispc_cb rejects odd divisors, and it used to use a divisor =
of
 '3'.


 I disabled that code and then the screen would wake successfully resume fr=
om
 blank, but there was a strange artefact in the image.  My display has a gr=
ey
 background with some blue text.  On the lines that have text, the grey
 background had a very slight green tinge, especially when viewed at the
 right angle.

 I decided to try bisecting to find the cause of this, because I couldn't
 even begin to guess what it might be.  I found:

commit 2b8318881ddbcb67c5e8d2178b42284749442222
Merge: e81d372 e7f5c9a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Dec 15 13:03:48 2012 -0800

    Merge tag 'fbdev-for-3.8' of git://gitorious.org/linux-omap-dss2/linux
   =20
    Pull fbdev changes from Tomi Valkeinen:
     "OMAPDSS changes, including:


 yes - a merge commit. Neither branch by itself caused the problem but the =
two
 together do.
 I then decided "in for a penny, in for a pound" and proceeded to bisect bo=
th
 branches, merging in the other one at each test point.
 This lead me to the two commits listed above.

  bd0f5cc3641cb76 merged with e81d372 has the problem,
  bd0f5cc3641cb76~1 merged with e81d372 is fine.

 Similarly
  f7f73aab3d5bd19b merged with e7f5c9a has the problem, while
  f7f73aab3d5bd19b~1 merged with e7f5c9a is fine.

 I tried reverting the "OMAPDSS: fix TV-out issue with DSI PLL" patch from
 3.10-rc as below, and it seems to behave better, returning from blank
 properly. This is without disabling the "no odd divisors" code.
 I'm not really sure how it survives suspend, as suspend generally isn't
 reliable for me on 3.10-rc yet - haven't look into why as yet.

 Any help anyone could provide here would be greatly appreciated.  I'm happy
 to run any test patches you would like to suggest.

Thanks,
NeilBrown



diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 757b57f..4d4f775 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -62,7 +62,7 @@ static struct platform_device *dpi_get_dsidev(enum omap_c=
hannel channel)
 	case OMAPDSS_VER_OMAP34xx_ES3:
 	case OMAPDSS_VER_OMAP3630:
 	case OMAPDSS_VER_AM35xx:
-		return NULL;
+//		return NULL;
=20
 	case OMAPDSS_VER_OMAP4430_ES1:
 	case OMAPDSS_VER_OMAP4430_ES2:

--Sig_/t2wgnXUOCFKwphTty56jHXb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUarrKznsnt1WYoG5AQK51g//f0a9kkQVVWG7HsjWRmgb67eW6v06bfqm
kabiQLA9eNHKL4kyz/nU4VU0zZNKa93H53ORpMx1mHbsfm4yzu7E5I8xDcTr/T4i
mV1vuACtJYojrTND6l/fLFfcU4LVXvtn2uVK8krk7qEb/UD3zOv0zfORolFxcuIn
jpRFU3yzgVoWj/gC6n7PrlrKPCxv07m2IwGj4iRVsA3XiJ38jhcT93cx6oPYQCcm
Oshn/p33whHfb2L9OW8nrr4YmoCRlFfiIkD+VrF4Ihpdo3VmEObxkFnEvOvo6sej
M7sK2PdrkLmMOpqCsuqtvK2s5EzGTLvTSLzUwnMufIhFQGT9xJKx3LPIzf6qrNxu
lUmsqHjUr04cYJAlFEsUEGSkiVRmyOnGvTKsSogic8Q79kNaguNcwJ4zSUASytPK
FYTnOK2hmosACsp868nzMEVAigg42DTUthS3XGmy8u9wS04tkKYoWYA58DkCsTvo
EIIVKwRm3MbHQEuq/hJlsXnkiU7cBbdY+fFa24aEyqiITqWwZEauShIYm1mq3vAE
xP8aKhN10JzfpdEheJcUGWN10Ew/ZCe0//ObvjghDECFRravD39ZcMo0cNRFFlbl
kITJVEA4l+bl88bv0QSx4BNmUf00QaqJmF8D3gW4vj5JIxZh0ZurPFRlyBw4CETK
CT57hp9n4PA=
=H0fI
-----END PGP SIGNATURE-----

--Sig_/t2wgnXUOCFKwphTty56jHXb--
