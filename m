From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 1/7] ARM: OMAP3 PM: correct enable/disable of daisy io chain
Date: Fri, 7 Oct 2011 23:17:45 +0530
Message-ID: <1318009671-12813-2-git-send-email-vishwanath.bs@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab1JGRzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:12 -0400
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Mohan V <mohanv@ti.com>

Currently the enabling and disabling of IO Daisy chain is not
according to the TRM. The below steps are followed to enable/
disable the IO chain according to the "Sec 3.5.7.2.2
I/O Wake-Up Mechanism" in OMAP3630 Public TRM[1].

Steps to enable IO chain:
[a] Set PM_WKEN_WKUP.EN_IO bit
[b] Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
[c] Poll for PM_WKST_WKUP.ST_IO_CHAIN.
[d] When ST_IO_CHAIN bit set to 1, clear PM_WKEN_WKUP.EN_IO_CHAIN
[e] Clear ST_IO_CHAIN bit.

Steps to disable IO chain:
[a] Clear PM_WKEN_WKUP.EN_IO_CHAIN bit
[b] Clear PM_WKEN_WKUP.EN_IO bit
[c] Clear PM_WKST_WKUP.ST_IO bit by writing 1 to it.

Step [e] & [c] in each case can be skipped, as these are handled
by the PRCM interrupt handler later.

[1] http://focus.ti.com/pdfs/wtbu/OMAP36xx_ES1.x_PUBLIC_TRM_vV.zip

Signed-off-by: Mohan V <mohanv@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..041f6e6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -105,7 +105,7 @@ static void omap3_enable_io_chain(void)
 		/* Do a readback to assure write has been done */
 		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -113,9 +113,9 @@ static void omap3_enable_io_chain(void)
 				       "activation failed.\n");
 				return;
 			}
-			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKEN);
 		}
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
 	}
 }
 
-- 
1.7.0.4

