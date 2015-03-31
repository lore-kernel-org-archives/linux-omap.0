From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 07/34] ARM: OMAP4: PRM: move omap4xxx_prm_init earlier in init order
Date: Tue, 31 Mar 2015 22:14:00 +0300
Message-ID: <1427829267-32077-8-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbbCaTOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2015 15:14:45 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP4 has different ordering of PRM and CM init calls in the early init.
Re-oder these accordingly for OMAP4 also. This is needed so that we
can do some optimizations in the following patches for the PRCM init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 364b530..460da22 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -654,9 +654,9 @@ void __init omap4430_init_early(void)
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

