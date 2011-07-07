From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 12/13] OMAP4: cm: Add two new APIs for modulemode
 control
Date: Thu, 7 Jul 2011 02:32:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070231110.30028@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-13-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60737 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913Ab1GGIcl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 04:32:41 -0400
In-Reply-To: <1309554558-19819-13-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> In OMAP4, a new programming model based on module control instead
> of clock control was introduced.
> Expose two APIs to allow the upper layer (omap_hwmod) to control
> the module mode independently of the parent clocks management.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

This patch was updated to use '_cminst_' in function names that are part 
of the cminst44xx.c file, rather than '_cm_', to preserve consistency 
with the rest of the file.  Updated patch below.


- Paul


From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 1 Jul 2011 23:09:17 +0200
Subject: [PATCH] OMAP4: cm: Add two new APIs for modulemode control

In OMAP4, a new programming model based on module control instead
of clock control was introduced.
Expose two APIs to allow the upper layer (omap_hwmod) to control
the module mode independently of the parent clocks management.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: renamed 'omap4_cm_' fns to 'omap4_cminst_'; cleaned up
 kerneldoc]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   40 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    5 ++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 61e4382..2b96e72 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -271,3 +271,43 @@ int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_off
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
+
+/**
+ * omap4_cminst_module_enable - Enable the modulemode inside CLKCTRL
+ * @mode: Module mode (SW or HW)
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ *
+ * No return value.
+ */
+void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
+			    u16 clkctrl_offs)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, clkctrl_offs);
+	v &= ~OMAP4430_MODULEMODE_MASK;
+	v |= mode << OMAP4430_MODULEMODE_SHIFT;
+	omap4_cminst_write_inst_reg(v, part, inst, clkctrl_offs);
+}
+
+/**
+ * omap4_cminst_module_disable - Disable the module inside CLKCTRL
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ *
+ * No return value.
+ */
+void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
+			     u16 clkctrl_offs)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, clkctrl_offs);
+	v &= ~OMAP4430_MODULEMODE_MASK;
+	omap4_cminst_write_inst_reg(v, part, inst, clkctrl_offs);
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index a985400..f2ea645 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -20,6 +20,11 @@ extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 
+extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
+				       u16 clkctrl_offs);
+extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
+					u16 clkctrl_offs);
+
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
-- 
1.7.5.4

