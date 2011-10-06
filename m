From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] ARM: OMAP3: hwmod: fix variant registration and remove
 SmartReflex from common list
Date: Thu, 6 Oct 2011 17:24:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061723550.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com> <20111006223545.GB27281@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35719 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab1JFXYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:24:43 -0400
In-Reply-To: <20111006223545.GB27281@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Abhilash K V <abhilash.kv@ti.com>, Chase Maupin <chase.maupin@ti.com>


Commit d6504acd2125984c61dce24727dd3842d0144015 ("OMAP2+: hwmod:
remove OMAP_CHIP*") tests the inverse condition of what it should be
testing for the return value from omap_hwmod_register().  This causes
several IP blocks to not be registered on several OMAP3 family devices.

Fixing that bug also unmasked another bug, originally reported by
Chase Maupin <chase.maupin@ti.com> and then subsequently by Abhilash K
V <abhilash.kv@ti.com>, which caused SmartReflex IP blocks to be
registered on SoCs that don't support them.

Thanks to Russell King - ARM Linux <linux@arm.linux.org.uk> for comments
on a previous version of the patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Chase Maupin <chase.maupin@ti.com>
Cc: Abhilash K V <abhilash.kv@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---

This version incorporates some comments from RMK.

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ab35acb..0771dc6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3161,8 +3161,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
-	&omap34xx_sr1_hwmod,
-	&omap34xx_sr2_hwmod,
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
@@ -3240,7 +3238,7 @@ int __init omap3xxx_hwmod_init(void)
 
 	/* Register hwmods common to all OMAP3 */
 	r = omap_hwmod_register(omap3xxx_hwmods);
-	if (!r)
+	if (r < 0)
 		return r;
 
 	rev = omap_rev();
@@ -3265,7 +3263,7 @@ int __init omap3xxx_hwmod_init(void)
 	};
 
 	r = omap_hwmod_register(h);
-	if (!r)
+	if (r < 0)
 		return r;
 
 	/*
-- 
1.7.6.3

