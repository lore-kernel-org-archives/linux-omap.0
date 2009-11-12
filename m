From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/10] omap3: 3630: update is_chip variable
Date: Wed, 11 Nov 2009 19:03:50 -0800
Message-ID: <20091112030350.5159.83339.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54334 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760044AbZKLDD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:03:58 -0500
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Alexander Shishkin <virtuoso@slind.org>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Ari Kauppi <kauppi@papupata.org>

From: vikram pandita <vikram.pandita@ti.com>

3630 is getting treated like next rev of 3430
omap_chip.oc variable has to be updated for 3630 version

Otherwise the Core power domain is not getting registered.

This gets used in the registration of power domains in:
"arch/arm/mach-omap2/powerdomains34xx.h"
core_34xx_es3_1_pwrdm
OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1)

Core power doman will get registered for 3630 only when .oc is
populated correctly.

Tested on Zoom3(3630) board

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Alexander Shishkin <virtuoso@slind.org>
Acked-by: Ari Kauppi <kauppi@papupata.org>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |    2 ++
 arch/arm/plat-omap/include/plat/cpu.h |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1c15112..189cf7a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -359,6 +359,8 @@ void __init omap2_check_revision(void)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
 		else if (omap_rev() == OMAP3430_REV_ES3_1)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+		else if (omap_rev() == OMAP3630_REV_ES1_0)
+			omap_chip.oc |= CHIP_IS_OMAP3630ES1;
 	} else {
 		pr_err("Uninitialized omap_chip, please fix!\n");
 	}
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index f4f7a2f..7babefc 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -454,6 +454,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define CHIP_IS_OMAP3430ES2		(1 << 4)
 #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
+#define CHIP_IS_OMAP3630ES1		(1 << 7)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
@@ -465,8 +466,10 @@ IS_OMAP_TYPE(3430, 0x3430)
  */
 #define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
 					 CHIP_IS_OMAP3430ES3_0 | \
-					 CHIP_IS_OMAP3430ES3_1)
-#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
+					 CHIP_IS_OMAP3430ES3_1 | \
+					 CHIP_IS_OMAP3630ES1)
+#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1 | \
+					 CHIP_IS_OMAP3630ES1)
 
 
 int omap_chip_is(struct omap_chip_id oci);

