From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Tue, 18 Nov 2008 13:21:00 +0100
Message-ID: <04FF9B32-1479-4D43-8657-58F9D04EEAD1@student.utwente.nl>
References: <19F8576C6E063C45BE387C64729E739403E8E67528@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--404442736"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:42012 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYKRMV2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2008 07:21:28 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E8E67528@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--404442736
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 18 nov 2008, om 13:09 heeft Hiremath, Vaibhav het volgende  
geschreven:
>>
>> I finally got rc4 working on evm and with your latest patches I get:
>>
> [Hiremath, Vaibhav] Probably you missed to apply the clock set_rate  
> and round_rate patches by Mans Rullgard.

I already have those, the problem was fixed by:

 From d90a851b63f2593d02ae306a91c36ea059f67014 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 17 Nov 2008 13:40:55 +0200
Subject: [PATCH] DSS: OMAPFB: Check that var->pixclock is not zero

---
  drivers/video/omap2/omapfb-main.c |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb-main.c b/drivers/video/omap2/ 
omapfb-main.c
index c0f1664..add65e4 100644
--- a/drivers/video/omap2/omapfb-main.c
+++ b/drivers/video/omap2/omapfb-main.c
@@ -342,6 +342,12 @@ static int check_fb_var(struct fb_info *fbi,  
struct fb_var_screeninfo *var)

  	if (display && display->check_timings) {
  		struct omap_video_timings timings;
+
+		if (var->pixclock == 0) {
+			DBG("Pixclock can't be zero.\n");
+			return -EINVAL;
+		}
+
  		timings.pixel_clock = PICOS2KHZ(var->pixclock);
  		timings.hfp = var->left_margin;
  		timings.hbp = var->right_margin;
-- 
1.6.0.3


--Apple-Mail-4--404442736
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJIrMuMkyGM64RGpERAnqtAJ9anfmPohQ5HdAd2J/48ywuBofi0gCgrhGu
JXMh5vpHTGsfKZkwAFM/d6U=
=qUw5
-----END PGP SIGNATURE-----

--Apple-Mail-4--404442736--
