From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] ARM: OMAP: hmwod: Add support for per hwmod/module context lost count
Date: Thu, 3 Nov 2011 16:24:23 +0530
Message-ID: <1320317665-6381-2-git-send-email-rnayak@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51443 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab1KCKyw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Nov 2011 06:54:52 -0400
In-Reply-To: <1320317665-6381-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

OMAP4 has module specific context lost registers which
makes it now possible to have module level context loss
count, instead of relying on the powerdomain level context
count.

Add 2 private hwmod api's to update/clear the hwmod/module specific
context lost counters/register.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d713807..d7f9dd1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1426,6 +1426,32 @@ static int _reset(struct omap_hwmod *oh)
 	return ret;
 }
 
+static void _update_context_lost(struct omap_hwmod *oh)
+{
+	if (oh->prcm.omap4.context_offs)
+		if (omap4_prminst_read_inst_reg(
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.context_offs))
+				oh->prcm.omap4.context_lost_counter++;
+}
+
+static void _clear_context_lost(struct omap_hwmod *oh)
+{
+	u32 context_reg;
+
+	if (oh->prcm.omap4.context_offs) {
+		context_reg = omap4_prminst_read_inst_reg(
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.context_offs);
+		omap4_prminst_write_inst_reg(context_reg,
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.context_offs);
+	}
+}
+
 /**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 5419f1a..540e424 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -363,12 +363,14 @@ struct omap_hwmod_omap2_prcm {
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
  * @clkctrl_reg: PRCM address of the clock control register
  * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * context_lost_counter: Count of module level context lost
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
 	u16		rstctrl_offs;
 	u16		context_offs;
+	unsigned	context_lost_counter;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
 };
-- 
1.7.1

