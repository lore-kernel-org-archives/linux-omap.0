From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [Patch v2 1/2] ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST flags
Date: Thu, 31 Jan 2013 19:55:26 +0530
Message-ID: <1359642327-5542-2-git-send-email-gururaja.hebbar@ti.com>
References: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51223 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab3AaO10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 09:27:26 -0500
In-Reply-To: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, gururaja.hebbar@ti.com, linux@arm.linux.org.uk, hvaibhav@ti.com, vaibhav.bedia@ti.com

struct omap_hwmod records belonging to wkup m3 domain is missing
HWMOD_NO_IDLEST flags; add them.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
---
Change in v2:
	- new patch

:100644 100644 646c14d... 1ab693e... M	arch/arm/mach-omap2/omap_hwmod_33xx_data.c
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 646c14d..1ab693e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -262,7 +262,8 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.name		= "wkup_m3",
 	.class		= &am33xx_wkup_m3_hwmod_class,
 	.clkdm_name	= "l4_wkup_aon_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,	/* Keep hardreset asserted */
+	/* Keep hardreset asserted */
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
 	.mpu_irqs	= am33xx_wkup_m3_irqs,
 	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
-- 
1.7.9.5

