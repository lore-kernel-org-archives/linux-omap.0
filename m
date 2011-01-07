From: Koen Kooi <koen@dominion.thruhere.net>
Subject: omap: Beagle: detect new xM revision B
Date: Fri,  7 Jan 2011 10:10:13 +0100
Message-ID: <1294391413-3612-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45953 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab1AGJK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:10:26 -0500
Received: by wwa36 with SMTP id 36so18287349wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:10:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>, Koen Kooi <koen@beagleboard.org>

From: Robert Nelson <robertcnelson@gmail.com>

The xM B uses a DM3730 ES1.1 over the ES1.0 on xM A's, no other board changes.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7c82730..4fd73e7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -58,7 +58,8 @@
  *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
  *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
  *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
- *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
+ *	XMA	= GPIO173, GPIO172, GPIO171: 0 0 0
+ *	XMB	= GPIO173, GPIO172, GPIO171: 0 0 1
  */
 enum {
 	OMAP3BEAGLE_BOARD_UNKN = 0,
@@ -117,7 +118,11 @@ static void __init omap3_beagle_init_rev(void)
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
 		break;
 	case 0:
-		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
+		printk(KERN_INFO "OMAP3 Beagle Rev: xM A\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
+		break;
+	case 1:
+		printk(KERN_INFO "OMAP3 Beagle Rev: xM B\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
 		break;
 	default:
--
cgit v0.8.3.1-30-gff3a
