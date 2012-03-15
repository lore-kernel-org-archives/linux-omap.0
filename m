From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 1/3] ARM: OMAP3/4: omap_hwmod: Add rstst_off field to struct omap_hwmod_omap4_prcm
Date: Thu, 15 Mar 2012 16:36:24 +0530
Message-ID: <1331809586-24652-2-git-send-email-hvaibhav@ti.com>
References: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42333 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab2COLVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 07:21:41 -0400
In-Reply-To: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

In case of AM33XX device, XXX_RSTST register offset is not
consistent across PRM modules/instances,

PRM_XXX            RSTST
=========================
PRM_PER_MOD:       0x04
PRM_WKUP_MOD:      0x0C
PRM_MPU_MOD:       NA
PRM_DEVICE_MOD:    0x08

This means, we need to pass on XXX_RSTST register offset
information through omap_hwmod data, similar to XXX_RSTCTRL.

Currently, this field is only applicable and used for AM33XX devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index ce75c30..1cfa008 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -377,11 +377,13 @@ struct omap_hwmod_omap2_prcm {
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
  * @clkctrl_reg: PRCM address of the clock control register
  * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
+ * @rstst_reg: (AM33XX Only) address of the XXX_RSTST register located in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
 	u16		rstctrl_offs;
+	u16		rstst_offs;
 	u16		context_offs;
 	u8		submodule_wkdep_bit;
 	u8		modulemode;
--
1.7.0.4

