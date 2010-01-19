From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP CPU ID: fix OMAP4 build failure
Date: Tue, 19 Jan 2010 14:14:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38247 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0ASVOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 16:14:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: abhijit.pagare@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello Abhijit,

it seems that my for_2.6.34 branch does not build unless the following 
patch, or one like it, is included.  Any comments?


- Paul


From: Paul Walmsley <paul@pwsan.com>


omap_4430sdp_defconfig currently does not build due to some missing CPU IDs:

In file included from arch/arm/mach-omap2/powerdomains.h:59,
                 from arch/arm/mach-omap2/io.c:42:
arch/arm/mach-omap2/powerdomains44xx.h:39: error: 'CHIP_IS_OMAP4430' undeclared here (not in a function)

... so add CHIP_IS_OMAP4430ES1.  Note that this is not yet set by
mach-omap2/id.c; this is for TI to fix.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Abhijit Pagare <abhijit.pagare@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 9a028bd..8ada0ef 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -44,7 +44,7 @@
 int omap_type(void);
 
 struct omap_chip_id {
-	u8 oc;
+	u16 oc;
 	u8 type;
 };
 
@@ -470,8 +470,10 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
 #define CHIP_IS_OMAP3630ES1		(1 << 7)
+#define CHIP_IS_OMAP4430ES1		(1 << 8)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
+#define CHIP_IS_OMAP4430		CHIP_IS_OMAP4430ES1
 
 /*
  * "GE" here represents "greater than or equal to" in terms of ES
-- 
1.6.6.rc2.5.g49666

