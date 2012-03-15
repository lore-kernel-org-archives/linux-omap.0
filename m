From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 2/3] ARM: OMAP2+: powerdomain: Add offset & mask fields to struct powerdomain
Date: Thu, 15 Mar 2012 16:36:25 +0530
Message-ID: <1331809586-24652-3-git-send-email-hvaibhav@ti.com>
References: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42332 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab2COLVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 07:21:41 -0400
In-Reply-To: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

In case of AM33xx device, there is no consistency between
PWRSTCTRL & PWRSTST register offsets in PRM space, for example -

PRM_XXX           PWRSTCTRL     PWRSTST
=======================================
PRM_PER_MOD:      0x0C,         0x08
PRM_WKUP_MOD:     0x04,         0x08
PRM_MPU_MOD:      0x00,         0x04
PRM_DEVICE_MOD:   NA,           NA

And also, there is no consistency between bit-offsets inside
PWRSTCTRL & PWRSTST register, for example -

PRM_XXX           LOGICRET  MEMON  MEMRET
=========================================
GFX_PWRCTRL:      2,        17,    6
PER_PWRCTRL:      3,        25,    29
MPU_PWRCTRL:      2,        18,    22
WKUP_PWRCTRL:     3,        NA,    NA

This means, we need to maintain and pass on all this information
through powerdomain handle; so adding fields for,
   - PWRSTCTRL/ST register offset
   - Logic retention state mask
   - mem_on/ret/pwrst/retst mask

Currently, this fields is only applicable and used for AM33XX devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/powerdomain.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..8fc50b2 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -92,6 +92,15 @@ struct powerdomain;
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @pwrstctrl_offs: (AM33XX only) XXX_PWRSTCTRL reg offset from prcm_offs
+ * @pwrstst_offs: (AM33XX only) XXX_PWRSTST reg offset from prcm_offs
+ * @logicretstate_mask: (AM33XX only) mask for logic retention bitfield
+ *	in @pwrstctrl_offs
+ * @mem_on_mask: (AM33XX only) mask for mem on bitfield in @pwrstctrl_offs
+ * @mem_ret_mask: (AM33XX only) mask for mem retention bitfield in @pwrstctrl_offs
+ * @mem_pwrst_mask: (AM33XX only) mask for mem state bitfield in @pwrstst_offs
+ * @mem_retst_mask: (AM33XX only) mask for mem retention state bitfield
+ *	in @pwrstctrl_offs
  * @state:
  * @state_counter:
  * @timer:
@@ -121,6 +130,14 @@ struct powerdomain {
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];

+	const u8 pwrstctrl_offs;
+	const u8 pwrstst_offs;
+	const u32 logicretstate_mask;
+	const u32 mem_on_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_ret_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_pwrst_mask[PWRDM_MAX_MEM_BANKS];
+	const u32 mem_retst_mask[PWRDM_MAX_MEM_BANKS];
+
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
--
1.7.0.4

