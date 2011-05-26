From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: [PATCH] free rev gpios when they are read, so others can read them later
Date: Thu, 26 May 2011 21:59:53 +0200
Message-ID: <2DCF0893-4166-4604-887B-EDBC3643290A@gmail.com>
References: <1306438716-68265-1-git-send-email-tasskjapp@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63515 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933056Ab1EZT74 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 15:59:56 -0400
Received: by ewy4 with SMTP id 4so385822ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 12:59:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A script of mine that reads the rev gpios on the beagleboard started fa=
iling when I upgraded to .37, since board-omap3beagle.c doesn=B4t free =
the rev gpios after using them.

Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
---
arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-om=
ap2/board-omap3beagle.c
index 3ff3a2c..8a4ac43 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -106,6 +106,9 @@ static void __init omap3_beagle_init_rev(void)
	beagle_rev =3D gpio_get_value(171) | (gpio_get_value(172) << 1)
			| (gpio_get_value(173) << 2);

+        gpio_free_array(omap3_beagle_rev_gpios,
+                        ARRAY_SIZE(omap3_beagle_rev_gpios));
+
	switch (beagle_rev) {
	case 7:
		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
--=20
1.7.3.1


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
