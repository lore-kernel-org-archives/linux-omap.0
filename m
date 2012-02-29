From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 3/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Wed, 29 Feb 2012 16:26:58 +0200
Message-ID: <1330525621-29836-4-git-send-email-t-kristo@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33316 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab2B2O1U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 09:27:20 -0500
In-Reply-To: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

IO daisychain is a mechanism that allows individual IO pads to generate
wakeup events on their own based on a switch of an input signal level.
This allows the hardware module behind the pad to be powered down, but
still have device level capability to detect IO events, and once this
happens the module can be powered back up to resume IO. See section
3.9.4 in OMAP4430 Public TRM for details.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |   41 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h |    1 +
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a37bfd4..caa5e0f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -231,6 +231,47 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
 				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
 }
 
+/*
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
+ * the I/O ring after asserting WUCLKIN high
+ */
+#define MAX_IOPAD_LATCH_TIME 100
+
+/* OMAP4 IO Daisychain trigger sequence */
+void omap4_trigger_io_chain(void)
+{
+	int i = 0;
+
+	/* Enable GLOBAL_WUEN */
+	if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+		OMAP4_PRM_IO_PMCTRL_OFFSET) & OMAP4430_GLOBAL_WUEN_MASK))
+		omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
+			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET);
+
+	/* Trigger WUCLKIN enable */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
+			OMAP4430_WUCLK_CTRL_MASK, OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET);
+	omap_test_timeout(
+		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET) &
+			OMAP4430_WUCLK_STATUS_MASK) >>
+			OMAP4430_WUCLK_STATUS_SHIFT) == 1),
+		MAX_IOPAD_LATCH_TIME, i);
+
+	/* Trigger WUCLKIN disable */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	omap_test_timeout(
+		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET) &
+			OMAP4430_WUCLK_STATUS_MASK) >>
+			OMAP4430_WUCLK_STATUS_SHIFT) == 0),
+		MAX_IOPAD_LATCH_TIME, i);
+	return;
+}
+
 static int __init omap4xxx_prcm_init(void)
 {
 	if (cpu_is_omap44xx())
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 7978092..54a057e 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -762,6 +762,7 @@ void omap4_prm_vp_clear_txdone(u8 vp_id);
 extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+extern void omap4_trigger_io_chain(void);
 
 /* PRM interrupt-related functions */
 extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
-- 
1.7.4.1

