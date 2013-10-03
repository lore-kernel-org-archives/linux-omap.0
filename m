From: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@gmail.com>
Subject: [PATCH] OMAPDSS: HDMI: Correctly compare timings
Date: Thu, 03 Oct 2013 20:45:19 +0200
Message-ID: <1380825919.12133.10.camel@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34379 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab3JCSp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 14:45:26 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so2441640lbh.0
        for <linux-omap@vger.kernel.org>; Thu, 03 Oct 2013 11:45:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

There is currently a copy and paste error where the hdmi vsync timings =
are not
compared correctly, this patch fixes this.

Signed-off-by: Richard R=C3=B6jfors <richard.rojfors@gmail.com>
---
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
index 82a9640..e3ea2d5 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -391,7 +391,7 @@ static bool hdmi_timings_compare(struct omap_video_=
timings *timing1,
 		timing2_hsync =3D timing2->hfp + timing2->hsw + timing2->hbp;
 		timing1_hsync =3D timing1->hfp + timing1->hsw + timing1->hbp;
 		timing2_vsync =3D timing2->vfp + timing2->vsw + timing2->vbp;
-		timing1_vsync =3D timing2->vfp + timing2->vsw + timing2->vbp;
+		timing1_vsync =3D timing1->vfp + timing1->vsw + timing1->vbp;
=20
 		DSSDBG("timing1_hsync =3D %d timing1_vsync =3D %d"\
 			"timing2_hsync =3D %d timing2_vsync =3D %d\n",

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
