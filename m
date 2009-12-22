From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 1/3] DSS PM_WKEN to refill DMA
Date: Tue, 22 Dec 2009 15:07:50 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbZLVJh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 04:37:28 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tomi Valkeinen (tomi.valkeinen@nokia.com)" <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Subramani Venkatesh <x0108988@ti.com>

Currently, DSS doesnot wakeup when there is a DMA request.
DSS wake up event must be enabled so that the DMA request to refill
the FIFO will wake up the CORE domain.

Signed-off-by: Subramani Venkatesh <subramani.venkatesh@windriver.com>
---
 arch/arm/mach-omap2/pm34xx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 81ed252..2d11b80 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -726,6 +726,11 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
+
+	/* Enable PM_WKEN to support DSS LPR */
+	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS,
+				OMAP3430_DSS_MOD, PM_WKEN);
+
 	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
-- 
1.5.4.3


Regards,
Kishore Y

