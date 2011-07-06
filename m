From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/5] OMAP4: powerdomain data: Fix core mem states and
 missing cefuse flag
Date: Tue, 5 Jul 2011 23:50:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052348430.4217@utopia.booyaka.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com> <1309552060-4547-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46734 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1GFFu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:50:59 -0400
In-Reply-To: <1309552060-4547-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Since ES2.0, the core ocmram does not support a different state
> than the main power domain anymore during both ON and RET power
> domain state.
> Since PM is not supported at all in ES1.0, update the common
> structure.
> 
> LOWPOWERSTATECHANGE is supported by the cefuse power domain but
> the flag was missing.
> Add the PWRDM_HAS_LOWPOWERSTATECHANGE in flags field.
> 
> Indent all previous flags to be aligned with other fields.
> 
> Update the TI copyright date to 2011.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

I've removed the indentation changes from this patch; those will be split 
into a different series, and queued this patch for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'hardware_updates_a_3.1' branch.
Updated patch follows.


- Paul

From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 5 Jul 2011 23:44:32 -0600
Subject: [PATCH] OMAP4: powerdomain data: Fix core mem states and missing
 cefuse flag

Since ES2.0, the core ocmram does not support a different state
than the main power domain anymore during both ON and RET power
domain state.
Since PM is not supported at all in ES1.0, update the common
structure.

LOWPOWERSTATECHANGE is supported by the cefuse power domain but
the flag was missing.
Add the PWRDM_HAS_LOWPOWERSTATECHANGE in flags field.

Update the TI copyright date to 2011.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
[paul@pwsan.com: moved the indentation changes to a different patch set]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index c4222c7..631e452 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 Power domains framework
  *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
  * Copyright (C) 2009-2011 Nokia Corporation
  *
  * Abhijit Pagare (abhijitpagare@ti.com)
@@ -41,14 +41,14 @@ static struct powerdomain core_44xx_pwrdm = {
 	.banks		  = 5,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF,	/* core_nret_bank */
-		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
+		[1] = PWRSTS_RET,	/* core_ocmram */
 		[2] = PWRSTS_RET,	/* core_other_bank */
 		[3] = PWRSTS_OFF_RET,	/* ducati_l2ram */
 		[4] = PWRSTS_OFF_RET,	/* ducati_unicache */
 	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* core_nret_bank */
-		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
+		[1] = PWRSTS_ON,	/* core_ocmram */
 		[2] = PWRSTS_ON,	/* core_other_bank */
 		[3] = PWRSTS_ON,	/* ducati_l2ram */
 		[4] = PWRSTS_ON,	/* ducati_unicache */
@@ -318,6 +318,7 @@ static struct powerdomain cefuse_44xx_pwrdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /*
-- 
1.7.5.4

