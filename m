From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 6/8] OMAP3 PM: Enable DPLL4 autoidle after system off.
Date: Wed, 20 Jan 2010 21:00:40 +0530
Message-ID: <1264001442-20078-7-git-send-email-thara@ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
 <1264001442-20078-4-git-send-email-thara@ti.com>
 <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53797 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab0ATPas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 10:30:48 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUjcB002046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:47 -0600
In-Reply-To: <1264001442-20078-6-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

DPLL4 autoidle is controlled through the register CM_PLL_AUTOIDLE
which is to be restored by rom code from the scratchpad in case
of a core domain context loss. But enabling this bit in scratchpad
causes rom code to take an extra 20 ms delay in the restore path.
To avoid this delay this bit is not enabled in the scratchpad today.
This means after a core off happens DPLL4 autoidle is never again
enabled back.
This patch enables DPLL4 autoidle in case of core domain losing
context.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4db1ea..6e6d954 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -520,6 +520,14 @@ void omap_sram_idle(void)
 			 */
 			if (cpu_is_omap3430())
 				usb_musb_disable_autoidle();
+			/* We do not program the scratchpad to restore back
+			 * PER DPLL in autoidle due to 20 ms delay in
+			 * rom code restore path. So enable it explicitly
+			 * after core off
+			 */
+			cm_rmw_mod_reg_bits(
+				0x0, (1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
+				PLL_MOD, CM_AUTOIDLE);
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
-- 
1.5.6.3

