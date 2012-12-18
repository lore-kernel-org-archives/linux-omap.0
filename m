From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
Date: Tue, 18 Dec 2012 18:26:18 +0530
Message-ID: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48213 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab2LRM4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Dec 2012 07:56:03 -0500
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

In case of AM33xx, CLKCTRL register offset for different clock domains
are not uniformly placed. An example of this would be the RTC clock
domain with CLKCTRL offset at 0x00.
In such cases the module ready check is skipped which leads to a data
abort during boot-up when RTC registers is accessed.

Since the actual base address is verified in
omap4_cminst_read_inst_reg(), this check here is not required at all
and hence can be removed.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes in v2:
	- update commit message to reflect the actual cause. Previous
	message conveyed a wrong/opposite message.

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

