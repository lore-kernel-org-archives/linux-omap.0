From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/22] OMAP4: hwmod: Replace module & device offsets by
	absolute clkctrl address
Date: Tue, 18 May 2010 20:18:38 -0600
Message-ID: <20100519021836.19716.54360.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39769 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab0ESCU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:20:58 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Accessing the clkctrl register using offset of module & device is hard
to do in OMAP4 due to the way the CM1, CM2, PRM and PRCM_MPU are located
in the address space. There is no common base address anymore for all the
CM registers.
The easiest way to handle that on OMAP4 is to provide the absolute address
of the XXX_CLKCTRL register per hwmod.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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
 
 


