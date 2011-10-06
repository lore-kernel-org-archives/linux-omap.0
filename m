From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP3: hwmod: fix variant registration and remove
 SmartReflex from common list
Date: Thu, 6 Oct 2011 14:39:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43843 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab1JFUj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 16:39:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, Chase Maupin <chase.maupin@ti.com>, Abhilash K V <abhilash.kv@ti.com>


Commit d6504acd2125984c61dce24727dd3842d0144015 ("OMAP2+: hwmod:
remove OMAP_CHIP*") tests the inverse condition of what it should be
testing for the return value from omap_hwmod_register().  This causes
several IP blocks to not be registered on several OMAP3 family devices.

Fixing that bug also unmasked another bug, originally reported by
Chase Maupin <chase.maupin@ti.com> and then subsequently by Abhilash K
V <abhilash.kv@ti.com>, which caused SmartReflex IP blocks to be
registered on SoCs that don't support them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Chase Maupin <chase.maupin@ti.com>
Cc: Abhilash K V <abhilash.kv@ti.com>
---

This fixes a pretty embarrassing "brown paper bag" bug of mine in one of 
the cleanup patches.  Tony, it would be good if you could send this to 
Arnd ASAP and merge into your cleanup branch.  Tested on 3430SDP, 37XX 
EVM, and OMAP3503.

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ab35acb..53b6706 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -13,6 +13,8 @@
  *
  * XXX these should be marked initdata for multi-OMAP kernels
  */
+#include <linux/err.h>
+
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
 #include <plat/cpu.h>
@@ -3161,8 +3163,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
-	&omap34xx_sr1_hwmod,
-	&omap34xx_sr2_hwmod,
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
@@ -3240,7 +3240,7 @@ int __init omap3xxx_hwmod_init(void)
 
 	/* Register hwmods common to all OMAP3 */
 	r = omap_hwmod_register(omap3xxx_hwmods);
-	if (!r)
+	if (IS_ERR_VALUE(r))
 		return r;
 
 	rev = omap_rev();
@@ -3265,7 +3265,7 @@ int __init omap3xxx_hwmod_init(void)
 	};
 
 	r = omap_hwmod_register(h);
-	if (!r)
+	if (IS_ERR_VALUE(r))
 		return r;
 
 	/*
-- 
1.7.6.3

