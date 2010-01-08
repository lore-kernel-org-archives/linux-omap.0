From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 14/15] DSS2: Reject scaling settings when they cannot be supported
Date: Fri,  8 Jan 2010 15:22:48 +0200
Message-ID: <1262956969-1664-15-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-12-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-13-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-14-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25342 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab0AHNWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:37 -0500
In-Reply-To: <1262956969-1664-14-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

If the scaling ratio is below 0.5 video output width can't be identical
to the display width. Reject such settings.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/dss/dispc.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
index e2e0f9a..de8bfba 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1454,7 +1454,10 @@ static unsigned long calc_fclk_five_taps(u16 wid=
th, u16 height,
 		do_div(tmp, 2 * out_height * ppl);
 		fclk =3D tmp;
=20
-		if (height > 2 * out_height && ppl !=3D out_width) {
+		if (height > 2 * out_height) {
+			if (ppl =3D=3D out_width)
+				return 0;
+
 			tmp =3D pclk * (height - 2 * out_height) * out_width;
 			do_div(tmp, 2 * out_height * (ppl - out_width));
 			fclk =3D max(fclk, (u32) tmp);
@@ -1634,7 +1637,7 @@ static int _dispc_setup_plane(enum omap_plane pla=
ne,
 		DSSDBG("required fclk rate =3D %lu Hz\n", fclk);
 		DSSDBG("current fclk rate =3D %lu Hz\n", dispc_fclk_rate());
=20
-		if (fclk > dispc_fclk_rate()) {
+		if (!fclk || fclk > dispc_fclk_rate()) {
 			DSSERR("failed to set up scaling, "
 					"required fclk rate =3D %lu Hz, "
 					"current fclk rate =3D %lu Hz\n",
--=20
1.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
