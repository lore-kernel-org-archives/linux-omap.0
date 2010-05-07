From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 01/10] OMAP4: hwmod: Replace module & device offsets by absolute clkctrl address
Date: Fri,  7 May 2010 17:44:06 +0200
Message-ID: <1273247055-15165-2-git-send-email-b-cousson@ti.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756616Ab0EGPoX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 11:44:23 -0400
In-Reply-To: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Accessing the clkctrl register using offset of module & device is hard
to do in OMAP4 due to the way the CM1, CM2, PRM and PRCM_MPU are located
in the address space. There is no common base address anymore for all the
CM registers.
The easiest way to handle that on OMAP4 is to provide the absolute address
of the XXX_CLKCTRL register per hwmod.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 36d6ea5..4965bbe 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -327,14 +327,12 @@ struct omap_hwmod_omap2_prcm {
 
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
- * @module_offs: PRCM submodule offset from the start of the PRM/CM1/CM2
- * @device_offs: device register offset from @module_offs
+ * @clkctrl_reg: PRCM address of the clock control register
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  */
 struct omap_hwmod_omap4_prcm {
-	u32 module_offs;
-	u16 device_offs;
-	u8 submodule_wkdep_bit;
+	void __iomem	*clkctrl_reg;
+	u8		submodule_wkdep_bit;
 };
 
 
-- 
1.6.1.3

