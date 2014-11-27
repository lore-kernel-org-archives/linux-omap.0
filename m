From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 14/23] ARM: OMAP4: PRM: move omap4xxx_prm_init earlier in init order
Date: Thu, 27 Nov 2014 17:51:45 +0200
Message-ID: <1417103514-17027-15-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46255 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaK0PwA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:52:00 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP4 has different ordering of PRM and CM init calls in the early init.
Re-oder these accordingly for OMAP4 also. This is needed so that we
can do some optimizations in the following patches for the PRCM init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 9014eca..8af8411 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -618,9 +618,9 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
+	omap44xx_prm_init();
 	omap4_cm_init();
 	omap4_pm_init_early();
-	omap44xx_prm_init();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
 	omap44xx_clockdomains_init();
-- 
1.7.9.5

