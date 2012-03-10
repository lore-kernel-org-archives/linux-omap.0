From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 1/6] ARM: OMAP3 PM: correct enable/disable of daisy io
 chain
Date: Fri, 9 Mar 2012 20:48:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203092047410.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56912 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab2CJDsl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 22:48:41 -0500
In-Reply-To: <1331046702-2472-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

Hi

On Tue, 6 Mar 2012, Tero Kristo wrote:

> From: Mohan V <mohanv@ti.com>
> 
> Currently the enabling and disabling of IO Daisy chain is not
> according to the TRM. The below steps are followed to enable/
> disable the IO chain according to the "Sec 3.5.7.2.2
> I/O Wake-Up Mechanism" in OMAP3630 Public TRM[1].
> 
> Steps to enable IO chain:
> [a] Set PM_WKEN_WKUP.EN_IO bit
> [b] Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
> [c] Poll for PM_WKST_WKUP.ST_IO_CHAIN.
> [d] When ST_IO_CHAIN bit set to 1, clear PM_WKEN_WKUP.EN_IO_CHAIN
> [e] Clear ST_IO_CHAIN bit.
> 
> Steps to disable IO chain:
> [a] Clear PM_WKEN_WKUP.EN_IO_CHAIN bit
> [b] Clear PM_WKEN_WKUP.EN_IO bit
> [c] Clear PM_WKST_WKUP.ST_IO bit by writing 1 to it.
> 
> Step [e] & [c] in each case can be skipped, as these are handled
> by the PRCM interrupt handler later.
> 
> [1] http://focus.ti.com/pdfs/wtbu/OMAP36xx_ES1.x_PUBLIC_TRM_vV.zip
> 
> Signed-off-by: Mohan V <mohanv@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>

I modified the commit message to better reflect the reality of what's in 
the TRM.  Updated version is below.


- Paul

From: Mohan V <mohanv@ti.com>
Date: Fri, 2 Mar 2012 17:17:50 +0200
Subject: [PATCH 1/6] ARM: OMAP3: PM: correct enable/disable of daisy io chain

Currently the enabling and disabling of IO Daisy chain is not
according to the TRM. The below steps are followed to enable/
disable the IO chain, based loosely on the "Sec 3.5.7.2.2
I/O Wake-Up Mechanism" section in OMAP3630 Public TRM[1].

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
[paul@pwsan.com: modified commit message to clarify that these steps are
 based loosely on the TRM section, rather than documented exactly]
Reviewed-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..b0821a8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -94,16 +94,17 @@ static void omap3_enable_io_chain(void)
 	/* Do a readback to assure write has been done */
 	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
 		 OMAP3430_ST_IO_CHAIN_MASK)) {
 		timeout++;
 		if (timeout > 1000) {
 			pr_err("Wake up daisy chain activation failed.\n");
 			return;
 		}
-		omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					   WKUP_MOD, PM_WKEN);
 	}
+	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+			PM_WKEN);
+
 }
 
 static void omap3_disable_io_chain(void)
-- 
1.7.9.1

