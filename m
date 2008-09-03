From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RESEND 3][PATCH] Adding csi2_fck declaration to clock34xx.h
Date: Wed, 3 Sep 2008 11:30:43 -0500
Message-ID: <A24693684029E5489D1D202277BE894411A07DA1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42422 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbYICQav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 12:30:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Sergio Aguirre <saaguirre@ti.com>

ARM: OMAP: Add CSI2 clock struct for handling it with clock API.

Add CSI2 clock struct for handling it with clock API when TI PM is disabled.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/clock34xx.h       |   12 ++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 2 files changed, 14 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.h	2008-08-28 13:59:57.000000000 -0500
+++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.h	2008-09-03 11:33:20.000000000 -0500
@@ -2228,6 +2228,17 @@
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk csi2_96m_fck = {
+	.name		= "csi2_96m_fck",
+	.parent		= &core_96m_fck,
+	.init		= &omap2_init_clk_clkdm,
+	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "cam_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
 /* USBHOST - 3430ES2 only */
 
 static struct clk usbhost_120m_fck = {
@@ -3208,6 +3219,7 @@
 	&dss_ick,
 	&cam_mclk,
 	&cam_ick,
+	&csi2_96m_fck,
 	&usbhost_120m_fck,
 	&usbhost_48m_fck,
 	&usbhost_ick,
Index: linux-omap-2.6/arch/arm/mach-omap2/cm-regbits-34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-08-28 13:59:57.000000000 -0500
+++ linux-omap-2.6/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-09-02 17:53:48.000000000 -0500
@@ -530,6 +530,8 @@
 #define OMAP3430_CLKACTIVITY_DSS_MASK			(1 << 0)
 
 /* CM_FCLKEN_CAM specific bits */
+#define OMAP3430_EN_CSI2				(1 << 1)
+#define OMAP3430_EN_CSI2_SHIFT				1
 
 /* CM_ICLKEN_CAM specific bits */

