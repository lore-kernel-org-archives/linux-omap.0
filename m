From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [PATCH] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
Date: Tue, 18 Dec 2012 18:02:09 +0530
Message-ID: <1355833929-25387-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47013 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab2LRMcE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Dec 2012 07:32:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, gururaja.hebbar@ti.com, linux@arm.linux.org.uk

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

omap4_cminst_wait_module_ready() checks if register offset is NULL.

int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
				   u16 clkctrl_offs)
{
	int i = 0;

	if (!clkctrl_offs)
		return 0;

In case of AM33xx, not all clock domains have CLKSTCTRL at 0x00. An
example of this would be the RTC clock domain. In such cases the
module ready check is skipped which leads to a data abort during bootup
when RTC registers is accessed.

Since the actual base address is verified in
omap4_cminst_read_inst_reg(), this check here is not required at all
and hence can be removed.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:100644 100644 7f9a464... 40545ff... M	arch/arm/mach-omap2/cminst44xx.c
 arch/arm/mach-omap2/cminst44xx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 7f9a464..40545ff 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -271,9 +271,6 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(part, inst, cdoffs, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.7.9.5

