From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Wed, 28 May 2014 09:31:00 +0300
Message-ID: <538582A4.7070104@ti.com>
References: <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com> <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com> <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com> <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com> <537C9FC6.8020104@ti.com> <20140521145053.GG17417@atomide.com> <20140527205910.GE32336@atomide.com> <20140527211405.GF32336@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8q648nsAKHHOlXkUwrQ0HvkPAq3dle5RN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50029 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbaE1Gbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 02:31:36 -0400
In-Reply-To: <20140527211405.GF32336@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

--8q648nsAKHHOlXkUwrQ0HvkPAq3dle5RN
Content-Type: multipart/mixed;
 boundary="------------070109090406040702030004"

This is a multi-part message in MIME format.
--------------070109090406040702030004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/05/14 00:14, Tony Lindgren wrote:

> FYI, I'm getting this with current linux next:
>=20
> omapfb omapfb: failed to allocate framebuffer
> omapfb omapfb: failed to allocate fbmem
> omapfb omapfb: failed to setup omapfb
> omapfb: probe of omapfb failed with error -12

You need the attached patch to fix linux-next's dma alloc.

 Tomi


--------------070109090406040702030004
Content-Type: text/x-patch;
 name="0001-mm-compaction-properly-signal-and-act-upon-lock-and-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-mm-compaction-properly-signal-and-act-upon-lock-and-.pa";
 filename*1="tch"

=46rom 88275fcdf6e7545e66fe35b822a41c9c017656f2 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 May 2014 10:18:56 +0200
Subject: [PATCH]=20
 mm-compaction-properly-signal-and-act-upon-lock-and-need_sched-contentio=
n-fix2

Step 1: Change function name and comment between v1 and v2 so that the re=
turn
        value signals the opposite thing.
Step 2: Change the call sites to reflect the opposite return value.
Step 3: ???
Step 4: Make a complete fool of yourself.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/compaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a525cd47a9d5..51750197db11 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -237,13 +237,13 @@ static inline bool compact_should_abort(struct comp=
act_control *cc)
 	if (need_resched()) {
 		if (cc->mode =3D=3D MIGRATE_ASYNC) {
 			cc->contended =3D true;
-			return false;
+			return true;
 		}
=20
 		cond_resched();
 	}
=20
-	return true;
+	return false;
 }
=20
 /* Returns true if the page is within a block suitable for migration to =
*/
--=20
1.9.1


--------------070109090406040702030004--

--8q648nsAKHHOlXkUwrQ0HvkPAq3dle5RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThYKnAAoJEPo9qoy8lh717P4P/jlGCuWBM9OWvdvzJRFfUExD
28tg5yUHTWMHcSQHpavfH7MwIbFAjAWYtJ8EPSoFnOFSDmzhJ08d689B7ELD1i04
zy5wVof2hspmIzzY+QSuZJk6qtJ0zsBEC3AxNbgxXfDV7t+gTM0P6drzfGneFNvS
MkawJcW7gsrdUTi6IV8wyKkGM2TFJKsZyOYQ9GdU2wNbVECz+UuE1FqZx+fyKSuN
zOkJvA57fEjPuwgZBGMZ1QyWGFdWm7YRGAvShDl0jWHPmNKroqUyJk0Q0shIzpXC
P1wuxkP7R2hbcKp57rvK6Ckb6DYwJY7E6iWaLzZwXESzysgnXvHndit3KGnxwXOJ
24DuFPLYtK36Em1NSJMohRFdImh/qBAdxIesgszerablNv/c62EihPY/NIn+AcD/
OMyx9T0rMcMV9qNjjwPMG1Gcz3Wgr61DK5/rHW6jbdCARbvHnNYvDjftiL683GoI
7AvtXPd5d2JBHPHKIGtkf7tO/JWtsd6yMYe/exb9T/T4yd/Hc2LM31uTh2BdDJIj
wNMTgmjDl6NeNc1NMCIdELuoxFpOjOEA+w5xWYiJCWhNOdQxy41dEm14xusQGyUB
OyFJlfqyronCTLQFwmOKOtPHrZUmO1Y46vS8Tt2IrRmXzfyWiLbkeZhXY/xKQTNc
TtrTpWyY4racgSlriPZa
=/H6q
-----END PGP SIGNATURE-----

--8q648nsAKHHOlXkUwrQ0HvkPAq3dle5RN--
